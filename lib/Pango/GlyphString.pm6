use v6.c;

use Method::Also;

use GLib::GList;

use Pango::Raw::Types;
use Pango::Raw::GlyphString;

use GLib::Roles::ListData;

use GLib::Roles::Implementor;

class Pango::GlyphString {
  also does GLib::Roles::Implementor;

  has PangoGlyphString $!pgs is implementor;

  submethod BUILD (:$glyphstring) {
    $!pgs = $glyphstring;
  }

  method Pango::Raw::Definitions::PangoGlyphString
    is also<PangoGlyphString>
  { $!pgs }

  multi method new (PangoGlyphString $glyphstring) {
    $glyphstring ?? self.bless(:$glyphstring) !! Nil;
  }
  multi method new {
    my $glyphstring = pango_glyph_string_new();

    $glyphstring ?? self.bless(:$glyphstring) !! Nil;
  }

  # Generic subroutine not tied to any specific object. Consider a catch-all
  # class or package for these.
  method reorder_items (
    Pango::GlyphString:U:
    
    GList()  $items,
            :$glist = False
  )
    is also<reorder-items>
  {
    my $ril = pango_reorder_items($items);

    return Nil unless $ril;
    return $ril if $glist;

    my $l = GLib::GList.new($ril) but GLib::Roles::ListData[PangoItem];

    $l.Array;
  }

  method copy {
    my $glyphstring = pango_glyph_string_copy($!pgs);

    $glyphstring ?? Pango::GlyphString.new($glyphstring) !! Nil;
  }

  method extents (
    PangoFont() $font,
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect
  ) {
    pango_glyph_string_extents($!pgs, $font, $ink_rect, $logical_rect);
  }

  method extents_range (
    Int() $start,
    Int() $end,
    PangoFont() $font,
    PangoRectangle $irect,
    PangoRectangle $lrect
  )
    is also<extents-range>
  {
    my gint ($s, $e) = ($start, $end);
    pango_glyph_string_extents_range($!pgs, $s, $e, $font, $irect, $lrect);
  }

  method free {
    pango_glyph_string_free($!pgs);
  }

  method get_logical_widths (
    Str() $text,
    Int() $length,
    Int() $embedding_level,
    Int() $logical_widths
  )
    is also<get-logical-widths>
  {
    my ($l, $el, $lw) = ($length, $embedding_level, $logical_widths);

    pango_glyph_string_get_logical_widths($!pgs, $text, $l, $el, $lw);
  }

  method get_type is also<get-type> {
    pango_glyph_string_get_type();
  }

  method get_width is also<get-width> {
    pango_glyph_string_get_width($!pgs);
  }

  method index_to_x (
    Str() $text,
    Int() $length,
    PangoAnalysis $analysis,
    Int() $index,
    Int() $trailing,
    Int() $x_pos
  )
    is also<index-to-x>
  {
    my ($l, $i, $xp) = ($length, $index, $x_pos);
    my gboolean $t = $trailing;

    pango_glyph_string_index_to_x($!pgs, $text, $l, $analysis, $i, $t, $xp);
  }

  method shape (
    Str() $text,
    gint $length,
    PangoAnalysis $analysis,
    PangoGlyphString() $glyphs
  ) {
    pango_shape($text, $length, $analysis, $glyphs);
  }

  method shape_full (
    Str() $item_text,
    Int() $item_length,
    Str() $paragraph_text,
    Int() $paragraph_length,
    PangoAnalysis $analysis,
    PangoGlyphString() $glyphs
  )
    is also<shape-full>
  {
    my ($il, $pl) = ($item_length, $paragraph_length);

    pango_shape_full(
      $item_text,
      $il,
      $paragraph_text,
      $pl,
      $analysis,
      $glyphs
    );
  }

  method set_size (Int() $new_len) is also<set-size> {
    my gint $nl = $new_len;

    pango_glyph_string_set_size($!pgs, $nl);
  }

  method x_to_index (
    Str() $text,
    Int() $length,
    PangoAnalysis $analysis,
    Int() $x_pos,
    Int() $index,
    Int() $trailing
  )
    is also<x-to-index>
  {
    my ($l, $xp, $i, $t) = ($length, $x_pos, $index, $trailing);

    pango_glyph_string_x_to_index($!pgs, $text, $l, $analysis, $xp, $i, $t);
  }

}
