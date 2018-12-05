use v6.c;

use Pango::Raw::Types;
use Pango::Raw::Renderer;

class Pango::Renderer {
  has PangoRenderer $!pr;

  method activate {
    pango_renderer_activate($!p);
  }

  method deactivate {
    pango_renderer_deactivate($!p);
  }

  method draw_error_underline (
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  ) {
    pango_renderer_draw_error_underline($!p, $x, $y, $width, $height);
  }

  method draw_glyph (
    PangoFont $font,
    PangoGlyph $glyph,
    double $x,
    double $y
  ) {
    pango_renderer_draw_glyph($!p, $font, $glyph, $x, $y);
  }

  method draw_glyph_item (
    Str() $text,
    PangoGlyphItem $glyph_item,
    Int() $x,
    Int() $y
  ) {
    pango_renderer_draw_glyph_item($!p, $text, $glyph_item, $x, $y);
  }

  method draw_glyphs (
    PangoFont $font,
    PangoGlyphString $glyphs,
    Int() $x,
    Int() $y
  ) {
    pango_renderer_draw_glyphs($!p, $font, $glyphs, $x, $y);
  }

  method draw_layout (PangoLayout $layout, Int() $x, Int() $y) {
    pango_renderer_draw_layout($!p, $layout, $x, $y);
  }

  method draw_layout_line (PangoLayoutLine $line, Int() $x, Int() $y) {
    pango_renderer_draw_layout_line($!p, $line, $x, $y);
  }

  method draw_rectangle (
    PangoRenderPart $part,
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  ) {
    pango_renderer_draw_rectangle($!p, $part, $x, $y, $width, $height);
  }

  method draw_trapezoid (
    PangoRenderPart $part,
    Num() $y1,
    Num() $x11,
    Num() $x21,
    Num() $y2,
    Num() $x12,
    Num() $x22
  ) {
    pango_renderer_draw_trapezoid(
      $!p, $part, $y1, $x11, $x21, $y2, $x12, $x22
    );
  }

  method get_alpha (PangoRenderPart $part) {
    pango_renderer_get_alpha($!p, $part);
  }

  method get_color (PangoRenderPart $part) {
    pango_renderer_get_color($!p, $part);
  }

  method get_layout {
    pango_renderer_get_layout($!p);
  }

  method get_layout_line {
    pango_renderer_get_layout_line($!p);
  }

  method get_type {
    pango_renderer_get_type();
  }

  method part_changed (PangoRenderPart $part) {
    pango_renderer_part_changed($!p, $part);
  }

  method set_alpha (PangoRenderPart $part, Int() $alpha) {
    my guint16 = $alpha;
    pango_renderer_set_alpha($!p, $part, $alpha);
  }

  method set_color (PangoRenderPart $part, PangoColor $color) {
    pango_renderer_set_color($!p, $part, $color);
  }
}
