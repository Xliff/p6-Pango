use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;
use Pango::Raw::Attr;

use GLib::GList;
use GLib::Roles::ListData;

class Pango::AttrIter {
  has PangoAttrIterator $!pai is implementor;

  submethod BUILD (:$iter) {
    $!pai = $iter;
  }

  method Pango::Raw::Definitions::PangoAttrIterator
    is also<PangoAttrIter>
  { $!pai }

  method new (PangoAttrIter $iter) {
    self.bless(:$iter);
  }

  method copy {
    pango_attr_iterator_copy($!pai);
  }

  method destroy {
    pango_attr_iterator_destroy($!pai);
  }

  method get (Int() $type) {
    my PangoAttrType $t = $type;

    pango_attr_iterator_get($!pai, $t);
  }

  method get_attrs (:$glist = False) is also<get-attrs> {
    my $al = pango_attr_iterator_get_attrs($!pai);

    return Nil unless $al;
    return $al if $glist;

    (GLib::GList.new($al) but GLib::Roles::ListData[PangoAttribute]).Array;
  }

  proto method get_font (|)
    is also<get-font>
  { * }

  multi method get_font (
    PangoFontDescription() $desc,
    :$none = False,
    :$raw = False
  ) {
    samewith($desc, $, $, :$none, :$raw);
  }
  multi method get_font (
    PangoFontDescription() $desc,
    $language    is rw,
    $extra_attrs is rw,
    :$glist = False,
    :$none = False,
    :$raw = False;
  ) {
    my $la = $none ?? CArray[PangoLanguage] !! CArray[PangoLanguage].new;
    $la[0] = PangoLanguage unless $none;
    my $ea = $none ?? CArray[GList] !! CArray[GSList].new;
    $ea[0] = GSList;

    pango_attr_iterator_get_font($!pai, $desc, $la, $ea);
    unless $none {
      # cw: We can only have one language.
      $language = $la && $la[0] ?? CArrayToArray($la[0], 1) !! Nil;
      if $language {
        $language .= map({ Pango::Language.new($_) }) unless $raw;
        # Again, there is only one value for language.
        $language .= [0];
      }

      my $al = $ea && $ea[0] ?? $ea[0] !! Nil;
      unless $glist {
        $al = GLib::GList.new($al) but GLib::Roles::ListData[PangoAttribute];
        $al = $raw ?? $al.Array !! $al.Array.map({ Pango::Attribute.new($_) });
      }
      $extra_attrs = $al;
    }
    ($language, $extra_attrs);
  }

  method next {
    so pango_attr_iterator_next($!pai);
  }

  multi method range {
    samewith($, $);
  }
  multi method range ($start is rw, $end is rw) {
    my gint ($s, $e) = (0, 0);

    pango_attr_iterator_range($!pai, $s, $e);
    ($start, $end) = ($s, $e);
  }
}
