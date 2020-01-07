use v6.c;

use Method::Also;

use Pango::Raw::GlyphItem;
use Pango::Raw::Types;

# FINISH REFINING

class Pango::GlyphItem {
  has PangoGlyphItem $!pgi;

  submethod BUILD(:$item) {
    $!pgi = $item;
  }

  method Pango::Raw::Definitions::PangoGlyphItem
    is also<PangoGlyphItem>
  { $!pgi }

  method new (PangoGlyphItem $item, :$ref) {
    # $ref is a holdover until it is known whether we need ref/unref logic,
    # here.
    $item ?? self.bless($item) !! Nil;
  }

  method apply_attrs (Str() $text, PangoAttrList() $list)
    is also<apply-attrs>
  {
    pango_glyph_item_apply_attrs($!pgi, $text, $list);
  }

  method copy {
    my $item = pango_glyph_item_copy($!pgi);

    $item ?? PangoGlyphItem.new($item, :!ref) !! Nil;
  }

  method free {
    pango_glyph_item_free($!pgi);
  }

  method get_logical_widths (Str() $text, Int() $logical_widths)
    is also<get-logical-widths>
  {
    my gint $lw = $logical_widths;

    pango_glyph_item_get_logical_widths($!pgi, $text, $lw);
  }

  method letter_space (
    Str() $text,
    PangoLogAttr $log_attrs,
    Int() $letter_spacing
  )
    is also<letter-space>
  {
    my gint $ls = $letter_spacing;

    pango_glyph_item_letter_space($!pgi, $text, $log_attrs, $ls);
  }

  method split (Str() $text, Int() $split_index) {
    my gint $si = $split_index;
    my $item = pango_glyph_item_split($!pgi, $text, $si);

    $item ?? Pango::GlyphItem.new($item, :!ref) !! Nil;
  }

}
