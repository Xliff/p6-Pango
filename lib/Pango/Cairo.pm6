use v6.c;

use Method::Also;
use NativeCall;

use Cairo;
use Pango::Compat::Types;
use Pango::Raw::Cairo;
use Pango::Raw::Types;

use Pango::Roles::Types;

use Pango::Context;
use Pango::Layout;

# Consider augment to Cairo::Context to add type coercion.

class Pango::Cairo {
  also does Pango::Roles::Types;

  has cairo_t        $!ct;
  has                $!pc;
  has                $!pl;

  # Where was :$context intended? $!pc?

  submethod BUILD(:$context, :$update, :$cr) {
    $!ct = $cr;
    $!pc = $context // self.create_pc_context;
    self.update_context if $update;
  }

  multi method new (Cairo::Context $cr, :$update = True) {
    samewith($cr.context, :$update);
  }
  multi method new (cairo_t $cr, :$update = True) {
    self.bless(:$cr, :$update);
  }

  method pango_context is also<pango-context> {
    $!pc;
  }

  method cairo_context is also<cairo-context> {
    $!ct;
  }

  method new_with_fontmap (
    PangoFontMap() $fontmap,
    cairo_t $cr,
    :$update = True
  ) 
    is also<new-with-fontmap> 
  {
    my $context = Pango::Context.new( self.font_map_create_context($fontmap) );
    self.bless(:$context, :$update, :$cr);
  }

  method context_font_options is rw is also<context-font-options> {
    Proxy.new(
      FETCH => sub ($) {
        pango_cairo_context_get_font_options($!pc.context);
      },
      STORE => sub ($, cairo_font_options_t $options is copy) {
        pango_cairo_context_set_font_options($!pc.context, $options);
      }
    );
  }

  method context_resolution is rw is also<context-resolution> {
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

  # method !resolve-data ($data) {
  #   do given $data {
  #     when .defined.not        { Pointer }
  #     when .REPR eq 'CPointer' { }
  #     when .REPR eq 'CStruct'  { nativecast(Pointer, $data) }
  #     default {
  #       die qq:to/D/.chomp;
  #       <data> parameter { $data.^name } must be of CStruct or CPointer { ''
  #       } representation
  #       D
  #     }
  #   }
  # }

  method context_get_shape_renderer is also<context-get-shape-renderer> {
    my $p = Pointer.new;
    pango_cairo_context_get_shape_renderer(
      $!pl.get_context,
      $p
    );
  }

  method context_set_shape_renderer (
    &func,
    $data?,
    &dnotify = Callable
  ) 
    is also<context-set-shape-renderer> 
  {
    CATCH { default { .message.say } }

    self.create_context without $!pl;
    # Yes. This is fucking confusing! We want the LAYOUT context, not the
    # PangoCairo context or the Cairo context.
    pango_cairo_context_set_shape_renderer(
      $!pl.get_context,
      -> $ct, $ps, $dp, $ {
        CATCH { default { .message.say } }

        &func($ct, $ps, $dp, $data)
      },
      Pointer,
      Pointer
    );
  }

  method create_pc_context(Pango::Cairo:D: ) is also<create-pc-context> {
    Pango::Context.new( pango_cairo_create_context($!ct) );
  }

  # To prevent confusion, this should probably be the only
  # version of this method.
  proto method create_layout (|)
    is also<create-layout>
  { * }
  
  multi method create_layout(Pango::Cairo:D:) {
    $!pl = Pango::Layout.new( pango_cairo_create_layout($!ct) );
  }
  multi method create_layout(Pango::Cairo:U: cairo_t $context) {
    Pango::Layout.new( pango_cairo_create_layout($context) );
  }

  method error_underline_path (
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) 
    is also<error-underline-path> 
  {
    my gdouble ($xx, $yy, $w, $h) = ($x, $y, $width, $height);
    pango_cairo_error_underline_path($!ct, $xx, $yy, $w, $h);
  }

  method font_get_scaled_font(PangoCairoFont() $font) 
    is also<font-get-scaled-font> 
  {
    pango_cairo_font_get_scaled_font($font);
  }

  method font_get_type is also<font-get-type> {
    pango_cairo_font_get_type();
  }

  method glyph_string_path (PangoFont() $font, PangoGlyphString() $glyphs) 
    is also<glyph-string-path> 
  {
    pango_cairo_glyph_string_path($!ct, $font, $glyphs);
  }

  method layout_line_path (PangoLayoutLine() $line) 
    is also<layout-line-path> 
  {
    pango_cairo_layout_line_path($!ct, $line);
  }

  method layout_path (PangoLayout() $layout) is also<layout-path> {
    pango_cairo_layout_path($!ct, $layout);
  }

  method show_error_underline (
    Num() $x,
    Num() $y,
    Num() $width,
    Num() $height
  ) 
    is also<show-error-underline> 
  {
    my gdouble ($xx, $yy, $w, $h) = ($x, $y, $width, $height);
    pango_cairo_show_error_underline($!ct, $xx, $yy, $w, $h);
  }

  method show_glyph_item (Str() $text, PangoGlyphItem() $glyph_item) 
    is also<show-glyph-item> 
  {
    pango_cairo_show_glyph_item($!ct, $text, $glyph_item);
  }

  method show_glyph_string (PangoFont() $font, PangoGlyphString() $glyphs) 
    is also<show-glyph-string> 
  {
    pango_cairo_show_glyph_string($!ct, $font, $glyphs);
  }

  method show_layout (PangoLayout() $layout) is also<show-layout> {
    pango_cairo_show_layout($!ct, $layout);
  }

  method show_layout_line (PangoLayoutLine() $line) is also<show-layout-line> {
    pango_cairo_show_layout_line($!ct, $line);
  }

  proto method update_context (|)
    is also<update-context>
  { * }
  
  multi method update_context {
    samewith($!pc);
  }
  multi method update_context(PangoContext() $apc) {
    pango_cairo_update_context($!ct, $apc);
  }

  method update_layout (PangoLayout() $layout) is also<update-layout> {
    pango_cairo_update_layout($!ct, $layout);
  }

}
