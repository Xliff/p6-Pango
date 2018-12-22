use v6.c;

use NativeCall;

use Pango::Compat::Types;
use Pango::Context;
use Pango::Raw::Types;
use Pango::Raw::FontMap;

class Pango::FontMap {
  has PangoFontMap $!fm;

  method setFontMap(PangoFontMap $fontmap) {
    $!fm = $fontmap;
  }

  method changed {
    pango_font_map_changed($!fm);
  }

  method create_context {
    my $pc = Pango::Context.new;
    $pc.font_map = $!fm;
    $pc;
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
    my $fl = CArray[CArray[PangoFontFamily]];
    $fl[0] = CArray[PangoFontFamily].new;
    my ($nf, @f) = (0);
    samewith($fl, $nf);
    @f.push( $fl[0][$_].deref ) for ^$nf;
    @f;
  }
  multi method list_families (
    CArray[CArray[PangoFontFamily]] $families,
    Int $n_families is rw;
  ) {
    my int32 $nf = 0;
    my $rc = pango_font_map_list_families($!fm, $families, $nf);
    $n_families = $nf;
    $rc;
  }

  method load_font (
    PangoContext() $context,
    PangoFontDescription() $desc
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
