use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::Matrix;

sub pango_matrix_concat (PangoMatrix $matrix, PangoMatrix $new_matrix)
  is native(pango)
  is export
  { * }

sub pango_matrix_copy (PangoMatrix $matrix)
  returns PangoMatrix
  is native(pango)
  is export
  { * }

sub pango_matrix_free (PangoMatrix $matrix)
  is native(pango)
  is export
  { * }

sub pango_matrix_get_font_scale_factor (PangoMatrix $matrix)
  returns gdouble
  is native(pango)
  is export
  { * }

sub pango_matrix_get_font_scale_factors (
  PangoMatrix $matrix,
  gdouble $xscale,
  gdouble $yscale
)
  is native(pango)
  is export
  { * }

sub pango_matrix_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_matrix_rotate (PangoMatrix $matrix, gdouble $degrees)
  is native(pango)
  is export
  { * }

sub pango_matrix_scale (
  PangoMatrix $matrix,
  gdouble $scale_x,
  gdouble $scale_y
)
  is native(pango)
  is export
  { * }

sub pango_matrix_transform_distance (
  PangoMatrix $matrix,
  gdouble $dx is rw,
  gdouble $dy is rw
)
  is native(pango)
  is export
  { * }

sub pango_matrix_transform_pixel_rectangle (
  PangoMatrix $matrix,
  PangoRectangle $rect
)
  is native(pango)
  is export
  { * }

sub pango_matrix_transform_point (
  PangoMatrix $matrix,
  gdouble $x is rw,
  gdouble $y is rw
)
  is native(pango)
  is export
  { * }

sub pango_matrix_transform_rectangle (
  PangoMatrix $matrix,
  PangoRectangle $rect
)
  is native(pango)
  is export
  { * }

sub pango_matrix_translate (PangoMatrix $matrix, gdouble $tx, gdouble $ty)
  is native(pango)
  is export
  { * }
