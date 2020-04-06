use v6.c;

use Method::Also;


use Pango::Raw::Types;
use Pango::Raw::DescriptionMetrics;

class Pango::FontMetrics {
  has PangoFontMetrics $!pfm;

  submethod BUILD (:$metrics) {
    $!pfm = $metrics;
  }

  submethod DESTROY {
    self.downref;
  }

  multi method Pango::Raw::Definitions::PangoFontMetrics
    is also<PangoFontMetrics>
  { $!pfm }

  multi method new(PangoFontMetrics $metrics) {
    my $o = self.bless(:$metrics);
    $o.upref;
  }
  multi method new {
    my $metrics = pango_font_metrics_new();

    $metrics ?? self.bless(:$metrics) !! Nil;
  }

  method get_approximate_char_width is also<get-approximate-char-width> {
    pango_font_metrics_get_approximate_char_width($!pfm);
  }

  method get_approximate_digit_width is also<get-approximate-digit-width> {
    pango_font_metrics_get_approximate_digit_width($!pfm);
  }

  method get_ascent is also<get-ascent> {
    pango_font_metrics_get_ascent($!pfm);
  }

  method get_descent is also<get-descent> {
    pango_font_metrics_get_descent($!pfm);
  }

  method get_strikethrough_position is also<get-strikethrough-position> {
    pango_font_metrics_get_strikethrough_position($!pfm);
  }

  method get_strikethrough_thickness is also<get-strikethrough-thickness> {
    pango_font_metrics_get_strikethrough_thickness($!pfm);
  }

  method get_underline_position is also<get-underline-position> {
    pango_font_metrics_get_underline_position($!pfm);
  }

  method get_underline_thickness is also<get-underline-thickness> {
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
