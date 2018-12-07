use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Attr;
use Pango::Raw::Types;

use Pango::Roles::Types;

class Pango::AttrList {
  also does Pango::Roles::Types;

  has PangoAttrList $!pal;

  submethod BUILD (:$list) {
    $!pal = $list;
  }

  method new {
    my $list = pango_attr_list_new();
    self.bless(:$list);
  }

  method change (PangoAttribute $attr) {
    pango_attr_list_change($!pa, $attr);
  }

  method copy {
    pango_attr_list_copy($!pa);
  }

  method filter (&func, gpointer $data = gpointer) {
    pango_attr_list_filter($!pa, &func, $data);
  }

  method get_iterator {
    pango_attr_list_get_iterator($!pa);
  }

  method get_type {
    pango_attr_list_get_type();
  }

  method insert (PangoAttribute $attr) {
    pango_attr_list_insert($!pa, $attr);
  }

  method insert_before (PangoAttribute $attr) {
    pango_attr_list_insert_before($!pa, $attr);
  }

  method upref {
    pango_attr_list_ref($!pa);
  }

  method splice (PangoAttrList $other, Int() $pos, Int() $len) {
    my @i = ($pos, $len);
    my gint ($p, $l) = self.RESOLVE-INT(@i);
    pango_attr_list_splice($!pa, $other, $pos, $len);
  }

  method downref {
    pango_attr_list_unref($!pa);
  }
}
