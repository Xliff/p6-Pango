use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::Fontset;

sub pango_fontset_foreach (
  PangoFontset $fontset,
  &func (PangoFontset, PangoFont, Pointer --> gboolean),
  gpointer $data
)
  is native(pango)
  is export
  { * }

sub pango_fontset_get_font (PangoFontset $fontset, guint $wc)
  returns PangoFont
  is native(pango)
  is export
  { * }

sub pango_fontset_get_metrics (PangoFontset $fontset)
  returns PangoFontMetrics
  is native(pango)
  is export
  { * }

sub pango_fontset_simple_append (
  PangoFontsetSimple $fontset,
  PangoFont $font
)
  is native(pango)
  is export
  { * }

sub pango_fontset_simple_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_fontset_simple_new (PangoLanguage $language)
  returns PangoFontsetSimple
  is native(pango)
  is export
  { * }

sub pango_fontset_simple_size (PangoFontsetSimple $fontset)
  returns int
  is native(pango)
  is export
  { * }
