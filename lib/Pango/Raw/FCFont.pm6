use v6.c;

use NativeCall;


use Pango::Raw::Types;

unit package Pango::Raw::FCFont;

sub pango_fc_font_get_glyph (PangoFcFont $font, gunichar $wc)
  returns guint
  is native(pango)
  is export
  { * }

sub pango_fc_font_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_fc_font_get_unknown_glyph (PangoFcFont $font, gunichar $wc)
  returns PangoGlyph
  is native(pango)
  is export
  { * }

sub pango_fc_font_has_char (PangoFcFont $font, gunichar $wc)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_fc_font_kern_glyphs (PangoFcFont $font, PangoGlyphString $glyphs)
  is native(pango)
  is export
  { * }

sub pango_fc_font_lock_face (PangoFcFont $font)
  returns FT_Face
  is native(pango)
  is export
  { * }

sub pango_fc_font_unlock_face (PangoFcFont $font)
  is native(pango)
  is export
  { * }
