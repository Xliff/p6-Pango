use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Attr;
use Pango::Raw::Types;

use Pango::Roles::Types;

class Pango::AttrIter {
  also does Pango::Roles::Types;

  has PangoAttrIterator $!pai;

  submethod BUILD (:$iter) {
    $!pai = $iter;
  }

  method new (PangoAttrIter $iter) {
    self.bless(:$iter);
  }

  method copy {
    pango_attr_iterator_copy($!pa);
  }

  method destroy {
    pango_attr_iterator_destroy($!pa);
  }

  method get (PangoAttrType $type) {
    pango_attr_iterator_get($!pa, $type);
  }

  method get_attrs {
    pango_attr_iterator_get_attrs($!pa);
  }

  method get_font (
    PangoFontDescription() $desc,
    PangoLanguage() $language,
    GSList() $extra_attrs
  ) {
    pango_attr_iterator_get_font($!pa, $desc, $language, $extra_attrs);
  }

  method next {
    pango_attr_iterator_next($!pa);
  }

  method range (Int() $start, Int() $end) {
    my @i = ($start, $end);
    my gint ($s, $e) = self.RESOLVE-INT(@i);
    pango_attr_iterator_range($!pa, $start, $end);
  }
}
