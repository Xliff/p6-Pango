use v6.c;

use Method::Also;
use NativeCall;

use Pango::Context;
use Pango::Raw::Types;
use Pango::Raw::FontMap;

class Pango::FontMap {
  has PangoFontMap $!fm;

  method Pango::Raw::Definitions::PangoFontMap
    is also<
      PangoFontMap
      fontmap
    >
  { $!fm }

  method setFontMap (PangoFontMap $fontmap) {
    $!fm = $fontmap;
  }

  method changed {
    so pango_font_map_changed($!fm);
  }

  method create_context is also<create-context> {
    my $pc = Pango::Context.new;
    return Nil unless $pc;
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
    state ($n, $t);

    unstable_get_type( self.^name, &pango_font_map_get_type, $n, $t );
  }

  proto method list_families (|)
    is also<list-families>
  { * }

  multi method list_families (:$raw = False) {
    my ($fl, $nf) = (CArray[CArray[PangoFontFamily]], 0);
    $fl[0] = CArray[PangoFontFamily];
    samewith($fl, $nf, :$raw);
  }
  multi method list_families (
    CArray[CArray[PangoFontFamily]] $families,
    $n_families is rw,
    :$raw = False
  ) {
    my int32 $nf = 0;
    my $rc = pango_font_map_list_families($!fm, $families, $nf);
    $n_families = $nf;

    my @a = CArrayToArray($rc[0], $n_families);
    return @a if $raw;

    @a.map({ Pango::FontFamily.new($_) });
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
    PangoFontDescription() $desc,
    PangoLanguage() $language
  )
    is also<load-fontset>
  {
    pango_font_map_load_fontset($!fm, $context, $desc, $language);
  }

}
