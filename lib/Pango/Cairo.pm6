use v6.c;

use NativeCall;

use Cairo;
use Pango::Compat::Types;
use Pango::Raw::Cairo;
use Pango::Raw::Types;

use Pango::Roles::Types;

use Pango::Context;
use Pango::Layout;

class Pango::Cairo {
  also does Pango::Roles::Types;

  has cairo_t        $!ct;
  has                $!pc;

  submethod BUILD(:$context, :$update, :$cr) {
    $!ct = $cr;
    $!pc = self.create_context;
    self.update_context if $update;
  }

  multi method new (cairo_t $cr, :$update = True) {
    self.bless(:$cr, :$update);
  }
  multi method new_with_fontmap (PangoFontMap() $fontmap, cairo_t $cr) {
    my $context = self.font_map_create_context($fontmap);
    self.bless(:$context, :$cr);
  }

  method context_font_options is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_cairo_context_get_font_options($!pc.context);
      },
      STORE => sub ($, cairo_font_options_t $options is copy) {
        pango_cairo_context_set_font_options($!pc.context, $options);
      }
    );
  }

  method context_resolution is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_cairo_context_get_resolution($!pc.context);
      },
      STORE => sub ($, Num() $dpi is copy) {
        my gdouble $ddpi = $dpi;
        pango_cairo_context_set_resolution($!pc.context, $ddpi);
      }
    );
  }

  method context_get_shape_renderer (Pointer $data = Pointer) {
    pango_cairo_context_get_shape_renderer($!pc.context, $data);
  }

  method context_set_shape_renderer (
    &func,
    $data,
    &dnotify = Callable
  ) {
    die q:to/D/.chomp unless $data.REPR eq <CStruct CPoitner>.any;
<data> parameter must be of CStruct or CPointer representation
D

    pango_cairo_context_set_shape_renderer($!pc.context, &func, $data, &dnotify);
  }

  method create_context(Pango::Cairo:D: ) {
    Pango::Context.new( pango_cairo_create_context($!ct) );
  }

  multi method create_layout {
    samewith($!ct);
  }
  multi method create_layout(cairo_t $context) {
    Pango::Layout.new( pango_cairo_create_layout($context) );
  }

  method error_underline_path (
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $w, $h) = ($x, $y, $width, $height);
    pango_cairo_error_underline_path($!ct, $xx, $yy, $w, $h);
  }

  method font_get_scaled_font(PangoCairoFont $font) {
    pango_cairo_font_get_scaled_font($font);
  }

  method font_get_type {
    pango_cairo_font_get_type();
  }

  method glyph_string_path (PangoFont() $font, PangoGlyphString() $glyphs) {
    pango_cairo_glyph_string_path($!ct, $font, $glyphs);
  }

  method layout_line_path (PangoLayoutLine() $line) {
    pango_cairo_layout_line_path($!ct, $line);
  }

  method layout_path (PangoLayout() $layout) {
    pango_cairo_layout_path($!ct, $layout);
  }

  method show_error_underline (
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) {
    my gdouble ($xx, $yy, $w, $h) = ($x, $y, $width, $height);
    pango_cairo_show_error_underline($!ct, $xx, $yy, $w, $h);
  }

  method show_glyph_item (Str() $text, PangoGlyphItem() $glyph_item) {
    pango_cairo_show_glyph_item($!ct, $text, $glyph_item);
  }

  method show_glyph_string (PangoFont $font, PangoGlyphString $glyphs) {
    pango_cairo_show_glyph_string($!ct, $font, $glyphs);
  }

  method show_layout (PangoLayout() $layout) {
    pango_cairo_show_layout($!ct, $layout);
  }

  method show_layout_line (PangoLayoutLine() $line) {
    pango_cairo_show_layout_line($!ct, $line);
  }

  multi method update_context {
    samewith($!pc);
  }
  multi method update_context(PangoContext() $pc) {
    pango_cairo_update_context($!ct, $pc);
  }

  method update_layout (PangoLayout() $layout) {
    pango_cairo_update_layout($!ct, $layout);
  }

}
