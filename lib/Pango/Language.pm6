use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Language;
use Pango::Raw::Types;

use Pango::Roles::Types;

class Pango::Language {
  also does Pango::Roles::Types;

  has PangoLanguage $!pl;

  submethod BUILD (:$language) {
    $!pl = $language;
  }

  method new(Str() $s) {
    self.from_string($s);
  }
  method from_string(Str() $s) {
    my $language = pango_language_from_string($s);
    self.bless(:$language);
  }

  method get_default {
    pango_language_get_default($!pl);
  }

  method get_sample_string {
    pango_language_get_sample_string($!pl);
  }

  method get_scripts (Int() $num_scripts) {
    my gint $ns = self.RESOLVE-INT($num_scripts);
    pango_language_get_scripts($!pl, $num_scripts);
  }

  method get_type {
    pango_language_get_type();
  }

  method includes_script (Int() $script) {
    my uint32 $s = self.RESOLVE-UINT($script);
    pango_language_includes_script($!pl, $s);
  }

  method matches (Str() $range_list) {
    pango_language_matches($!pl, $range_list);
  }

  method to_string {
    pango_language_to_string($!pl);
  }

}
