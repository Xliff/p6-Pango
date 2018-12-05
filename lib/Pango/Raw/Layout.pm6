use v6.c;

use NativeCall;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::PangoLayout;

sub pango_layout_context_changed (PangoLayout $layout)
  is native(pango)
  is export
  { * }

sub pango_layout_copy (PangoLayout $src)
  returns PangoLayout
  is native(pango)
  is export
  { * }

sub pango_layout_get_character_count (PangoLayout $layout)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_layout_get_context (PangoLayout $layout)
  returns PangoContext
  is native(pango)
  is export
  { * }

sub pango_layout_get_cursor_pos (
  PangoLayout $layout,
  gint $index,
  PangoRectangle $strong_pos,
  PangoRectangle $weak_pos
)
  is native(pango)
  is export
  { * }

sub pango_layout_get_iter (PangoLayout $layout)
  returns PangoLayoutIter
  is native(pango)
  is export
  { * }

sub pango_layout_get_line_count (PangoLayout $layout)
  returns int32
  is native(pango)
  is export
  { * }

sub pango_layout_get_lines (PangoLayout $layout)
  returns GSList
  is native(pango)
  is export
  { * }

sub pango_layout_get_lines_readonly (PangoLayout $layout)
  returns GSList
  is native(pango)
  is export
  { * }

sub pango_layout_get_log_attrs (
  PangoLayout $layout,
  PangoLogAttr $attrs,
  gint $n_attrs
)
  is native(pango)
  is export
  { * }

sub pango_layout_get_log_attrs_readonly (PangoLayout $layout, gint $n_attrs)
  returns PangoLogAttr
  is native(pango)
  is export
  { * }

sub pango_layout_get_pixel_size (
  PangoLayout $layout,
  gint $width,
  gint $height
)
  is native(pango)
  is export
  { * }

sub pango_layout_get_serial (PangoLayout $layout)
  returns guint
  is native(pango)
  is export
  { * }

sub pango_layout_get_size (PangoLayout $layout, gint $width, gint $height)
  is native(pango)
  is export
  { * }

sub pango_layout_get_text (PangoLayout $layout)
  returns Str
  is native(pango)
  is export
  { * }

sub pango_layout_get_unknown_glyphs_count (PangoLayout $layout)
  returns int32
  is native(pango)
  is export
  { * }

sub pango_layout_index_to_line_x (
  PangoLayout $layout,
  gint $index,
  gboolean $trailing,
  gint $line,
  gint $x_pos
)
  is native(pango)
  is export
  { * }

sub pango_layout_index_to_pos (
  PangoLayout $layout,
  gint $index,
  PangoRectangle $pos
)
  is native(pango)
  is export
  { * }

sub pango_layout_is_ellipsized (PangoLayout $layout)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_is_wrapped (PangoLayout $layout)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_iter_at_last_line (PangoLayoutIter $iter)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_iter_copy (PangoLayoutIter $iter)
  returns PangoLayoutIter
  is native(pango)
  is export
  { * }

sub pango_layout_iter_free (PangoLayoutIter $iter)
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_baseline (PangoLayoutIter $iter)
  returns int32
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_char_extents (
  PangoLayoutIter $iter,
  PangoRectangle $logical_rect)
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_cluster_extents (
  PangoLayoutIter $iter,
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect
)
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_index (PangoLayoutIter $iter)
  returns int32
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_layout (PangoLayoutIter $iter)
  returns PangoLayout
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_layout_extents (
  PangoLayoutIter $iter,
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect
)
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_line (PangoLayoutIter $iter)
  returns PangoLayoutLine
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_line_extents (
  PangoLayoutIter $iter,
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect
)
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_line_readonly (PangoLayoutIter $iter)
  returns PangoLayoutLine
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_line_yrange (
  PangoLayoutIter $iter,
  gint $y0,
  gint $y1
)
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_run (PangoLayoutIter $iter)
  returns PangoLayoutRun
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_run_extents (
  PangoLayoutIter $iter,
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect
)
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_run_readonly (PangoLayoutIter $iter)
  returns PangoLayoutRun
  is native(pango)
  is export
  { * }

sub pango_layout_iter_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_layout_iter_next_Str (PangoLayoutIter $iter)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_iter_next_cluster (PangoLayoutIter $iter)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_iter_next_line (PangoLayoutIter $iter)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_iter_next_run (PangoLayoutIter $iter)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_line_get_extents (
  PangoLayoutLine $line,
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect
)
  is native(pango)
  is export
  { * }

sub pango_layout_line_get_pixel_extents (
  PangoLayoutLine $layout_line,
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect
)
  is native(pango)
  is export
  { * }

sub pango_layout_line_get_x_ranges (
  PangoLayoutLine $line,
  gint $start_index,
  gint $end_index,
  gint $ranges,
  gint $n_ranges
)
  is native(pango)
  is export
  { * }

