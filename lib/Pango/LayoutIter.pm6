use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Types;
use Pango::Raw::Layout;

class Pango::LayoutIter {
  has PangoLayoutIter $!pli is implementor;

  method Pango::Raw::Definitions::PangoLayoutIter
    is also<PangoLayoutIter>
  { $!pli }

  method at_last_line is also<at-last-line> {
    pango_layout_iter_at_last_line($!pli);
  }

  method copy {
    pango_layout_iter_copy($!pli);
  }

  method free {
    pango_layout_iter_free($!pli);
  }

  method get_baseline is also<get-baseline> {
    pango_layout_iter_get_baseline($!pli);
  }

  method get_char_extents (PangoRectangle $logical_rect)
    is also<get-char-extents>
  {
    pango_layout_iter_get_char_extents($!pli, $logical_rect);
  }

  method get_cluster_extents (
    PangoRectangle() $ink_rect,
    PangoRectangle() $logical_rect
  )
    is also<get-cluster-extents>
  {
    pango_layout_iter_get_cluster_extents($!pli, $ink_rect, $logical_rect);
  }

  method get_index is also<get-index> {
    pango_layout_iter_get_index($!pli);
  }

  method get_layout is also<get-layout> {
    pango_layout_iter_get_layout($!pli);
  }

  method get_layout_extents (
    PangoRectangle() $ink_rect,
    PangoRectangle() $logical_rect
  )
    is also<get-layout-extents>
  {
    pango_layout_iter_get_layout_extents($!pli, $ink_rect, $logical_rect);
  }

  method get_line is also<get-line> {
    pango_layout_iter_get_line($!pli);
  }

  method get_line_extents (
    PangoRectangle() $ink_rect,
    PangoRectangle() $logical_rect
  )
    is also<get-line-extents>
  {
    pango_layout_iter_get_line_extents($!pli, $ink_rect, $logical_rect);
  }

  method get_line_readonly is also<get-line-readonly> {
    pango_layout_iter_get_line_readonly($!pli);
  }

  method get_line_yrange (Int() $y0, Int() $y1) is also<get-line-yrange> {
    my gint ($yy0, $yy1) = ($y0, $y1);

    pango_layout_iter_get_line_yrange($!pli, $yy0, $yy1);
  }

  method get_run is also<get-run> {
    pango_layout_iter_get_run($!pli);
  }

  method get_run_extents (
    PangoRectangle() $ink_rect,
    PangoRectangle() $logical_rect
  )
    is also<get-run-extents>
  {
    pango_layout_iter_get_run_extents($!pli, $ink_rect, $logical_rect);
  }

  method get_run_readonly is also<get-run-readonly> {
    pango_layout_iter_get_run_readonly($!pli);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &pango_layout_iter_get_type, $n, $t );
  }

  method next_char is also<next-char> {
    pango_layout_iter_next_char($!pli);
  }

  method next_cluster is also<next-cluster> {
    pango_layout_iter_next_cluster($!pli);
  }

  method next_line is also<next-line> {
    pango_layout_iter_next_line($!pli);
  }

  method next_run is also<next-run> {
    pango_layout_iter_next_run($!pli);
  }
}
