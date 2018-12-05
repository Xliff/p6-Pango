use v6.c;

use NativeCall;

use Pango::Compat::Types;

use Pango::Raw::Types;
use Pango::Raw::Layout;

use Pango::Roles::Types;
use Pango::Roles::References;

class Pango::Layout {
  also does Pango::Roles::Types;
  also does Pango::Roles::References;

  has PangoLayout $!pl;

  submethod BUILD(:$layout) {
    $!pl = $layout;
  }

  multi method new (PangoLayout $layout) {
    my $o = self.bless(:$layout);
    $o.upref;
    $o;
  }
  method new (PangoContext $context) {
    my $layout = pango_layout_new($context);
    self.bless(:$layout);
  }

  method copy {
    my $layout = pango_layout_copy($!pl);
    self.bless(:$layout);
  }

  # ↓↓↓↓ SIGNALS ↓↓↓↓
  # ↑↑↑↑ SIGNALS ↑↑↑↑

  # ↓↓↓↓ ATTRIBUTES ↓↓↓↓
  method alignment is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_alignment($!pl);
      },
      STORE => sub ($, $alignment is copy) {
        pango_layout_set_alignment($!pl, $alignment);
      }
    );
  }

  method attributes is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_attributes($!pl);
      },
      STORE => sub ($, $attrs is copy) {
        pango_layout_set_attributes($!pl, $attrs);
      }
    );
  }

  method auto_dir is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_auto_dir($!pl);
      },
      STORE => sub ($, $auto_dir is copy) {
        pango_layout_set_auto_dir($!pl, $auto_dir);
      }
    );
  }

  method ellipsize is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_ellipsize($!pl);
      },
      STORE => sub ($, $ellipsize is copy) {
        pango_layout_set_ellipsize($!pl, $ellipsize);
      }
    );
  }

  method font_description is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_font_description($!pl);
      },
      STORE => sub ($, $desc is copy) {
        pango_layout_set_font_description($!pl, $desc);
      }
    );
  }

  method height is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_height($!pl);
      },
      STORE => sub ($, $height is copy) {
        pango_layout_set_height($!pl, $height);
      }
    );
  }

  method indent is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_indent($!pl);
      },
      STORE => sub ($, $indent is copy) {
        pango_layout_set_indent($!pl, $indent);
      }
    );
  }

  method justify is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_justify($!pl);
      },
      STORE => sub ($, $justify is copy) {
        pango_layout_set_justify($!pl, $justify);
      }
    );
  }

  method single_paragraph_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_single_paragraph_mode($!pl);
      },
      STORE => sub ($, $setting is copy) {
        pango_layout_set_single_paragraph_mode($!pl, $setting);
      }
    );
  }

  method spacing is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_spacing($!pl);
      },
      STORE => sub ($, $spacing is copy) {
        pango_layout_set_spacing($!pl, $spacing);
      }
    );
  }

  method tabs is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_tabs($!pl);
      },
      STORE => sub ($, $tabs is copy) {
        pango_layout_set_tabs($!pl, $tabs);
      }
    );
  }

  method width is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_width($!pl);
      },
      STORE => sub ($, $width is copy) {
        pango_layout_set_width($!pl, $width);
      }
    );
  }

  method wrap is rw {
    Proxy.new(
      FETCH => sub ($) {
        pango_layout_get_wrap($!pl);
      },
      STORE => sub ($, $wrap is copy) {
        pango_layout_set_wrap($!pl, $wrap);
      }
    );
  }
  # ↑↑↑↑ ATTRIBUTES ↑↑↑↑

  # ↓↓↓↓ PROPERTIES ↓↓↓↓
  # ↑↑↑↑ PROPERTIES ↑↑↑↑

  # ↓↓↓↓ METHODS ↓↓↓↓
  method context_changed {
    pango_layout_context_changed($!pl);
  }

  method get_character_count {
    pango_layout_get_character_count($!pl);
  }

  method get_context {
    pango_layout_get_context($!pl);
  }

  method get_cursor_pos (
    int32 $index,
    PangoRectangle $strong_pos,
    PangoRectangle $weak_pos
  ) {
    pango_layout_get_cursor_pos($!pl, $index, $strong_pos, $weak_pos);
  }

  method get_iter {
    pango_layout_get_iter($!pl);
  }

  method get_line_count {
    pango_layout_get_line_count($!pl);
  }

  method get_lines {
    pango_layout_get_lines($!pl);
  }

  method get_lines_readonly {
    pango_layout_get_lines_readonly($!pl);
  }

  method get_log_attrs (PangoLogAttr $attrs, gint $n_attrs) {
    pango_layout_get_log_attrs($!pl, $attrs, $n_attrs);
  }

  method get_log_attrs_readonly (gint $n_attrs) {
    pango_layout_get_log_attrs_readonly($!pl, $n_attrs);
  }

  method get_pixel_size (int $width, int $height) {
    pango_layout_get_pixel_size($!pl, $width, $height);
  }

  method get_serial {
    pango_layout_get_serial($!pl);
  }

  method get_size (int $width, int $height) {
    pango_layout_get_size($!pl, $width, $height);
  }

  method get_text {
    pango_layout_get_text($!pl);
  }

  method get_unknown_glyphs_count {
    pango_layout_get_unknown_glyphs_count($!pl);
  }

  method index_to_line_x (int $index, gboolean $trailing, int $line, int $x_pos) {
    pango_layout_index_to_line_x($!pl, $index, $trailing, $line, $x_pos);
  }

  method index_to_pos (int $index, PangoRectangle $pos) {
    pango_layout_index_to_pos($!pl, $index, $pos);
  }

  method is_ellipsized {
    pango_layout_is_ellipsized($!pl);
  }

  method is_wrapped {
    pango_layout_is_wrapped($!pl);
  }

  method move_cursor_visually (gboolean $strong, int32 $old_index, int32 $old_trailing, int32 $direction, int32 $new_index, int32 $new_trailing) {
    pango_layout_move_cursor_visually($!pl, $strong, $old_index, $old_trailing, $direction, $new_index, $new_trailing);
  }

  method set_markup (Str() $markup, int32 $length) {
    pango_layout_set_markup($!pl, $markup, $length);
  }

  method set_markup_with_accel (Str() $markup, int32 $length, gunichar $accel_marker, gunichar $accel_char) {
    pango_layout_set_markup_with_accel($!pl, $markup, $length, $accel_marker, $accel_char);
  }

  method set_text (Str() $text, int32 $length) {
    pango_layout_set_text($!pl, $text, $length);
  }

  method xy_to_index (int32 $x, int32 $y, int32 $index_, int32 $trailing) {
    pango_layout_xy_to_index($!pl, $x, $y, $index_, $trailing);
  }
  # ↑↑↑↑ METHODS ↑↑↑↑

}
