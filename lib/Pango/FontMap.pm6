use v6.c;

use Method::Also;
use NativeCall;

use Pango::Compat::Types;
use Pango::Context;
use Pango::Raw::Types;
use Pango::Raw::FontMap;

class Pango::FontMap {
  has PangoFontMap $!fm;

  method Pango::Compat::Types::PangoFontMap {
    $!fm;
  }
  method fontmap {
    $!fm;
  }

  method setFontMap(PangoFontMap $fontmap) {
    $!fm = $fontmap;
  }

  method changed {
    pango_font_map_changed($!fm);
  }

  method create_context is also<create-context> {
    my $pc = Pango::Context.new;
    $pc.font_map = $!fm;
    $pc;
  }

  method get_serial is also<get-serial> {
    pango_font_map_get_serial($!fm);
  }

  method get_shape_engine_type
    is DEPRECATED
    is also<get-shape-engine-type> 
  {
    pango_font_map_get_shape_engine_type($!fm);
  }

  method get_type is also<get-type> {
    pango_font_map_get_type();
  }

  proto method list_families
    is also<list-families>
    { * }
    
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
  )  {
    my int32 $nf = 0;
    my $rc = pango_font_map_list_families($!fm, $families, $nf);
    $n_families = $nf;
    $rc;
  }

  method load_font (
    PangoContext() $context,
    PangoFontDescription() $desc
  ) 
    is also<load-font> 
  {
    pango_font_map_load_font($!fm, $context, $desc);
  }

  method load_fontset (
    PangoContext() $context,
    PangoFontDescription $desc,
    PangoLanguage $language
  ) 
    is also<load-fontset> 
  {
    pango_font_map_load_fontset($!fm, $context, $desc, $language);
  }

}