sub pango_layout_line_index_to_x (
  PangoLayoutLine $line,
  gint $index,
  gboolean $trailing,
  gint $x_pos
)
  is native(pango)
  is export
  { * }

sub pango_layout_line_ref (PangoLayoutLine $line)
  returns PangoLayoutLine
  is native(pango)
  is export
  { * }

sub pango_layout_line_unref (PangoLayoutLine $line)
  is native(pango)
  is export
  { * }

sub pango_layout_line_x_to_index (
  PangoLayoutLine $line,
  gint $x_pos,
  gint $index_,
  gint $trailing
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_move_cursor_visually (
  PangoLayout $layout,
  gboolean $strong,
  gint $old_index,
  gint $old_trailing,
  gint $direction,
  gint $new_index,
  gint $new_trailing
)
  is native(pango)
  is export
  { * }

sub pango_layout_new (PangoContext $context)
  returns PangoLayout
  is native(pango)
  is export
  { * }

sub pango_layout_set_markup (
  PangoLayout $layout,
  Str $markup,
  gint $length
)
  is native(pango)
  is export
  { * }

sub pango_layout_set_markup_with_accel (
  PangoLayout $layout,
  Str $markup,
  gint $length,
  gunichar $accel_marker,
  gunichar $accel_char
)
  is native(pango)
  is export
  { * }

sub pango_layout_set_text (
  PangoLayout $layout,
  Str $text,
  gint $length
)
  is native(pango)
  is export
  { * }

sub pango_layout_xy_to_index (
  PangoLayout $layout,
  gint $x,
  gint $y,
  gint $index,
  gint $trailing
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_get_justify (PangoLayout $layout)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_get_spacing (PangoLayout $layout)
  returns int32
  is native(pango)
  is export
  { * }

sub pango_layout_get_height (PangoLayout $layout)
  returns int32
  is native(pango)
  is export
  { * }

sub pango_layout_get_indent (PangoLayout $layout)
  returns int32
  is native(pango)
  is export
  { * }

sub pango_layout_get_attributes (PangoLayout $layout)
  returns PangoAttrList
  is native(pango)
  is export
  { * }

sub pango_layout_get_single_paragraph_mode (PangoLayout $layout)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_get_width (PangoLayout $layout)
  returns int32
  is native(pango)
  is export
  { * }

sub pango_layout_get_tabs (PangoLayout $layout)
  returns PangoTabArray
  is native(pango)
  is export
  { * }

sub pango_layout_get_wrap (PangoLayout $layout)
  returns uint32 # PangoWrapMode
  is native(pango)
  is export
  { * }

sub pango_layout_get_auto_dir (PangoLayout $layout)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_layout_get_ellipsize (PangoLayout $layout)
  returns uint32 # PangoEllipsizeMode
  is native(pango)
  is export
  { * }

sub pango_layout_get_alignment (PangoLayout $layout)
  returns uint32 # PangoAlignment
  is native(pango)
  is export
  { * }

sub pango_layout_get_font_description (PangoLayout $layout)
  returns PangoFontDescription
  is native(pango)
  is export
  { * }

sub pango_layout_set_justify (PangoLayout $layout, gboolean $justify)
  is native(pango)
  is export
  { * }

sub pango_layout_set_spacing (PangoLayout $layout, gint $spacing)
  is native(pango)
  is export
  { * }

sub pango_layout_set_height (PangoLayout $layout, gint $height)
  is native(pango)
  is export
  { * }

sub pango_layout_set_indent (PangoLayout $layout, gint $indent)
  is native(pango)
  is export
  { * }

sub pango_layout_set_attributes (PangoLayout $layout, PangoAttrList $attrs)
  is native(pango)
  is export
  { * }

sub pango_layout_set_single_paragraph_mode (
  PangoLayout $layout,
  gboolean $setting
)
  is native(pango)
  is export
  { * }

sub pango_layout_set_width (PangoLayout $layout, gint $width)
  is native(pango)
  is export
  { * }

sub pango_layout_set_tabs (PangoLayout $layout, PangoTabArray $tabs)
  is native(pango)
  is export
  { * }

sub pango_layout_set_wrap (
  PangoLayout $layout,
  uint32 $wrap                    # PangoWrapMode $wrap
)
  is native(pango)
  is export
  { * }

sub pango_layout_set_auto_dir (PangoLayout $layout, gboolean $auto_dir)
  is native(pango)
  is export
  { * }

sub pango_layout_set_ellipsize (
  PangoLayout $layout,
  uint32 $ellipsize               # PangoEllipsizeMode $ellipsize
)
  is native(pango)
  is export
  { * }

sub pango_layout_set_alignment (
  PangoLayout $layout,
  uint32 $alignment               # PangoAlignment $alignment
)
  is native(pango)
  is export
  { * }

sub pango_layout_set_font_description (
  PangoLayout $layout,
  PangoFontDescription $desc
)
  is native(pango)
  is export
  { * }
