use v6.c;

use Method::Also;

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

  method describe_with_absolute_size is also<describe-with-absolute-size> {
    pango_font_describe_with_absolute_size($!pf);
  }

  method find_shaper (PangoLanguage $language, guint32 $ch) is also<find-shaper> {
    pango_font_find_shaper($!pf, $language, $ch);
  }

  method get_coverage (PangoLanguage $language) is also<get-coverage> {
    pango_font_get_coverage($!pf, $language);
  }

  method get_font_map is also<get-font-map> {
    pango_font_get_font_map($!pf);
  }

  method get_glyph_extents (
    PangoGlyph $glyph,
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect
  ) is also<get-glyph-extents> {
    pango_font_get_glyph_extents($!pf, $glyph, $ink_rect, $logical_rect);
  }

  method get_metrics (PangoLanguage $language) is also<get-metrics> {
    pango_font_get_metrics($!pf, $language);
  }

  method get_type is also<get-type> {
    pango_font_get_type();
  }

}
