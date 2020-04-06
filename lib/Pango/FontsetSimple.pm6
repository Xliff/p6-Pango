use v6.c;

use Method::Also;


use Pango::Raw::Fontset;
use Pango::Raw::Types;

use Pango::Fontset;

class Pango::FontsetSimple is Pango::Fontset {
  has PangoFontsetSimple $!pfss;

  submethod BUILD (:$simple) {
    $!pfss = $simple;
    self.setFontset($simple);
  }

  method Pango::Raw::Definitions::PangoFontsetSimple
    is also<PangoFontsetSimple>
  { $!pfss }

  multi method new (PangoFontsetSimple $simple) {
    $simple ?? self.bless(:$simple) !! Nil;
  }
  multi method new (PangoLanguage() $lang) {
    my $simple = pango_fontset_simple_new($lang);

    $simple ?? self.bless(:$simple) !! Nil;
  }

  method append (PangoFont() $font) {
    pango_fontset_simple_append($!pfss, $font);
  }

  method get_type is also<get-type> {
    pango_fontset_simple_get_type();
  }

  method size {
    pango_fontset_simple_size($!pfss);
  }

}
