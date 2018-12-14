use v6.c;

use Cairo;
use Pango::Cairo;
use Pango::FontDescription;

sub fancy_cairo_stroke($c, $preserve) {
  # say 'Fancy stroke';
  my @dash = (10, 10);
  #
  # # Dashed

  $c.save;
  $c.rgb(1, 0, 0);
  my $line_width = $c.line_width;
  my $path := $c.copy_path;
  $c.new_path;
  $c.save;
  $c.line_width /= 3;
  $c.set_dash(@dash, 0);
  # The easy way. (Remember to either bind or decontainerize, with <>!)
  for $path -> $p {
    given $p[0].data-type {
      when PATH_MOVE_TO | PATH_LINE_TO {
        $c.move_to($p[1].point.x, $p[1].point.y);
      }
      when PATH_CURVE_TO {
        $c.line_to($p[1].point.x, $p[1].point.y);
        $c.move_to($p[2].point.x, $p[2].point.y);
        $c.line_to($p[3].point.x, $p[3].point.y);
      }
    }
  }
  $c.stroke;
  $c.restore;

  # # Points
  say "CP2: ({ $c.get_current_point.join(', ') })";
  $c.save;
  $c.rgb(0, 1, 0);
  $c.line_width = $line_width * 4;
  $c.line_cap = LINE_CAP_ROUND;

  my $first = True;
  for $path -> $p {
    given $p[0].data-type {
      when PATH_MOVE_TO {
        say "P Move to: { $p[1].point.x }, { $p[1].point.y }";
        $c.move_to($p[1].point.x, $p[1].point.y);
      }
      when PATH_LINE_TO {
        say "P2 Line to: { $p[1].point.x }, { $p[1].point.y }";
        $c.line_to(0, 0, :relative);
        $c.move_to($p[1].point.x, $p[1].point.y);
      }
      when PATH_CURVE_TO {
        $c.line_to(0, 0, :relative);
        say "P3 Line to: { $p[1].point.x }, { $p[1].point.y }";
        $c.move_to($p[1].point.x, $p[1].point.y);
        $c.line_to(0, 0, :relative);
        say "P3 Line to: { $p[2].point.x }, { $p[2].point.y }";
        $c.move_to($p[2].point.x, $p[2].point.y);
        $c.line_to(0, 0, :relative);
        say "P3 Line to: { $p[3].point.x }, { $p[3].point.y }";
        $c.move_to($p[3].point.x, $p[3].point.y);
      }
      when PATH_CLOSE_PATH {
        $c.line_to(0, 0, :relative);
      }
    }
  }
  $c.line_to(0, 0, :relative);
  $c.stroke;
  $c.restore;

  say "CP3: ({ $c.get_current_point.join(', ') })";
  $c.rgb(0, 0, 1);
  for $path -> $p {
    given $p[0].data-type {
      when PATH_MOVE_TO {
        say "Move to: { $p[1].point.x }, { $p[1].point.y }";
        $c.move_to($p[1].point.x, $p[1].point.x);
      }
      when PATH_LINE_TO {
        say "Line to: { $p[1].point.x }, { $p[1].point.y }";
        $c.line_to($p[1].point.x, $p[1].point.y);
      }
      when PATH_CURVE_TO {
        say qq:to/CURVE/.chomp;
Curve to: ({
  $p[1].point.x }, { $p[1].point.y }), ({
  $p[2].point.x }, { $p[2].point.y }), ({
  $p[3].point.x }, { $p[3].point.y })
CURVE

        $c.curve_to($p[1].point.x, $p[1].point.y,
                    $p[2].point.x, $p[2].point.y,
                    $p[3].point.x, $p[3].point.y);
      }
      when PATH_CLOSE_PATH {
        say 'Closing';
        $c.close_path;
      }
    }
  }
  $c.stroke;
  $c.append_path($path) if $preserve;
  $c.restore;
}

sub two_points_distance ($a, $b --> num64) {
  my num64 ($dx, $dy) = ( $b.point.x - $a.point.x, $b.point.y - $a.point.y );
  ($dx² + $dy²).sqrt;
}

