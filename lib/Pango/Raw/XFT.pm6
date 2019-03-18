use v6.c;

use NativeCall;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::XFT;

sub pango_xft_font_get_font (PangoXFTFont $font)
  returns XftFont
  is native(pango)
  is export
  { * }

sub pango_xft_font_get_glyph (PangoXFTFont $font, gunichar $wc)
  returns guint
  is native(pango)
  is export
  { * }

sub pango_xft_font_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_xft_font_get_unknown_glyph (PangoXFTFont $font, gunichar $wc)
  returns PangoGlyph
  is native(pango)
  is export
  { * }

sub pango_xft_font_has_char (PangoXFTFont $font, gunichar $wc)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_xft_font_lock_face (PangoXFTFont $font)
  returns FT_Face
  is native(pango)
  is export
  { * }

sub pango_xft_font_unlock_face (PangoXFTFont $font)
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
  returns PangoXFTRenderer
  is native(pango)
  is export
  { * }

sub pango_xft_renderer_set_default_color (
  PangoXFTRender $xftrenderer,
  PangoColor $default_color
)
  is native(pango)
  is export
  { * }

sub pango_xft_renderer_set_draw (
  PangoXFTRender $xftrenderer,
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
  
sub pango_xft_font_get_display (PangoXFTFont $font)
  returns Display
  is native(pango)
  is export 
  { * }
