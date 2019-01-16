use v6.c;

use NativeCall;
use Cairo;

use Pango::Raw::Types;

use Pango::Attr;
use Pango::AttrList;
use Pango::Cairo;

#constant BULLET = '•';
constant BULLET = '*';

class MiniSvg is repr('CStruct') {
  has num64 $.width  is rw;
  has num64 $.height is rw;
  has Str   $!path;

  method path is rw {
    use nqp;
    Proxy.new:
      FETCH => -> $ { $!path },
      STORE => -> $, Str() $new {
        nqp::bindattr(
          nqp::decont(self), MiniSvg, '$!path', nqp::unbox_s($new)
        );
      }
  }
}

my $text = q:to/TEXT/.chomp;
The GNOME project provides two things:
  * The GNOME desktop environment
  * The GNOME development platform
  * Planet GNOME
TEXT

# my %gnomeFootLogo = ( width => 96.2152, height => 118.26 );
# %gnomeFootLogo<path> = q:to/P/.chomp;
# M 86.068,1 C 61.466,0 56.851,35.041 70.691,35.041 C 84.529,35.041 110.671,0 86.068,0 z
# M 11.445,48.453 C 16.686,46.146 12.12,23.581 3.208,29.735 C -5.7,35.89 6.204,50.759 11.445,48.453 z
# M 45.217,30.699 C 52.586,31.149 60.671,2.577 46.821,4.374 C 32.976,6.171 37.845,30.249 45.217,30.699 z
# M 26.212,36.642 C 32.451,35.37 32.793,9.778 21.667,14.369 C 10.539,18.961 19.978,37.916 26.212,36.642 L 26.212,36.642 z
# M 58.791,93.913 C 59.898,102.367 52.589,106.542 45.431,101.092 C 22.644,83.743 83.16,75.088 79.171,51.386 C 75.86,31.712 15.495,37.769 8.621,68.553 C 3.968,89.374 27.774,118.26 52.614,118.26 C 64.834,118.26 78.929,107.226 81.566,93.248 C 83.58,82.589 57.867,86.86 58.791,93.913 L 58.791,93.913 z
# P

my $GFL = MiniSvg.new( width => 96.2152.Num, height => 118.26.Num );
$GFL.path = q:to/P/.chomp;
M 86.068,1 C 61.466,0 56.851,35.041 70.691,35.041 C 84.529,35.041 110.671,0 86.068,0 z
M 11.445,48.453 C 16.686,46.146 12.12,23.581 3.208,29.735 C -5.7,35.89 6.204,50.759 11.445,48.453 z
M 45.217,30.699 C 52.586,31.149 60.671,2.577 46.821,4.374 C 32.976,6.171 37.845,30.249 45.217,30.699 z
M 26.212,36.642 C 32.451,35.37 32.793,9.778 21.667,14.369 C 10.539,18.961 19.978,37.916 26.212,36.642 L 26.212,36.642 z
M 58.791,93.913 C 59.898,102.367 52.589,106.542 45.431,101.092 C 22.644,83.743 83.16,75.088 79.171,51.386 C 75.86,31.712 15.495,37.769 8.621,68.553 C 3.968,89.374 27.774,118.26 52.614,118.26 C 64.834,118.26 78.929,107.226 81.566,93.248 C 83.58,82.589 57.867,86.86 58.791,93.913 L 58.791,93.913 z
P

grammar MiniSVG {
   regex TOP  { <OP>+                    }
    regex OP  { <OPS>+ 'z' \v+           }
   regex OPS  { <OP-M> | <OP-C> | <OP-L> }
  token point { <x=num> ',' <y=num>      }
   rule OP-M  { 'M' <point>              }
   rule OP-C  { 'C' <point> ** 3         }
   rule OP-L  { 'L' <point>              }
    token num {  '-'? \d+ [ '.' \d+ ]?   }
}
class MiniSVGAction {
   has $.cr;

