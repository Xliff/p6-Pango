use v6.c;

use NativeCall;


use Pango::Raw::Types;

unit module Pango::Raw::Renderer;

sub pango_renderer_activate (PangoRenderer $renderer)
  is native(pango)
  is export
  { * }

sub pango_renderer_deactivate (PangoRenderer $renderer)
  is native(pango)
  is export
  { * }

sub pango_renderer_draw_error_underline (
  PangoRenderer $renderer,
  int32 $x,
  int32 $y,
  int32 $width,
  int32 $height
)
  is native(pango)
  is export
  { * }

sub pango_renderer_draw_glyph (
  PangoRenderer $renderer,
  PangoFont $font,
  PangoGlyph $glyph,
  num64 $x,
  num64 $y
)
  is native(pango)
  is export
  { * }

sub pango_renderer_draw_glyph_item (
  PangoRenderer $renderer,
  Str $text,
  PangoGlyphItem $glyph_item,
  int32 $x,
  int32 $y
)
  is native(pango)
  is export
  { * }

sub pango_renderer_draw_glyphs (
  PangoRenderer $renderer,
  PangoFont $font,
  PangoGlyphString $glyphs,
  int32 $x,
  int32 $y
)
  is native(pango)
  is export
  { * }

sub pango_renderer_draw_layout (
  PangoRenderer $renderer,
  PangoLayout $layout,
  int32 $x,
  int32 $y
)
  is native(pango)
  is export
  { * }

sub pango_renderer_draw_layout_line (
  PangoRenderer $renderer,
  PangoLayoutLine $line,
  int32 $x,
  int32 $y
)
  is native(pango)
  is export
  { * }

sub pango_renderer_draw_rectangle (
  PangoRenderer $renderer,
  PangoRenderPart $part,
  int32 $x,
  int32 $y,
  int32 $width,
  int32 $height
)
  is native(pango)
  is export
  { * }

sub pango_renderer_draw_trapezoid (
  PangoRenderer $renderer,
  PangoRenderPart $part,
  num64 $y1_,
  num64 $x11,
  num64 $x21,
  num64 $y2,
  num64 $x12,
  num64 $x22
)
  is native(pango)
  is export
  { * }

sub pango_renderer_get_alpha (
  PangoRenderer $renderer,
  PangoRenderPart $part
)
  returns guint16
  is native(pango)
  is export
  { * }

sub pango_renderer_get_color (
  PangoRenderer $renderer,
  PangoRenderPart $part
)
  returns PangoColor
  is native(pango)
  is export
  { * }

sub pango_renderer_get_layout (PangoRenderer $renderer)
  returns PangoLayout
  is native(pango)
  is export
  { * }

sub pango_renderer_get_layout_line (PangoRenderer $renderer)
  returns PangoLayoutLine
  is native(pango)
  is export
  { * }

sub pango_renderer_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_renderer_part_changed (
  PangoRenderer $renderer,
  PangoRenderPart $part
)
  is native(pango)
  is export
  { * }

sub pango_renderer_set_alpha (
  PangoRenderer $renderer,
  PangoRenderPart $part,
  guint16 $alpha
)
  is native(pango)
  is export
  { * }

sub pango_renderer_set_color (
  PangoRenderer $renderer,
  PangoRenderPart $part,
  PangoColor $color
)
  is native(pango)
  is export
  { * }

sub pango_renderer_get_matrix (PangoRenderer $renderer)
  returns PangoMatrix
  is native(pango)
  is export
  { * }

sub pango_renderer_set_matrix (
  PangoRenderer $renderer,
  PangoMatrix $matrix
)
  is native(pango)
  is export
  { * }
