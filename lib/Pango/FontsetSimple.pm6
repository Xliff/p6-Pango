use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Fontset;
use Pango::Raw::Types;

class Pango::FontsetSimple is Pango::Fontset {
  has PangoFontsetSimple $!pfss;

  submethod BUILD (:$simple) {
    $!pfss = $simple;
    self.setFontset($simple);
  }

  method new {
    my $simple = pango_fontset_simple_new();
    self.bless(:$simple);
  }

  method append (PangoFont() $font) {
    pango_fontset_simple_append($!pfs, $font);
  }

  method get_type {
    pango_fontset_simple_get_type();
  }

  method size {
    pango_fontset_simple_size($!pfs);
  }

}
