use v6.c;

use NativeCall;

use Pango::Compat::Types;
use Pango::Raw::FT2FontMap;
use Pango::Raw::Types;

use Pango::FontMap::FC;

class Pango::FontMap::FT2 is Pango::FontMap::FC {
  has PangoFT2FontMap $!pft2fm;

  submethod BUILD(:$ft2map) {
    $!pft2fm = $ft2map;
    self.setFCFontMap($ft2map);
  }

  method Pango::Raw::Types::PangoFT2FontMap {
    $!pft2fm;
  }

  method new {
    my $ft2map = pango_ft2_font_map_new();
    self.bless(:$ft2map);
  }

  # method for_display
  #   is DEPRECATED
  # {
  #   pango_ft2_font_map_for_display($!pft2fm);
  # }

  method get_type {
    pango_ft2_font_map_get_type();
  }

  # method pango_ft2_font_get_coverage (PangoLanguage() $language)
  #   is DEPRECATED
  # {
  #   pango_ft2_font_get_coverage($!pft2fm, $language);
  # }
  #
  # method pango_ft2_font_get_face
  #   is DEPRECATED
  # {
  #   pango_ft2_font_get_face($!pft2fm);
  # }

  # method pango_ft2_font_get_kerning (PangoGlyph $left, PangoGlyph $right)
  #   is DEPRECATED
  # {
  #   pango_ft2_font_get_kerning($!pft2fm, $left, $right);
  # }
  #
  # method pango_ft2_get_context (Num() $dpi_y)
  #   is DEPRECATED('create_context')
  # {
  #   my gdouble $dy = $dpi_y;
  #   pango_ft2_get_context($!pft2fm, $dy);
  # }
  #
  # method pango_ft2_get_unknown_glyph
  #   is DEPRECATED
  # {
  #   pango_ft2_get_unknown_glyph($!pft2fm);
  # }

  method !resolve_bitmap($buf) {
    do given $buf {
      when Buf[uint8] { nativecast(Pointer, $_) }
      default {
        die "Pango::FontMap::FT2.render_layout handling of { .^name } NYI."
      }
    }
  }

  method render (
    $buf,
    PangoFont() $font,
    PangoGlyphString() $glyphs,
    Int() $x,
    Int() $y
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    my $b = self!resolve_bitmap($buf);
    pango_ft2_render($b, $font, $glyphs, $x, $y);
  }

  method render_layout (
    $buf,
    PangoLayout() $layout,
    Int() $x,
    Int() $y
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    # Will need type dependent handling, here. For now, handle only Buf
    my $b = self!resolve_bitmap($buf);

    pango_ft2_render_layout($layout, $b, $xx, $yy);
  }

  method render_layout_line (
    $buf,
    PangoLayoutLine() $line,
    Int() $x,
    Int() $y
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    my $b = self!resolve_bitmap($buf);
    pango_ft2_render_layout_line($b, $line, $xx, $yy);
  }

  method render_layout_line_subpixel (
    $buf,
    PangoLayoutLine() $line,
    Int() $x,
    Int() $y
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    my $b = self!resolve_bitmap($buf);
    pango_ft2_render_layout_line_subpixel($b, $line, $xx, $yy);
  }

  method render_layout_subpixel (
    $buf,
    PangoLayout() $layout,
    Int() $x,
    Int() $y
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    my $b = self!resolve_bitmap($buf);
    pango_ft2_render_layout_subpixel($b, $layout, $xx, $yy);
  }

  method render_transformed (
    $buf,
    PangoMatrix() $matrix,
    PangoFont() $font,
    PangoGlyphString() $glyphs,
    Int() $x,
    Int() $y
  ) {
    my @i = ($x, $y);
    my gint ($xx, $yy) = self.RESOLVE-INT(@i);
    my $b = self!resolve_bitmap($buf);
    pango_ft2_render_transformed(
      $b, $matrix, $font, $glyphs, $xx, $yy
    );
  }

  method set_default_substitute (&func, $data, &notify = Callable) {
    die q:to/D/.chomp unless $data.REPR eq <CStruct CPoitner>.any;
<data> parameter must be of CStruct or CPointer representation
D

    pango_ft2_font_map_set_default_substitute(
      $!pft2fm, &func, cast(Pointer, $data), &notify
    );
  }

  method set_resolution (Num() $dpi_x, Num() $dpi_y) {
    my gdouble ($dx, $dy) = ($dpi_x, $dpi_y);
    pango_ft2_font_map_set_resolution($!pft2fm, $dx, $dy);
  }

  method substitute_changed {
    pango_ft2_font_map_substitute_changed($!pft2fm);
  }

}
