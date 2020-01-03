use v6.c;

use Method::Also;


use Pango::Raw::Types;
use Pango::Raw::XFT;

use Pango::Renderer;

class Pango::Renderer::XFT is Pango::Renderer {
  has PangoXFTRender $!pxftr;   
  has XftDraw $!draw;

  method layout (
    XftColor $color,
    PangoLayout() $layout,
    Int() $x,
    Int() $y
  ) {
    die 'You must call Pango::XFT::Renderer.set_draw before calling this method'
      unless $!draw;
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    pango_xft_render_layout($!draw, $color, $layout, $xx, $yy);
  }

  method layout_line (
    XftColor $color,
    PangoLayoutLine $line,
    Int() $x,
    Int() $y
  ) 
    is also<layout-line> 
  {
    die 'You must call Pango::XFT::Renderer.set_draw before calling this method'
      unless $!draw;
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    pango_xft_render_layout_line($!draw, $color, $line, $xx, $yy);
  }

  method pango_xft_picture_render (
    Picture $src_picture,
    Picture $dest_picture,
    PangoFont() $font,
    PangoGlyphString() $glyphs,
    Int() $x,
    Int() $y
  ) 
    is also<pango-xft-picture-render> 
  {
    die 'You must call Pango::XFT::Renderer.set_draw before calling this method'
      unless $!draw;
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    pango_xft_picture_render(
      $!draw, $src_picture, $dest_picture, $font, $glyphs, $xx, $yy
    );
  }

  method pango_xft_render (
    XftColor $color,
    PangoFont() $font,
    PangoGlyphString() $glyphs,
    Int() $x,
    Int() $y
  ) 
    is also<pango-xft-render> 
  {
    die 'You must call Pango::XFT::Renderer.set_draw before calling this method'
      unless $!draw;
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    pango_xft_render($!draw, $color, $font, $glyphs, $xx, $yy);
  }

  method pango_xft_renderer_get_type 
    is also<pango-xft-renderer-get-type> 
  {
    pango_xft_renderer_get_type();
  }

  method pango_xft_renderer_new (Int() $screen) 
    is also<pango-xft-renderer-new> 
  {
    my gint $s = self.RESOLVE-INT($screen);
    pango_xft_renderer_new($!draw, $s);
  }

  method pango_xft_renderer_set_default_color (PangoColor() $default_color) 
    is also<pango-xft-renderer-set-default-color> 
  {
    pango_xft_renderer_set_default_color($!pxftr, $default_color);
  }

  method pango_xft_renderer_set_draw (XftDraw $draw) 
    is also<pango-xft-renderer-set-draw> 
  {
    pango_xft_renderer_set_draw($!pxftr, $draw);
    $!draw = $draw;
  }

  method transformed (
    XftColor $color,
    PangoMatrix() $matrix,
    PangoFont() $font,
    PangoGlyphString() $glyphs,
    Int() $x,
    Int() $y
  ) {
    die 'You must call Pango::XFT::Renderer.set_draw before calling this method'
      unless $!draw;
    my gint ($xx, $yy) = self.RESOLVE-INT($x, $y);
    pango_xft_render_transformed(
      $!draw, $color, $matrix, $font, $glyphs, $xx, $yy
    );
  }

}
