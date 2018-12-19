use v6.c;

use NativeCall;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::FT2FontMap;

sub pango_ft2_font_map_create_context (PangoFT2FontMap $fontmap)
  returns PangoContext
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_font_map_for_display ()
  returns PangoFT2FontMap
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_font_map_get_type ()
  returns GType
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_font_map_new ()
  returns PangoFT2FontMap
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_font_get_coverage (PangoFont $font, PangoLanguage $language)
  returns PangoCoverage
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_font_get_face (PangoFont $font)
  returns FT_Face
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_font_get_kerning (
  PangoFont $font,
  PangoGlyph $left,
  PangoGlyph $right
)
  returns int32
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_get_context (gdouble $dpi_x, gdouble $dpi_y)
  returns PangoContext
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_get_unknown_glyph (PangoFont $font)
  returns PangoGlyph
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_render (
  FT_Bitmap $bitmap,
  PangoFont $font,
  PangoGlyphString $glyphs,
  gint $x,
  gint $y
)
  is native(pangoft2)
  is export
  { * }

# Originally:
# sub pango_ft2_render_layout (
#   FT_BitMap $bitmap,
#   PangoLayout $layout,
#   gint $x,
#   gint $y
# )
sub pango_ft2_render_layout (
  PangoLayout $layout,
  Pointer $bitmap,
  gint $x,
  gint $y
)
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_render_layout_line (
  FT_Bitmap $bitmap,
  PangoLayoutLine $line,
  gint $x,
  gint $y
)
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_render_layout_line_subpixel (
  FT_Bitmap $bitmap,
  PangoLayoutLine $line,
  gint $x,
  gint $y
)
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_render_layout_subpixel (
  FT_Bitmap $bitmap,
  PangoLayout $layout,
  gint $x,
  gint $y
)
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_render_transformed (
  FT_Bitmap $bitmap,
  PangoMatrix $matrix,
  PangoFont $font,
  PangoGlyphString $glyphs,
  gint $x,
  gint $y
)
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_font_map_set_default_substitute (
  PangoFT2FontMap $fontmap,
  &func (FcPattern, Pointer),
  gpointer $data,
  &notify (Pointer)
)
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_font_map_set_resolution (
  PangoFT2FontMap $fontmap,
  gdouble $dpi_x,
  gdouble $dpi_y
)
  is native(pangoft2)
  is export
  { * }

sub pango_ft2_font_map_substitute_changed (PangoFT2FontMap $fontmap)
  is native(pangoft2)
  is export
  { * }
