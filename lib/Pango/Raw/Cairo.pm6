use v6.c;

use Cairo;
use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::Cairo

sub pango_cairo_context_get_shape_renderer (
  PangoContext $context,
  gpointer $data
)
  returns &func:(cairo_t, PangoAttrShape, guint32, Pointer)
  is native(pango)
  is export
  { * }

sub pango_cairo_context_set_shape_renderer (
  PangoContext $context,
  &func:(cairo_t, PangoAttrShape, guint32, Pointer),
  gpointer $data,
  &dnotify:(Pointer)
)
  is native(pango)
  is export
  { * }

sub pango_cairo_create_context (cairo_t $cr)
  returns PangoContext
  is native(pango)
  is export
  { * }

sub pango_cairo_create_layout (cairo_t $cr)
  returns PangoLayout
  is native(pango)
  is export
  { * }

sub pango_cairo_error_underline_path (
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height
)
  is native(pango)
  is export
  { * }

sub pango_cairo_font_get_scaled_font (PangoCairoFont $font)
  returns cairo_scaled_font_t
  is native(pango)
  is export
  { * }

sub pango_cairo_font_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_cairo_font_map_create_context (PangoCairoFontMap $fontmap)
  returns PangoContext
  is native(pango)
  is export
  { * }

sub pango_cairo_font_map_get_default ()
  returns PangoFontMap
  is native(pango)
  is export
  { * }

sub pango_cairo_font_map_get_font_type (PangoCairoFontMap $fontmap)
  returns cairo_font_type_t
  is native(pango)
  is export
  { * }

sub pango_cairo_font_map_new ()
  returns PangoFontMap
  is native(pango)
  is export
  { * }

sub pango_cairo_font_map_new_for_font_type (cairo_font_type_t $fonttype)
  returns PangoFontMap
  is native(pango)
  is export
  { * }

sub pango_cairo_font_map_set_default (PangoCairoFontMap $fontmap)
  is native(pango)
  is export
  { * }

sub pango_cairo_glyph_string_path (
  cairo_t $cr,
  PangoFont $font,
  PangoGlyphString $glyphs
)
  is native(pango)
  is export
  { * }

sub pango_cairo_layout_line_path (cairo_t $cr, PangoLayoutLine $line)
  is native(pango)
  is export
  { * }

sub pango_cairo_layout_path (cairo_t $cr, PangoLayout $layout)
  is native(pango)
  is export
  { * }

sub pango_cairo_show_error_underline (
  cairo_t $cr,
  gdouble $x,
  gdouble $y,
  gdouble $width,
  gdouble $height
)
  is native(pango)
  is export
  { * }

sub pango_cairo_show_glyph_item (
  cairo_t $cr,
  Str $text,
  PangoGlyphItem $glyph_item
)
  is native(pango)
  is export
  { * }

sub pango_cairo_show_glyph_string (
  cairo_t $cr,
  PangoFont $font,
  PangoGlyphString $glyphs
)
  is native(pango)
  is export
  { * }

sub pango_cairo_show_layout (cairo_t $cr, PangoLayout $layout)
  is native(pango)
  is export
  { * }

sub pango_cairo_show_layout_line (cairo_t $cr, PangoLayoutLine $line)
  is native(pango)
  is export
  { * }

sub pango_cairo_update_context (cairo_t $cr, PangoContext $context)
  is native(pango)
  is export
  { * }

sub pango_cairo_update_layout (cairo_t $cr, PangoLayout $layout)
  is native(pango)
  is export
  { * }

sub pango_cairo_context_get_resolution (PangoContext $context)
  returns double
  is native(pango)
  is export
  { * }

sub pango_cairo_context_get_font_options (PangoContext $context)
  returns cairo_font_options_t
  is native(pango)
  is export
  { * }

sub pango_cairo_context_set_resolution (PangoContext $context, gdouble $dpi)
  is native(pango)
  is export
  { * }

sub pango_cairo_context_set_font_options (
  PangoContext $context,
  cairo_font_options_t $options
)
  is native(pango)
  is export
  { * }
