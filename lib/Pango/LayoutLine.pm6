use v6.c;

use NativeCall;

use Pango::Raw::Layout;
use Pango::Raw::Types;

class Pango::LayoutLine {
  has PangoLayoutLine $!pll;

  method get_extents (
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect
  ) {
    pango_layout_line_get_extents($!pl, $ink_rect, $logical_rect);
  }

  method get_pixel_extents (
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect
  ) {
    pango_layout_line_get_pixel_extents($!pl, $ink_rect, $logical_rect);
  }

  method get_x_ranges (
    int $start_index,
    int $end_index,
    int $ranges,
    int $n_ranges
  ) {
    pango_layout_line_get_x_ranges(
      $!pl, $start_index, $end_index, $ranges, $n_ranges
    );
  }

  method index_to_x (int $index_, gboolean $trailing, int $x_pos) {
    pango_layout_line_index_to_x($!pl, $index_, $trailing, $x_pos);
  }

  method upref {
    pango_layout_line_ref($!pl);
  }

  method downref {
    pango_layout_line_unref($!pl);
  }

  method x_to_index (int $x_pos, int $index_, int $trailing) {
    pango_layout_line_x_to_index($!pl, $x_pos, $index_, $trailing);
  }
}
