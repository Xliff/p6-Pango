use v6.c;

use Method::Also;


use Pango::Raw::Types;
use Pango::Raw::Renderer;

class Pango::Renderer {
  has PangoRenderer $!pr;

  method activate {
    pango_renderer_activate($!pr);
  }

  method deactivate {
    pango_renderer_deactivate($!pr);
  }

  method draw_error_underline (
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  ) 
    is also<draw-error-underline> 
  {
    pango_renderer_draw_error_underline($!pr, $x, $y, $width, $height);
  }

  method draw_glyph (
    PangoFont() $font,
    PangoGlyph() $glyph,
    Num() $x,
    Num() $y
  ) 
    is also<draw-glyph> 
  {
    my gdouble ($xx, $yy) = ($x, $y);
    pango_renderer_draw_glyph($!pr, $font, $glyph, $xx, $yy);
  }

  method draw_glyph_item (
    Str() $text,
    PangoGlyphItem() $glyph_item,
    Int() $x,
    Int() $y
  ) 
    is also<draw-glyph-item> 
  {
    pango_renderer_draw_glyph_item($!pr, $text, $glyph_item, $x, $y);
  }

  method draw_glyphs (
    PangoFont() $font,
    PangoGlyphString() $glyphs,
    Int() $x,
    Int() $y
  ) 
    is also<draw-glyphs> 
  {
    pango_renderer_draw_glyphs($!pr, $font, $glyphs, $x, $y);
  }

  method draw_layout (PangoLayout() $layout, Int() $x, Int() $y) 
    is also<draw-layout> 
  {
    pango_renderer_draw_layout($!pr, $layout, $x, $y);
  }

  method draw_layout_line (PangoLayoutLine() $line, Int() $x, Int() $y) 
    is also<draw-layout-line> 
  {
    pango_renderer_draw_layout_line($!pr, $line, $x, $y);
  }

  method draw_rectangle (
    PangoRenderPart() $part,
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  ) 
    is also<draw-rectangle> 
  {
    pango_renderer_draw_rectangle($!pr, $part, $x, $y, $width, $height);
  }

  method draw_trapezoid (
    PangoRenderPart() $part,
    Num() $y1,
    Num() $x11,
    Num() $x21,
    Num() $y2,
    Num() $x12,
    Num() $x22
  ) 
    is also<draw-trapezoid> 
  {
    pango_renderer_draw_trapezoid(
      $!pr, $part, $y1, $x11, $x21, $y2, $x12, $x22
    );
  }

  method get_alpha (PangoRenderPart() $part) is also<get-alpha> {
    pango_renderer_get_alpha($!pr, $part);
  }

  method get_color (PangoRenderPart() $part) is also<get-color> {
    pango_renderer_get_color($!pr, $part);
  }

  method get_layout is also<get-layout> {
    pango_renderer_get_layout($!pr);
  }

  method get_layout_line is also<get-layout-line> {
    pango_renderer_get_layout_line($!pr);
  }

  method get_type is also<get-type> {
    pango_renderer_get_type();
  }

  method part_changed (PangoRenderPart() $part) is also<part-changed> {
    pango_renderer_part_changed($!pr, $part);
  }

  method set_alpha (PangoRenderPart() $part, Int() $alpha) 
    is also<set-alpha> 
  {
    my guint16 $a = self.RESOLVE-UINT16($alpha);
    pango_renderer_set_alpha($!pr, $part, $a);
  }

  method set_color (PangoRenderPart() $part, PangoColor() $color) 
    is also<set-color> 
  {
    pango_renderer_set_color($!pr, $part, $color);
  }
}
