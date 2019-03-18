use v6.c;

use Pango::Compat::GList;
use Pango::Compat::Types;
use Pango::Raw::Types;
use Pango::Raw::GlyphString;

use Pango::Roles::Types;

class Pango::GlyphString {
  also does Pango::Roles::Types;

  has PangoGlyphString $!pgs;

  submethod BUILD (:$glyphstring) {
    $!pgs = $glyphstring;
  }

  method Pango::Raw::Types::PangoGlyphString {
    $!pgs;
  }

  method new {
    my $glyphstring = pango_glyph_string_new();
    self.bless(:$glyphstring);
  }

  # STATIC
  # Generic subroutine not tied to any specific object. Consider a catch-all
  # class or package for these.
  method reorder_items (GList() $items) {
    Pango::Compat::GList.new( pango_reorder_items($items) );
  }

  method copy {
    pango_glyph_string_copy($!pgs);
  }

  method extents (
    PangoFont $font,
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect
  ) {
    pango_glyph_string_extents($!pgs, $font, $ink_rect, $logical_rect);
  }

  method extents_range (
    Int() $start,
    Int() $end,
    PangoFont $font,
    PangoRectangle $irect,
    PangoRectangle $lrect
  ) {
    my @i = ($start, $end);
    my gint ($s, $e) = self.RESOLVE-INT(@i);
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
  ) {
    my @i = ($length, $embedding_level, $logical_widths);
    my ($l, $el, $lw) = self.RESOLVE-INT(@i);
    pango_glyph_string_get_logical_widths($!pgs, $text, $l, $el, $lw);
  }

  method get_type {
    pango_glyph_string_get_type();
  }

  method get_width {
    pango_glyph_string_get_width($!pgs);
  }

  method index_to_x (
    Str() $text,
    Int() $length,
    PangoAnalysis $analysis,
    Int() $index,
    Int() $trailing,
    Int() $x_pos
  ) {
    my @i = ($length, $index, $x_pos);
    my ($l, $i, $xp) = self.RESOLVE-INT(@i);
    my gboolean $t = self.RESOLVE-BOOL($trailing);
    pango_glyph_string_index_to_x($!pgs, $text, $l, $analysis, $i, $t, $xp);
  }

  method shape (
    Str() $text,
    gint $length,
    PangoAnalysis $analysis,
    PangoGlyphString $glyphs
  ) {
    pango_shape($text, $length, $analysis, $glyphs);
  }

  method shape_full (
    Str() $item_text,
    Int() $item_length,
    Str() $paragraph_text,
    Int() $paragraph_length,
    PangoAnalysis $analysis,
    PangoGlyphString $glyphs
  ) {
    my @i = ($item_length, $paragraph_length);
    my ($il, $pl) = self.RESOLVE-INT(@i);
    pango_shape_full(
      $item_text,
      $il,
      $paragraph_text,
      $pl,
      $analysis,
      $glyphs
    );
  }

  method set_size (Int() $new_len) {
    my gint $nl = self.RESOLVE-INT($new_len);
    pango_glyph_string_set_size($!pgs, $nl);
  }

  method x_to_index (
    Str() $text,
    Int() $length,
    PangoAnalysis $analysis,
    Int() $x_pos,
    Int() $index,
    Int() $trailing
  ) {
    my @i = ($length, $x_pos, $index, $trailing);
    my ($l, $xp, $i, $t) = self.RESOLVE-INT(@i);
    pango_glyph_string_x_to_index($!pgs, $text, $l, $analysis, $xp, $i, $t);
  }

}
