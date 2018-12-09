use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::XFT;

sub pango_xft_font_get_font (PangoFont $font)
  returns XftFont
  is native(pango)
  is export
  { * }

sub pango_xft_font_get_glyph (PangoFont $font, gunichar $wc)
  returns guint
  is native(pango)
  is export
  { * }

sub pango_xft_font_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_xft_font_get_unknown_glyph (PangoFont $font, gunichar $wc)
  returns PangoGlyph
  is native(pango)
  is export
  { * }

sub pango_xft_font_has_char (PangoFont $font, gunichar $wc)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_xft_font_lock_face (PangoFont $font)
  returns FT_Face
  is native(pango)
  is export
  { * }

sub pango_xft_font_unlock_face (PangoFont $font)
  is native(pango)
  is export
  { * }

sub pango_xft_get_font_map (Display $display, gint $screen)
  returns PangoFontMap
  is native(pango)
  is export
  { * }

sub pango_xft_set_default_substitute (
  Display $display,
  gint $screen,
  &func:(FcPattern ,Pointer),
  gpointer $data,
  &notify:(Pointer)
)
  is native(pango)
  is export
  { * }

sub pango_xft_shutdown_display (Display $display, gint $screen)
  is native(pango)
  is export
  { * }

sub pango_xft_substitute_changed (Display $display, gint $screen)
  is native(pango)
  is export
  { * }

sub pango_xft_render_layout (
  XftDraw $draw,
  XftColor $color,
  PangoLayout $layout,
  int32 $x,
  int32 $y
)
  is native(pango)
  is export
  { * }

sub pango_xft_render_layout_line (
  XftDraw $draw,
  XftColor $color,
  PangoLayoutLine $line,
  int32 $x,
  int32 $y
)
  is native(pango)
  is export
  { * }

sub pango_xft_picture_render (
  Display $display,
  Picture $src_picture,
  Picture $dest_picture,
  PangoFont $font,
  PangoGlyphString $glyphs,
  gint $x,
  gint $y
)
  is native(pango)
  is export
  { * }

sub pango_xft_render (
  XftDraw $draw,
  XftColor $color,
  PangoFont $font,
  PangoGlyphString $glyphs,
  gint $x,
  gint $y
)
  is native(pango)
  is export
  { * }

sub pango_xft_renderer_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_xft_renderer_new (Display $display, int32 $screen)
  returns PangoRenderer
  is native(pango)
  is export
  { * }

sub pango_xft_renderer_set_default_color (
  PangoXftRenderer $xftrenderer,
  PangoColor $default_color
)
  is native(pango)
  is export
  { * }

sub pango_xft_renderer_set_draw (
  PangoXftRenderer $xftrenderer,
  XftDraw $draw
)
  is native(pango)
  is export
  { * }

sub pango_xft_render_transformed (
  XftDraw $draw,
  XftColor $color,
  PangoMatrix $matrix,
  PangoFont $font,
  PangoGlyphString $glyphs,
  int32 $x,
  int32 $y
)
  is native(pango)
  is export
  { * }
