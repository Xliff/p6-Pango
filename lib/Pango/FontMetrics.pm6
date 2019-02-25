use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;
use Pango::Raw::DescriptionMetrics;

use Pango::Roles::Types;

class Pango::FontMetrics {
  also does Pango::Roles::Types;

  has PangoFontMetrics $!pfm;

  submethod BUILD (:$metrics) {
    $!pfm = $metrics;
  }

  submethod DESTROY {
    self.downref;
  }

  multi method new(PangoFontMetrics $metrics) {
    my $o = self.bless(:$metrics);
    $o.upref;
  }
  multi method new {
    my $metrics = pango_font_metrics_new();
    self.bless(:$metrics);
  }

  method get_approximate_char_width {
    pango_font_metrics_get_approximate_char_width($!pfm);
  }

  method get_approximate_digit_width {
    pango_font_metrics_get_approximate_digit_width($!pfm);
  }

  method get_ascent {
    pango_font_metrics_get_ascent($!pfm);
  }

  method get_descent {
    pango_font_metrics_get_descent($!pfm);
  }

  method get_strikethrough_position {
    pango_font_metrics_get_strikethrough_position($!pfm);
  }

  method get_strikethrough_thickness {
    pango_font_metrics_get_strikethrough_thickness($!pfm);
  }

  method get_underline_position {
    pango_font_metrics_get_underline_position($!pfm);
  }

  method get_underline_thickness {
    pango_font_metrics_get_underline_thickness($!pfm);
  }

  method upref {
    pango_font_metrics_ref($!pfm);
    self;
  }

  method downref {
    pango_font_metrics_unref($!pfm);
  }

}
