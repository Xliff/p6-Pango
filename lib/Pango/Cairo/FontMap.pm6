use v6.c;

use Cairo;
use Pango::Compat::Types;
use Pango::Raw::Cairo;
use Pango::Raw::FontMap;
use Pango::Raw::Types;


class Pango::Cairo::FontMap {
  has PangoFontMap $!pcfm;

  submethod BUILD(:$fontmap) {
    $!pcfm = $fontmap;
  }

  method new {
    my $fontmap = pango_cairo_font_map_new();
    self.bless(:$fontmap);
  }

  method new_for_font_type(cairo_font_type_t $type_) {
    my $fontmap = pango_cairo_font_map_new_for_font_type($type);
    self.bless(:$fontmap);
  }

  method create_context(PangoFontMap() $pfm) {
    # DEPRECATED.
    #pango_cairo_font_map_create_context($!pc);
    pango_font_map_create_context($pfm);
  }

  method default is rw {
    Proxy.new(
      FETCH => $ {
        pango_cairo_font_map_get_default()
      },
      STORE => $, PangoFontMap() $fontmap {
        pango_cairo_font_map_set_default($fontmap);
      }
    );
  }

  method resolution is rw {
    Proxy.new(
      FETCH => $ {
        pango_font_map_get_resolution($!pfm);
      },
      STORE => $, Num() $dpi {
        my gdouble $ddpi = $dpi;
        pango_font_map_set_resolution($pfm, $ddpi);
      }
    );
  }
  
  method get_font_type {
    pango_cairo_font_map_get_font_type($!pcfm);
  }

}