   submethod BUILD (:$!cr) { }

   method num($/)   { make $/.Num;                     }
   method point($/) { make ($/<x>.made, $/<y>.made)    }
   method OP($/)    { $!cr.close_path                  }
   method OP-M($/)  { $!cr.move_to(  |$/<point>.made ) }
   method OP-L($/)  { $!cr.line_to( |$/<point>.made )  }
   method OP-C($/)  { $!cr.curve_to( |@( $/<point> ).map( *.made ).flat ) }
}

sub mini_svg_render (Cairo::cairo_t $c, uint32 $dp) {
  my num64 ($x, $y);
  $c.get_current_point($x, $y);
  $c.translate($x, $y);

  my $p = MiniSVG.parse(
    #%gnomeFootLogo<path>, actions => MiniSVGAction.new( cr => $c )
    $GFL.path, actions => MiniSVGAction.new( cr => $c )
  );
  $c.fill if $dp;
}

sub mini_svg_shape_renderer (Cairo::cairo_t $c, PangoAttrShape $a, uint32 $dp, $d) {
  # my $sx = $a.ink_rect.width  / (PANGO_SCALE * %gnomeFootLogo<width>);
  # my $sy = $a.ink_rect.height / (PANGO_SCALE * %gnomeFootLogo<height>);
  my $sx = $a.ink_rect.width  / (PANGO_SCALE * $GFL.width);
  my $sy = $a.ink_rect.height / (PANGO_SCALE * $GFL.height);
  my ($mx, $my) = ($a.ink_rect.x / PANGO_SCALE, $a.ink_rect.y / PANGO_SCALE);
  $c.move_to($mx.Num, $my.Num);
  $c.scale($sx.Num, $sy.Num);
  mini_svg_render($c, $dp);
}

sub get_layout($c) {
  my $pc = Pango::Cairo.new($c);
  my $layout = $pc.create_layout;
  my $ir = PangoRectangle.new(
    1 * PANGO_SCALE, -11 * PANGO_SCALE,  8 * PANGO_SCALE, 10 * PANGO_SCALE
  );
  my $lr = PangoRectangle.new(
    0 * PANGO_SCALE, -12 * PANGO_SCALE, 10 * PANGO_SCALE, 12 * PANGO_SCALE
  );

  say "IR: { $ir.gist }";
  say "LR: { $lr.gist }";

  $layout.text = $text;
  $pc.context_set_shape_renderer(&mini_svg_shape_renderer);

  my $s = $pc.context_get_shape_renderer();
  my $attrs = Pango::AttrList.new;

  for ( $text ~~ m:g/"{ BULLET }"/ ) -> $m {
    my $attr = Pango::Attr.shape_new_with_data($ir, $lr, $GFL);

    $attr.attr.start_index = $m.from;
    $attr.attr.end_index   = $m.to;
    $attrs.insert($attr);
  }
  $layout.attributes = $attrs;
  $layout;
}

sub draw_text($c, $w is rw, $h is rw) {
  my $layout = get_layout($c);

  without $w {
    without $h {
      ($w, $h) = $layout.get_pixel_size »+« (20, 20);
    }
  }

  $c.move_to(10, 10);
  Pango::Cairo.new($c).show_layout($layout);
}

sub MAIN ($filename = "pango-shape.png") {
  my ($w, $h);
  my $surface = Cairo::Image.create(FORMAT_ARGB32, 0, 0);
  my $c = Cairo::Context.new($surface);

  draw_text($c, $w, $h);
  $surface = Cairo::Image.create(FORMAT_ARGB32, $w, $h);
  $c = Cairo::Context.new($surface);

  $c.rgb(1, 1, 1);
  $c.paint;
  $c.rgb(0, 0, 0.5);
  draw_text($c, $, $);

  try {
    CATCH { default { die "Could not save png to $filename: { .message }" } }
    $surface.write_png($filename);
  }
}
