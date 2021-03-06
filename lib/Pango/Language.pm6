use v6.c;

use Method::Also;

use Pango::Raw::Language;
use Pango::Raw::Types;

class Pango::Language {
  has PangoLanguage $!pl;

  submethod BUILD (:$language) {
    $!pl = $language;
  }

  method Pango::Raw::Definitions::PangoLanguage
    is also<PangoLanguage>
  { $!pl }

  multi method new (PangoLanguage $language) {
    $language ?? self.bless($language) !! Nil;
  }
  multi method new(Str() $s) {
    self.from_string($s);
  }

  method from_string(Str() $s)
    is also<
      from-string
      new_from_string
      new-from-string
    >
  {
    my $language = pango_language_from_string($s);

    $language ?? self.bless($language) !! Nil;
  }

  method get_default is also<get-default> {
    my $language = pango_language_get_default();

    $language ?? self.bless($language) !! Nil;
  }

  method get_sample_string is also<get-sample-string> {
    pango_language_get_sample_string($!pl);
  }

  method get_scripts (Int() $num_scripts) is also<get-scripts> {
    my gint $ns = $num_scripts;

    pango_language_get_scripts($!pl, $num_scripts);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &pango_language_get_type, $n, $t );
  }

  method includes_script (Int() $script) is also<includes-script> {
    my uint32 $s = $script;

    pango_language_includes_script($!pl, $s);
  }

  method matches (Str() $range_list) {
    pango_language_matches($!pl, $range_list);
  }

  method to_string is also<to-string> {
    pango_language_to_string($!pl);
  }

}
