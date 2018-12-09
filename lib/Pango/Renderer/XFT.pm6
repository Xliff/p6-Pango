use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;
use Pango::Raw::XFT;

use Pango::Renderer;

class Pango::Renderer::XFT is Pango::Renderer {
  has PangoXFTRender $!pxftr;   # Or is it XftDraw?

  method layout (
    XftColor $color,
    PangoLayout() $layout,
    Int() $x,
    Int() $y
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    pango_xft_render_layout($!pxftr, $color, $layout, $xx, $yy);
  }

  method layout_line (
    XftColor $color,
    PangoLayoutLine $line,
    Int() $x,
    Int() $y
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    pango_xft_render_layout_line($!pxftr, $color, $line, $xx, $yy);
  }

  method pango_xft_picture_render (
    Picture $src_picture,
    Picture $dest_picture,
    PangoFont() $font,
    PangoGlyphString() $glyphs,
    Int() $x,
    Int() $y
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    pango_xft_picture_render(
      $!pxftr, $src_picture, $dest_picture, $font, $glyphs, $xx, $yy
    );
  }

  method pango_xft_render (
    XftColor $color,
    PangoFont() $font,
    PangoGlyphString() $glyphs,
    Int() $x,
    Int() $y
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    pango_xft_render($!pxftr, $color, $font, $glyphs, $xx, $yy);
  }

  method pango_xft_renderer_get_type () {
    pango_xft_renderer_get_type();
  }

  method pango_xft_renderer_new (Int() $screen) {
    my gint $s = self.RESOLVE-INT($screen);
    pango_xft_renderer_new($!pxftr, $s);
  }

  method pango_xft_renderer_set_default_color (PangoColor $default_color) {
    pango_xft_renderer_set_default_color($!pxftr, $default_color);
  }

  method pango_xft_renderer_set_draw (XftDraw $draw) {
    pango_xft_renderer_set_draw($!pxftr, $draw);
  }

  method transformed (
    XftColor $color,
    PangoMatrix() $matrix,
    PangoFont() $font,
    PangoGlyphString() $glyphs,
    Int() $xx,
    Int() $yy
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    pango_xft_render_transformed(
      $!pxftr, $color, $matrix, $font, $glyphs, $xx, $yy
    );
  }

}
