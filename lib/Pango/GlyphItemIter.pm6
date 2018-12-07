use v6.c;

use Pango::Compat::Types;
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
    Pango::GlyphItemIter.new( pango_glyph_item_iter_copy($!pgi) );
  }

  method free {
    pango_glyph_item_iter_free($!pgi);
  }

  method get_type {
    pango_glyph_item_iter_get_type();
  }

  method init_end (PangoGlyphItem() $glyph_item, Str() $text) {
    so pango_glyph_item_iter_init_end($!pgi, $glyph_item, $text);
  }

  method init_start (PangoGlyphItem() $glyph_item, Str() $text) {
    so pango_glyph_item_iter_init_start($!pgi, $glyph_item, $text);
  }

  method next_cluster {
    so pango_glyph_item_iter_next_cluster($!pgi);
  }

  method prev_cluster {
    so pango_glyph_item_iter_prev_cluster($!pgi);
  }
}
