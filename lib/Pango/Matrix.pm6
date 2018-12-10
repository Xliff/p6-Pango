use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Matrix;
use Pango::Raw::Types;

use Pango::Roles::Types;

class Pango::Matrix {
  also does Pango::Roles::Types;

  has PangoMatrix $!pm;

  submethod BUILD (:$matrix) {
    $!pm = $matrix;
  }

  # Struct backed, so assume no need for ref counting.
  multi method new (PangoMatrix $matrix) {
    self.bless(:$matrix);
  }
  multi method new {
    self.bless( matrix => PANGO_MATRIX_INIT );
  }

  method concat (PangoMatrix $new_matrix) {
    pango_matrix_concat($!pm, $new_matrix);
  }

  method copy {
    pango_matrix_copy($!pm);
  }

  # No ref counting, so objects must be freed MANUALLY!
  method free {
    pango_matrix_free($!pm);
  }

  method get_font_scale_factor {
    pango_matrix_get_font_scale_factor($!pm);
  }

  method get_font_scale_factors (Num() $xscale, Num() $yscale) {
    my gdouble ($xs, $ys) = ($xscale, $yscale);
    pango_matrix_get_font_scale_factors($!pm, $xs, $ys);
  }

  method get_type {
    pango_matrix_get_type();
  }

  method rotate (Num() $degrees) {
    my gdouble $d = $degrees;
    pango_matrix_rotate($!pm, $d);
  }

  method scale (Num() $scale_x, Num() $scale_y) {
    my gdouble ($ssx, $ssy) = ($scale_x, $scale_y);
    pango_matrix_scale($!pm, $scale_x, $scale_y);
  }

  method transform_distance (Num() $dx is rw, Num() $dy is rw) {
    my gdouble ($ddx, $ddy) = ($dx, $dy);
    pango_matrix_transform_distance($!pm, $ddx, $ddy);
    ($dx, $dy) = ($ddx, $ddy);
  }

  method transform_pixel_rectangle (PangoRectangle $rect) {
    pango_matrix_transform_pixel_rectangle($!pm, $rect);
  }

  method transform_point (Num() $x is rw, Num() $y is rw) {
    my gdouble ($xx, $yy) = ($x, $y);
    pango_matrix_transform_point($!pm, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method transform_rectangle (PangoRectangle $rect) {
    pango_matrix_transform_rectangle($!pm, $rect);
  }

  method translate (Num() $tx, Num() $ty) {
    my gdouble ($ttx, $tty) = ($tx, $ty);
    pango_matrix_translate($!pm, $tx, $ty);
  }

}
