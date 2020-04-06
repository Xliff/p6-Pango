use v6.c;

use NativeCall;


use Pango::Raw::Types;

unit package Pango::Raw::FontMap;

sub pango_font_map_changed (PangoFontMap $fontmap)
  is native(pango)
  is export
  { * }

sub pango_font_map_create_context (PangoFontMap $fontmap)
  returns PangoContext
  is native(pango)
  is export
  { * }

sub pango_font_map_get_serial (PangoFontMap $fontmap)
  returns guint
  is native(pango)
  is export
  { * }

sub pango_font_map_get_shape_engine_type (PangoFontMap $fontmap)
  returns Str
  is native(pango)
  is export
  { * }

sub pango_font_map_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_font_map_list_families (
  PangoFontMap $fontmap,
  CArray[CArray[PangoFontFamily]] $families,
  int32 $n_families is rw
)
  is native(pango)
  is export
  { * }

sub pango_font_map_load_font (
  PangoFontMap $fontmap,
  PangoContext $context,
  PangoFontDescription $desc
)
  returns PangoFont
  is native(pango)
  is export
  { * }

sub pango_font_map_load_fontset (
  PangoFontMap $fontmap,
  PangoContext $context,
  PangoFontDescription $desc,
  PangoLanguage $language
)
  returns PangoFontset
  is native(pango)
  is export
  { * }
