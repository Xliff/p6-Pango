use v6.c;

use Method::Also;

use Pango::Raw::Attr;
use Pango::Raw::Types;

use GLib::Roles::Implementor;

class Pango::AttrList {
  also does GLib::Roles::Implementor;

  has PangoAttrList $!pal is implementor;

  submethod BUILD (:$list) {
    $!pal = $list;
  }

  method Pango::Raw::Definitions::PangoAttrList
    is also<
      AttrList
      PangoAttrList
    >
  { $!pal }

  multi method new (PangoAttrList $list) {
    my $o = self.bless(:$list);
    $o.upref;
  }
  multi method new {
    my $list = pango_attr_list_new();
    $list ?? self.bless(:$list) !! Nil;
  }

  method change (PangoAttributes() $attr) {
    pango_attr_list_change($!pal, $attr.attr);
  }

  method copy (:$raw) {
    my $list = pango_attr_list_copy($!pal);

    $list ??
      ( $raw ?? $list !! Pango::AttrList.new($list) )
      !!
      Nil;
  }

  method filter (&func, gpointer $data = gpointer) {
    pango_attr_list_filter($!pal, &func, $data);
  }

  method get_iterator (:$raw = False) is also<get-iterator> {
    my $iter = pango_attr_list_get_iterator($!pal);

    $iter ??
      ( $raw ?? $iter !! Pango::AttrIter.new($iter) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &pango_attr_list_get_type, $n, $t );
  }

  method insert (PangoAttributes() $attr) {
    pango_attr_list_insert($!pal, $attr);
  }

  method insert_before (PangoAttributes() $attr) is also<insert-before> {
    pango_attr_list_insert_before($!pal, $attr);
  }

  method ref is also<upref> {
    pango_attr_list_ref($!pal);
    self;
  }

  method splice (PangoAttrList() $other, Int() $pos, Int() $len) {
    my gint ($p, $l) = ($pos, $len);

    pango_attr_list_splice($!pal, $other, $pos, $len);
  }

  method unref is also<downref> {
    pango_attr_list_unref($!pal);
  }
}
