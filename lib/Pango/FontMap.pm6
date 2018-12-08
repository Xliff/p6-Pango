use v6.c;

use Pango::Compat::Types;
use Pango::Raw::TYpes;

class Pango::FontMap {

  method changed {
    pango_font_map_changed($!fm);
  }

  method create_context {
    pango_font_map_create_context($!fm);
  }

  method get_serial {
    pango_font_map_get_serial($!fm);
  }

  method get_shape_engine_type
    is DEPRECATED
  {
    pango_font_map_get_shape_engine_type($!fm);
  }

  method get_type {
    pango_font_map_get_type();
  }

  multi method list_families {
    my $fl = CArray[CArray[Pointer[PangoFontFamily]]];
    $fl[0] = CArray[Pointer[PangoFontFamily]].new;
    my($nf, @f) = (0);
    samewith($fl, $nf);
    @f.push( $fl[0][$_].deref ) for ^$nf;
    @f;
  }
  method list_families (
    CArray[CArray[Pointer[PangoFontFamily]]] $families,
    Int $n_families is rw;
  ) {
    my gint $nf = 0;
    my $rc = pango_font_map_list_families($!fm, $families, $nf);
    $n_families = $nf;
    $rc;
  }

  method load_font (
    PangoContext() $context,
    PangoFontDescription $desc
  ) {
    pango_font_map_load_font($!fm, $context, $desc);
  }

  method load_fontset (
    PangoContext() $context,
    PangoFontDescription $desc,
    PangoLanguage $language
  ) {
    pango_font_map_load_fontset($!fm, $context, $desc, $language);
  }

}
