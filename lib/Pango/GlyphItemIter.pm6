use v6.c;

use Method::Also;


use Pango::Raw::GlyphItem;
use Pango::Raw::Types;

class Pango::GlyphItemIter {
  has PangoGlyphItemIter $!pgii;

  submethod BUILD (:$iter) {
    $!pgii = $iter;
  }

  method new (PangoGlyphItemIter $iter) {
    self.bless(:$iter);
  }

  method copy {
    Pango::GlyphItemIter.new( pango_glyph_item_iter_copy($!pgii) );
  }

  method free {
    pango_glyph_item_iter_free($!pgii);
  }

  method get_type is also<get-type> {
    pango_glyph_item_iter_get_type();
  }

  method init_end (PangoGlyphItem() $glyph_item, Str() $text) 
    is also<init-end> 
  {
    so pango_glyph_item_iter_init_end($!pgii, $glyph_item, $text);
  }

  method init_start (PangoGlyphItem() $glyph_item, Str() $text) 
    is also<init-start> 
  {
    so pango_glyph_item_iter_init_start($!pgii, $glyph_item, $text);
  }

  method next_cluster is also<next-cluster> {
    so pango_glyph_item_iter_next_cluster($!pgii);
  }

  method prev_cluster is also<prev-cluster> {
    so pango_glyph_item_iter_prev_cluster($!pgii);
  }
}
