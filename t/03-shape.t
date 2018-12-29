use v6.c;

#use Grammar::Tracer;

constant BULLET = '•';

my $text = q:to/T/.chomp;
The GNOME project provides two things:
  • The GNOME desktop environment
  • The GNOME development platform
  • Planet GNOME
T

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
   method OP        { $!cr.close_path                  }
   method OP-M($/)  { $!cr.move_to(  |$/<point>.made ) }
   method OP-L($/)  { $!cr.line_to(  |$/<point>.made ) }
   method OP-C($/)  { $!cr.curve_to( |@( $/<point> ).map( *.made ).flat ) }
}

my %gnomeFootLogo = ( width => 96.2152, height => 118.26 );
%gnomeFootLogo<path> = q:to/T/.chomp;
M 86.068,1 C 61.466,0 56.851,35.041 70.691,35.041 C 84.529,35.041 110.671,0 86.068,0 z
M 11.445,48.453 C 16.686,46.146 12.12,23.581 3.208,29.735 C -5.7,35.89 6.204,50.759 11.445,48.453 z
M 45.217,30.699 C 52.586,31.149 60.671,2.577 46.821,4.374 C 32.976,6.171 37.845,30.249 45.217,30.699 z
M 26.212,36.642 C 32.451,35.37 32.793,9.778 21.667,14.369 C 10.539,18.961 19.978,37.916 26.212,36.642 L 26.212,36.642 z
M 58.791,93.913 C 59.898,102.367 52.589,106.542 45.431,101.092 C 22.644,83.743 83.16,75.088 79.171,51.386 C 75.86,31.712 15.495,37.769 8.621,68.553 C 3.968,89.374 27.774,118.26 52.614,118.26 C 64.834,118.26 78.929,107.226 81.566,93.248 C 83.58,82.589 57.867,86.86 58.791,93.913 L 58.791,93.913 z
T

sub mini_svg_render ($c, $dp) {
  my ($x, $y) = $c.get_current_point;
  $c.translate($x, $y);

  my $p = MiniSVG.parse(
    %gnomeFootLogo<path>, actions => MiniSVGAction.new( cr => $c )
  );
  $c.fill if $!dp;
}

sub mini_svg_shape_renderer ($c, $a, $dp, $d) {
  my $sx = $a.ink_rect.width  / (PANGO_SCALE * %gnomeFootLogo<width>);
  my $sy = $a.ink_rect.height / (PANGO_SCALE * %gnomeFootLogo<height>);
  $c.move_to($a.ink_rect.x / PANGO_SCALE, $a.ink_rect.y / PANGO_SCALE);
  $c.scale($sx, $sy);
  mini_svg_render($c, $dp);
}