sub curve_length(*@xy is copy) {
  my $current_point;
  my num64 $length = 0.Num;
  my $c = Cairo::Context.create( Cairo::Image.create(FORMAT_A8, 0, 0) );
  my $path = $c.copy_path(:flat);
  @xy .= rotor(2);

  $c.move_to(|@xy[0]);
  $c.curve_to(|(@xy[1..3].flat));
  # Instead of binding, we decontainerize to allow looping over $path
  for $path<> -> $p {
    given $p[0].data-type {
      when PATH_MOVE_TO {
        $current_point = $p[1];
      }
      when PATH_LINE_TO {
        $length += two_points_distance($current_point, $p[1]);
        $current_point = $p[1];
      }
    }
  }
  $c.destroy;
  $length;
}

sub parameterize_path($path) {
  my num64 @p;
  my ($cp, $lmt) = (cairo_path_data_t.new xx 2);

  # The hard way.
  loop (my $i = 0; $i < $path.num_data; $i += $path.data[$i].header.length) {
    my $d = $path.get_data($i);
    @p[$i] = 0.Num;
    given $d[0].data-type {
      when PATH_MOVE_TO {
        $cp = $lmt = $d[1];
      }
      when PATH_CLOSE_PATH | PATH_LINE_TO {
        my $dd = $_ == PATH_CLOSE_PATH ?? $lmt !! $d[1];
        @p[$i] = two_points_distance($cp, $dd);
        $cp = $d[1];
      }
      when PATH_CURVE_TO {
        @p[$i] = curve_length(  $cp.point.x,   $cp.point.y,
                              $d[1].point.x, $d[1].point.y,
                              $d[2].point.x, $d[2].point.y,
                              $d[3].point.x, $d[3].point.y);
        $cp = $d[3];
      }
    }
  }
  @p;
}

sub transform_path($path, &f:($, $, $), $c) {
  for $path<> -> $p {
    given $p[0].data-type {
      when PATH_CURVE_TO {
        f($c, $p[3].point.x, $p[3].point.y);
        f($c, $p[2].point.x, $p[2].point.y);
        proceed;
      }
      when PATH_CURVE_TO | PATH_MOVE_TO | PATH_LINE_TO {
        f($c, $p[1].point.x, $p[1].point.y);
      }
    }
  }
}

sub point_on_path(%param, num64 $x is rw, num64 $y is rw) {
  my ($the_x, $the_y, $dx, $dy, %r) = ($x, $y);
  my ($cp, $lmt) = (cairo_path_data_t.new xx 2);
  my num64 $ratio;
  my $parameter = %param<parameterization>;

  my $i;
  loop (
    $i = 0;
    $i + %param<path>.data[$i].length < %param<path>.num_data &&
      ($the_x > $parameter[$i] ||
       %param<path>.data[$i].data-type == PATH_MOVE_TO);
    $i += %param<path>.data[$i].length
  ) {
    #say "I: $i / { %param<path>.num_data }";
    my $d = %param<path>.get_data($i);

    $the_x -= $parameter[$i];
    given $d[0].data-type {
      when PATH_MOVE_TO  { $lmt = $cp = $d[1]; }
      when PATH_LINE_TO  { $cp = $d[1];        }
      when PATH_CURVE_TO { $cp = $d[3];        }
    }

    $d = %param<path>.get_data($i);
    given $d[0].data-type  {
      when PATH_CLOSE_PATH | PATH_LINE_TO {
        my $dd := $_ == PATH_CLOSE_PATH ?? $lmt !! $d[1];
        $ratio = $the_x / $parameter[$i];
        $x = $cp.point.x * (1 - $ratio) + $dd.point.x * $ratio;
        $y = $cp.point.y * (1 - $ratio) + $dd.point.y * $ratio;

        $dx = -($cp.point.x - $dd.point.x);
        $dy = -($cp.point.y - $dd.point.y);

        $ratio = $the_y / $parameter[$i];
        ($x, $y) »+=« (-$dy * $ratio, $dx * $ratio);
      }
      when PATH_CURVE_TO {
        $ratio = $the_x / $parameter[$i];
        %r<0_1 1_0> = ($ratio, 1 - $ratio);
        %r<2_0 0_2> = (%r<1_0>², %r<0_1>²);
        %r<3_0 0_3> = (%r<2_0> * %r<1_0>, %r<0_1> * %r<0_2>);
        %r<2_1 1_2> = (%r<2_0> * %r<0_1>, %r<1_0> * %r<0_2>);
        %r<1_4_10_3_20> = 1 - 4 * %r<1_0> + 3 * %r<2_0>;
        %r<2_10_3_20> = 2 * %r<2_0> - 3 * %r<2_0>;

        # Better polynomial
        $x = (       $cp.point.x * %r<0_3>,
               3 * $d[1].point.x * %r<1_2>,
               3 * $d[2].point.x * %r<2_1>,
                   $d[3].poinx.x + %r<3_0> ).sum;
        $y = (       $cp.point.y * %r<0_3>,
               3 * $d[1].point.y * %r<1_2>,
               3 * $d[2].point.y * %r<2_1>,
                   $d[3].point.y * %r<3_0> ).sum;

        # Better gradient
        $dx = ( -3 *   $cp.point.x *         %r<0_2>,
                 3 * $d[1].point.x * %r<1_4_10_3_20>,
                 3 * $d[2].point.x *   %r<2_10_3_20>,
                 3 * $d[3].point.x *         %r<2_0>).sum;
        $dy = ( -3 *   $cp.point.y *         %r<0_2>,
                 3 * $d[1].point.y * %r<1_4_10_3_20>,
                 3 * $d[2].point.y *   %r<2_10_3_20>,
                 3 * $d[3].point.y *         %r<2_0>).sum;

        $ratio = $the_y / ($dx² + $dy²).sqrt;
        ($x, $y) »+=« (-$dy * $ratio, $dx * $ratio);
      }
    }
  }
}

