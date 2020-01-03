use v6.c;

use Method::Also;


use Pango::Raw::GlyphItem;
use Pango::Raw::Types;

use Pango::Roles::Types;

# FINISH REFINING

class Pango::GlyphItem {
  also does Pango::Roles::Types;

  has PangoGlyphItem $!pgi;

  submethod BUILD(:$item) {
    $!pgi = $item;
  }

  method Pango::Raw::Types::PangoGlyphItem {
    $!pgi;
  }

  method new (PangoGlyphItem $item) {
    self.bless($item);
  }

  method apply_attrs (Str() $text, PangoAttrList $list) is also<apply-attrs> {
    pango_glyph_item_apply_attrs($!pgi, $text, $list);
  }

  method copy {
    Pango::GlyphItem.new( pango_glyph_item_copy($!pgi) );
  }

  method free {
    pango_glyph_item_free($!pgi);
  }

  method get_logical_widths (Str() $text, Int() $logical_widths) 
    is also<get-logical-widths> 
  {
    my gint $lw = self.RESOLVE-INT($logical_widths);
    pango_glyph_item_get_logical_widths($!pgi, $text, $lw);
  }

  method letter_space (
    Str() $text,
    PangoLogAttr $log_attrs,
    Int() $letter_spacing
  ) is also<letter-space> {
    my gint $ls = self.RESOLVE-INT($letter_spacing);
    pango_glyph_item_letter_space($!pgi, $text, $log_attrs, $ls);
  }

  method split (Str() $text, Int() $split_index) {
    my gint $si = self.RESOLVE-INT($split_index);
    Pango::GlyphItem.new( pango_glyph_item_split($!pgi, $text, $si) );
  }

}
