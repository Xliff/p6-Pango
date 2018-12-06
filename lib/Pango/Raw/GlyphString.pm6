use v6.c;

use NativeCall;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::GlyphString;

sub pango_glyph_string_copy (PangoGlyphString $string)
  returns PangoGlyphString
  is native(pango)
  is export
  { * }

sub pango_glyph_string_extents (
  PangoGlyphString $glyphs,
  PangoFont $font,
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect
)
  is native(pango)
  is export
  { * }

sub pango_glyph_string_extents_range (
  PangoGlyphString $glyphs,
  int32 $start,
  int32 $end,
  PangoFont $font,
  PangoRectangle $ink_rect,
  PangoRectangle $logical_rect
)
  is native(pango)
  is export
  { * }

sub pango_glyph_string_free (PangoGlyphString $string)
  is native(pango)
  is export
  { * }

sub pango_glyph_string_get_logical_widths (
  PangoGlyphString $glyphs,
  Str $text,
  int32 $length,
  int32 $embedding_level,
  int32 $logical_widths
)
  is native(pango)
  is export
  { * }

sub pango_glyph_string_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_glyph_string_get_width (PangoGlyphString $glyphs)
  returns int32
  is native(pango)
  is export
  { * }

sub pango_glyph_string_index_to_x (
  PangoGlyphString $glyphs,
  Str $text,
  int32 $length,
  PangoAnalysis $analysis,
  int32 $index_,
  gboolean $trailing,
  int32 $x_pos
)
  is native(pango)
  is export
  { * }

sub pango_glyph_string_new ()
  returns PangoGlyphString
  is native(pango)
  is export
  { * }

sub pango_glyph_string_set_size (PangoGlyphString $string, gint $new_len)
  is native(pango)
  is export
  { * }

sub pango_glyph_string_x_to_index (
  PangoGlyphString $glyphs,
  Str $text,
  int32 $length,
  PangoAnalysis $analysis,
  int32 $x_pos,
  int32 $index_,
  int32 $trailing
)
  is native(pango)
  is export
  { * }

sub pango_reorder_items (GList $logical_items)
  returns GList
  is native(pango)
  is export
  { * }

sub pango_shape (
  Str $text,
  gint $length,
  PangoAnalysis $analysis,
  PangoGlyphString $glyphs
)
  is native(pango)
  is export
  { * }

sub pango_shape_full (
  Str $item_text,
  gint $item_length,
  Str $paragraph_text,
  gint $paragraph_length,
  PangoAnalysis $analysis,
  PangoGlyphString $glyphs
)
  is native(pango)
  is export
  { * }
