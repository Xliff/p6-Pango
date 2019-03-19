use v6.c;

use Method::Also;

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
    pango_attr_iterator_copy($!pai);
  }

  method destroy {
    pango_attr_iterator_destroy($!pai);
  }

  method get (PangoAttrType $type) {
    pango_attr_iterator_get($!pai, $type);
  }

  method get_attrs is also<get-attrs> {
    pango_attr_iterator_get_attrs($!pai);
  }

  method get_font (
    PangoFontDescription() $desc,
    PangoLanguage() $language,
    GSList() $extra_attrs
  ) 
    is also<get-font> 
  {
    pango_attr_iterator_get_font($!pai, $desc, $language, $extra_attrs);
  }

  method next {
    pango_attr_iterator_next($!pai);
  }

  method range (Int() $start, Int() $end) {
    my @i = ($start, $end);
    my gint ($s, $e) = self.RESOLVE-INT(@i);
    pango_attr_iterator_range($!pai, $start, $end);
  }
}
