use v6.c;

use Cairo;
use Pango::Compat::Types;
use Pango::Raw::Cairo;
use Pango::Raw::FontMap;
use Pango::Raw::Types;

use Pango::Context;

class Pango::Cairo::FontMap {
  has PangoCairoFontMap $!pcfm;

  submethod BUILD(:$fontmap) {
    $!pcfm = $fontmap;
  }

  method new {
    my $fontmap = pango_cairo_font_map_new();
    self.bless(:$fontmap);
  }

  method new_for_font_type(cairo_font_type_t $type) {
    my $fontmap = pango_cairo_font_map_new_for_font_type($type);
    self.bless(:$fontmap);
  }

  method create_context(PangoFontMap() $pfm) {
    # DEPRECATED.
    #pango_cairo_font_map_create_context($!pc);
    Pango::Context.new( pango_font_map_create_context($pfm) );
  }

  method default is rw {
    Proxy.new(
      FETCH => -> $ {
        pango_cairo_font_map_get_default()
      },
      STORE => -> $, PangoFontMap() $fontmap {
        pango_cairo_font_map_set_default($fontmap);
      }
    );
  }

  # Missing sub declaration and can't find in headers. 
  #
  # method resolution is rw {
  #   Proxy.new(
  #     FETCH => -> $ {
  #       pango_font_map_get_resolution($!pcfm);
  #     },
  #     STORE => -> $, Num() $dpi {
  #       my gdouble $ddpi = $dpi;
  #       pango_font_map_set_resolution($!pcfm, $ddpi);
  #     }
  #   );
  # }
  
  method get_font_type {
    pango_cairo_font_map_get_font_type($!pcfm);
  }

}
