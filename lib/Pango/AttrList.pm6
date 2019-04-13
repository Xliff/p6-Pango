use v6.c;

use Method::Also;

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

  method Pango::Raw::Types::PangoAttrList is also<AttrList> { $!pal }

  multi method new (PangoAttrList $list) {
    my $o = self.bless(:$list);
    $o.upref;
  }
  multi method new {
    my $list = pango_attr_list_new();
    self.bless(:$list);
  }

  method change (PangoAttributes() $attr) {
    pango_attr_list_change($!pal, $attr.attr);
  }

  method copy {
    pango_attr_list_copy($!pal);
  }

  method filter (&func, gpointer $data = gpointer) {
    pango_attr_list_filter($!pal, &func, $data);
  }

  method get_iterator is also<get-iterator> {
    pango_attr_list_get_iterator($!pal);
  }

  method get_type is also<get-type> {
    pango_attr_list_get_type();
  }

  method insert (PangoAttributes() $attr) {
    pango_attr_list_insert($!pal, $attr.attr);
  }

  method insert_before (PangoAttributes() $attr) is also<insert-before> {
    pango_attr_list_insert_before($!pal, $attr.attr);
  }

  method ref is also<upref> {
    pango_attr_list_ref($!pal);
    self;
  }

  method splice (PangoAttrList() $other, Int() $pos, Int() $len) {
    my @i = ($pos, $len);
    my gint ($p, $l) = self.RESOLVE-INT(@i);
    pango_attr_list_splice($!pal, $other, $pos, $len);
  }

  method unref is also<downref> {
    pango_attr_list_unref($!pal);
  }
}
