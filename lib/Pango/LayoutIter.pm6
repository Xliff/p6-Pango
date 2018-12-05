use v6.c;

use NativeCall;

use Pango::Raw::Types;
use Pango::Raw::Layout;

class Pango::LayoutIter {
  has PangoLayoutIter $!pli;

  method at_last_line {
    pango_layout_iter_at_last_line($!pli);
  }

  method copy {
    pango_layout_iter_copy($!pli);
  }

  method free {
    pango_layout_iter_free($!pli);
  }

  method get_baseline {
    pango_layout_iter_get_baseline($!pli);
  }

  method get_char_extents (PangoRectangle $logical_rect) {
    pango_layout_iter_get_char_extents($!pli, $logical_rect);
  }

  method get_cluster_extents (
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect
  ) {
    pango_layout_iter_get_cluster_extents($!pli, $ink_rect, $logical_rect);
  }

  method get_index {
    pango_layout_iter_get_index($!pli);
  }

  method get_layout {
    pango_layout_iter_get_layout($!pli);
  }

  method get_layout_extents (
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect
  ) {
    pango_layout_iter_get_layout_extents($!pli, $ink_rect, $logical_rect);
  }

  method get_line {
    pango_layout_iter_get_line($!pli);
  }

  method get_line_extents (
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect
  ) {
    pango_layout_iter_get_line_extents($!pli, $ink_rect, $logical_rect);
  }

  method get_line_readonly {
    pango_layout_iter_get_line_readonly($!pli);
  }

  method get_line_yrange (int $y0_, int $y1_) {
    pango_layout_iter_get_line_yrange($!pli, $y0_, $y1_);
  }

  method get_run {
    pango_layout_iter_get_run($!pli);
  }

  method get_run_extents (
    PangoRectangle $ink_rect,
    PangoRectangle $logical_rect
  ) {
    pango_layout_iter_get_run_extents($!pli, $ink_rect, $logical_rect);
  }

  method get_run_readonly {
    pango_layout_iter_get_run_readonly($!pli);
  }

  method get_type {
    pango_layout_iter_get_type();
  }

  method next_char {
    pango_layout_iter_next_char($!pli);
  }

  method next_cluster {
    pango_layout_iter_next_cluster($!pli);
  }

  method next_line {
    pango_layout_iter_next_line($!pli);
  }

  method next_run {
    pango_layout_iter_next_run($!pli);
  }
}
