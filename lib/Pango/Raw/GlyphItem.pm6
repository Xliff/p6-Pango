use v6.c;

use NativeCall;


use Pango::Raw::Types;

unit package Pango::Raw::GlyphItem;

sub pango_glyph_item_apply_attrs (
  PangoGlyphItem $glyph_item,
  Str $text,
  PangoAttrList $list
)
  returns GSList
  is native(pango)
  is export
  { * }

sub pango_glyph_item_copy (PangoGlyphItem $orig)
  returns PangoGlyphItem
  is native(pango)
  is export
  { * }

sub pango_glyph_item_free (PangoGlyphItem $glyph_item)
  is native(pango)
  is export
  { * }

sub pango_glyph_item_get_logical_widths (
  PangoGlyphItem $glyph_item,
  Str $text,
  gint $logical_widths
)
  is native(pango)
  is export
  { * }

sub pango_glyph_item_iter_copy (PangoGlyphItemIter $orig)
  returns PangoGlyphItemIter
  is native(pango)
  is export
  { * }

sub pango_glyph_item_iter_free (PangoGlyphItemIter $iter)
  is native(pango)
  is export
  { * }

sub pango_glyph_item_iter_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_glyph_item_iter_init_end (
  PangoGlyphItemIter $iter,
  PangoGlyphItem $glyph_item,
  Str $text
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_glyph_item_iter_init_start (
  PangoGlyphItemIter $iter,
  PangoGlyphItem $glyph_item,
  Str $text
)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_glyph_item_iter_next_cluster (PangoGlyphItemIter $iter)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_glyph_item_iter_prev_cluster (PangoGlyphItemIter $iter)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_glyph_item_letter_space (
  PangoGlyphItem $glyph_item,
  Str $text,
  PangoLogAttr $log_attrs,
  int32 $letter_spacing
)
  is native(pango)
  is export
  { * }

sub pango_glyph_item_split (
  PangoGlyphItem $orig,
  Str $text,
  gint $split_index
)
  returns PangoGlyphItem
  is native(pango)
  is export
  { * }
