use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;

use Pango::Roles::Types;

# Grab raw calls. Yes, the name is confusing. Sorry about that.
use Pango::Raw::DescriptionMetrics;

class Pango::Font {
  also does Pango::Roles::Types;

  has PangoFont $!pf;

  submethod BUILD (:$font) {
    $!pf = $font;
  }

  method Pango::Raw::Types::PangoFont {
    $!pf;
  }

  method describe {
    pango_font_describe($!pf);
  }

  method describe_with_absolute_size {
    pango_font_describe_with_absolute_size($!pf);
  }

  method find_shaper (PangoLanguage $language, guint32 $ch) {
    pango_font_find_shaper($!pf, $language, $ch);
  }

  method get_coverage (PangoLanguage $language) {
    pango_font_get_coverage($!pf, $language);
  }

  method get_font_map {
    pango_font_get_font_map($!pf);
  }

  method get_glyph_extents (
    PangoGlyph $glyph,
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect
  ) {
    pango_font_get_glyph_extents($!pf, $glyph, $ink_rect, $logical_rect);
  }

  method get_metrics (PangoLanguage $language) {
    pango_font_get_metrics($!pf, $language);
  }

  method get_type {
    pango_font_get_type();
  }

}
