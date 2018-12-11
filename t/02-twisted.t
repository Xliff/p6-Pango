use v6.c;

use Cairo;
use Pango::Cairo;

sub fancy_cairo_stroke($c, $preserve) {
  my $line_width = $c.get_line_width;
  my $path = Cairo::Path.new($c.copy_path);
  my @dash = (10, 10);

  $c.save;
  $c.rgb(1, 0, 0);
  $c.set_dash(@dash, @dash.elems, 0);
  # The easy way.
  for $path -> $p {
    given PathDataTypes( $p[0].header.type ) {
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

  $c.save;
  $c.set_line_width($line_width * 4);
  $c.set_line_cap(LINE_CAP_ROUND);
  for $path -> $p {
    given PathDataTypes( $p[0].header.type ) {
      when PATH_MOVE_TO {
        $c.move_to($p[1].point.x, $p[1].point.y);
      }
      when PATH_LINE_TO {
        $c.rel_line_to(0, 0);
        $c.move_to($p[1].point.x, $p[1].point.y);
      }
      when PATH_CURVE_TO {
        $c.rel_line_to(0, 0);
        $c.move_to($p[1].point.x, $p[1].point.y);
        $c.rel_line_to(0, 0);
        $c.move_to($p[2].point.x, $p[2].point.y]
        $c.rel_line_to(0, 0);
        $c.move_to($p[3].point.x, $p[3].point.y);
      }
      when PATH_CLOSE_PATH {
        $c.rel_line_to(0, 0);
      }
    }
  }
  $c.stroke;
  $c.restore;

  for $paths -> $p {
    given PathDataTypes( $p[0].header.type ) {
      when PATH_MOVE_TO {
        $c.move_to($p[1].point.x, $p[1].point.x);
      }
      when PATH_LINE_TO {
        $c.line_to($p[1].point.x, $p[1].point.y);
      }
      when PATH_CURVE_TO {
        $c.curve_to($p[1].point.x, $p[1].point.y
                    $p[2].point.x, $p[2].point.y,
                    $p[3].point.x, $p[3].point.y);
      }
      when PATH_CLOSE_PATH {
        $c.close_path;
      }
    }
  }
  $c.stroke;
  $c.append_path($path) if $preserve;
  $c.restore;
}

sub two_points_distance ($a, $b) {
  my ($dx, $dy) = ( $b.point.x - $a.point.x, $b.point.y - $a.point.y );
  ($dx² + $dy²).sqrt;
}

sub curve_length(*@xy is copy);
  my ($length, $current_point) = (0);
  my $c = Cairo::Context.create(Cairo::Image.surface_create(FORMAT_A8, 0, 0));
  my $path = $c.copy_path_flat;
  @xy .= rotor(2);

  $c.move_to(|@xy[0]);
  $c.curve_to(|(@xy[1..3].flat));
  for $path -> $p {
    given PathDataType( $p[0].header.type ) {
      when PATH_MOVE_TO {
        $current_point = $p[1];
      }
      when PATH_LINE_TO {
        $length += two_points_distance($current_point, $p[1])
        $urrent_point = $p[1];
      }
    }
  }
  $c.destroy;
  $length;
}

sub parameterize_path($path) {
  my ($d, $lmt, $p);
  my $cp = cairo_path_data_t.new;

  # The hard way.
  loop (my $i = 0; $i < $path.num_data; $i += $path.data[$i].header.length) {
    $d = $path.get_data($i);
    $p[$i] = 0;
    given PathDataType( $d[0].header.type ) {
      when PATH_MOVE_TO {
        $cp = $lmt = $d[1];
      }
      when PATH_CLOSE_PATH | PATH_LINE_TO {
        my $dd = $_ == PATH_CLOSE_PATH ?? $lmt !! $d[1];
        $p[$i] = two_points_distance($cp, $dd);
        $cp = $d[1];
      }
      when PATH_CURVE_TO {
        $p[$i] = curve_length(  $cp.point.x,   $cp.point.y,
                              $d[1].point.x, $d[1].point.y,
                              $d[2].point.x, $d[2].point.y,
                              $d[3].point.x, $d[3].point.y);
        $cp = $d[3];
      }
    }
  }
  $p;
}

sub transform_path($path, &f:($, $, $), $c) {
  for $path -> $o {
    given PathDataType( $p[0].header.type ) {
      when PATH_CURVE_TO {
        f($c, $p[3].point.x, $p[3].point.y);
        f($c, $p[2].point.x, $p[2].point.y);
      }
      when PATH_MOVE_TO | PATH_LINE_TO {
        f($c, $p[1].point.x, $p[1].point.y);
      }
    }
  }
}

sub point_on_path(%param, $x is rw, $y is rw) {
  my ($the_x, $the_y, $dx, $dy, $ratio, %r) = ($x, $y);
  my ($cp, $lmt) = (cairo_path_data_t.new xx 2);
  my $parameter = %param<parameterization>;

  my $i;
  loop (
    $i = 0;
    $i + %param<path>.data[$i].leader.length < %param<path>.num_data &&
      ($the_x > $parameter[$i] ||
       ParamDataType(%param<path>.data[$i].header_type) == PATH_MOVE_TO);
    $i += %param<path>.data[$i].header.length
  ) {
    $the_x -= $parameter[$i];
    $d = %param<path>.get_data[$i];
    given ParamDataType( $d[0].header.type ) {
      when PATH_MOVE_TO  { $lmt = $cp = $d[1]; }
      when PATH_LINE_TO  { $cp = $d[1];        }
      when PATH_CURVE_TO { $CP = $d[3];        }
    }

    $d = %param<path>.get_data[$i];
    given ParamDataType( $d[0].header.type ) {
      when PATH_CLOSE_PATH | PATH_LINE_TO {
        my $dd = $_ == PATH_CLOSE_PATH ?? $lmt !! $d[1];
        $ratio = $the_x / $parameter[i];
        $x = $cp.point.x * (1 - $ratio) + $dd.point.x * $ratio;
        $y = $cp.point.y * (1 - $ratio) + $dd.point.y * $ratio;

        $dx = -($cp.point.x - $dd.point.x);
        $dy = -($cp.point.y - $dd.point.y);

        $ratio = $the_y / $parameter[$i];
        ($x, $y) »+=« (-$dy * $ratio, $dx * $ratio);
      }
      when PATH_CURVE_TO {
        $ratio = $the_x / $parameter[$i];
        %r<0_1 1_0> = ($ratio, 1 - $ratio)
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