sub map_path_onto($c, $path) {
  my %param = ( path => $path, parameterization => parameterize_path($path) );

  my $cp = $c.copy_path;
  $c.new_path;
  transform_path($cp, &point_on_path, %param);
  $c.append_path($cp);
  $path.destroy;
}

sub draw_text($c, $x, $y, $f, $t) {
  my $font_opts = Cairo::FontOptions.new;
  $font_opts.hint_style = CAIRO_HINT_STYLE_NONE;
  $font_opts.hint_metrics = CAIRO_HINT_METRICS_OFF;
  $c.font_options = $font_opts;

  my $layout = Pango::Cairo.create_layout($c.context);
  my $desc = Pango::FontDescription.new_from_string($f);
  $layout.font_description = $desc;
  $layout.text = $t;
  my $line = $layout.get_line_readonly(0);
  $c.move_to($x, $y);
  Pango::Cairo.new($c.context, :!update).layout_line_path($line);

  $font_opts.destroy, $desc.free
}

sub draw_twisted($c, $x, $y, $f, $t) {
  $c.save;
  $c.tolerance = 0.01;
  my $path = $c.copy_path(:flat);
  $c.new_path;
  draw_text($c, $x, $y, $f, $t);
  map_path_onto($c, $path);
  $c.fill(:preserve);
  $c.save;
  $c.rgb(0.1, 0.1, 0.1);
  $c.stroke;
  $c.restore;
  $c.restore;
}

sub draw_dream($c) {
  $c.move_to(50, 650);
  $c.line_to(250, 50, :relative);
  $c.curve_to(250, 50, 600, -50, 600, -250, :relative);
  $c.curve_to(0, -400, -300, -100, -800, -300, :relative);
  $c.line_width = 1.5;
  $c.rgba(0.3, 0.3, 1.0, 0.3);
  fancy_cairo_stroke($c, True);

  $c.new_path; # Debug only
  #draw_twisted($c, 0, 0, 'Serif 72', 'It was a dream... Oh Just a dream');
}

sub draw_wow($c) {
  $c.move_to(400, 780);
  $c.curve_to(50, -50, 150, -50, 200, 0, :relative);
  $c.scale(1, 2);
  $c.line_width = 2;
  $c.rgba(0.3, 1.0, 0.3, 1.0);
  fancy_cairo_stroke($c, True);
  #draw_twisted($c, -20, -150, 'Serif 60', 'WOW!');
}

sub MAIN($output_filename) {
  my $surface = Cairo::Image.create(FORMAT_ARGB32, 1000, 800);
  my $cr = Cairo::Context.new($surface);
  $cr.rgb(1, 1, 1);
  $cr.paint;
  draw_dream($cr);
  draw_wow($cr);

  die "Could not save png to $output_filename"
    unless $surface.write_png($output_filename) == STATUS_SUCCESS;
}
