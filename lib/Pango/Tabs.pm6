use v6.c;

use Method::Also;
use NativeCall;

use Pango::Raw::Tabs;
use Pango::Raw::Types;

class Pango::Tabs {
  has PangoTabArray $!pta;

  submethod BUILD (:$tabs) {
    $!pta = $tabs;
  }

  method Pango::Raw::Types::PangoTabArray
    is also<
      TabArray
      PangoTabArray
    >
  { $!pta }

  multi method new (PangoTabArray $tabs) {
    $tabs ?? self.bless(:$tabs) !! Nil;
  }
  multi method new (Int() $positions_in_pixels, @l) {
    die '<locations> must be a list of Integers' unless @l.all ~~ Int;
    my $o = samewith(@l.elems, $pip);
    $o.set_tabs(@l);
    $o;
  }
  multi method new (Int() $initial_size, Int() $positions_in_pixels) {
    my gint $is = $initial_size;
    my gboolean $pip = $positions_in_pixels.so.Int ;

    my $tabs = pango_tab_array_new($is, $pip);
    $tabs ?? self.bless(:$tabs) !! Nil;
  }

  method copy {
    my $tabs = pango_tab_array_copy($!pta);

    $tabs ?? self.bless(:$tabs) !! Nil;
  }

  method free {
    pango_tab_array_free($!pta);
  }

  method get_positions_in_pixels is also<get-positions-in-pixels> {
    so pango_tab_array_get_positions_in_pixels($!pta);
  }

  method get_size is also<get-size> {
    pango_tab_array_get_size($!pta);
  }

  proto method get_tab (|)
    is also<get-tab>
  { * }

  multi method get_tab ( Int() $tab_index ) {
    my ($a, $l);
    samewith($tab_index, $a, $l);
  }
  multi method get_tab (
    Int() $tab_index,
    Int() $alignment is rw,           # PangoTabAlign $alignment,
    Int() $location
  ) {
    my gint ($ti, $l) = ($tab_index, 0);
    my guint32 $a = 0;

    pango_tab_array_get_tab($!pta, $tab_index, $a, $l);
    ($alignment, $location) = ($a, $l);
  }

  proto method get_tabs
    is also<get-tabs>
    { * }

  multi method get_tabs {
    my (@a, @l);
    samewith(@a, @l);
    my @c = do for @a Z @l -> ($a, $l) {
      $a => $l;
    }
    @c;
  }
  multi method get_tabs (@alignments, @locations) {
    my $a = CArray[uint32].new;
    my $l = CArray[gint].new;
    my $size = self.get_size;

    pango_tab_array_get_tabs($!pta, $a, $l);

    # Reset array without reassignment.
    @alignments.splice(0, *) if +@alignments;
    @locations.splice(0, *)  if +@locations;

    # Populate arrays.
    @alignments.push($a[$_]) for ^$size;
    @locations.push($l[$_])  for ^$size;
  }

  method get_type is also<get-type> {
    pango_tab_array_get_type();
  }

  method resize (Int() $new_size) {
    my gint $ns = $new_size;

    pango_tab_array_resize($!pta, $ns);
  }

  proto method set_tab (|)
    is also<set-tab>
  { * }

  # Interface WOULD be the following:
  # method set_tab (
  #   Int() $tab_index,
  #   Int() $alignment,
  #   Int() $location
  # )
  #... but current implementation forces $alignment to always be
  # PANGO_TAB_LEFT, hence we have the following sub definitions:
  multi method set_tab (
    Int() $tab_index,
    Int() $location
  ) {
    my gint ($t, $l) = ($tab_index, $location);
    #my guint $a = $alignment;
    my guint $a = PANGO_TAB_LEFT.Int;

    pango_tab_array_set_tab($!pta, $t, $a, $l);
  }

  # multi method set_tabs (@al) {
  #   samewith( roundrobin( @al.map({ $_.key, $_.value }) ) );
  # }

  #multi
  multi method set_tabs (@l) {
    # die '<alignments> and <locations> must be the same size'
    #   unless +@a == +@l;
    # die '<alignment> must consist of Integer-compatible elements'
    #   unless @a.all ~~ Int;
    die '<locations> must consist of Integer elements'
      unless @l.all ~~ Int;

    my $ti = 0;
    #for @a Z @l -> $a, $l {
    for @l -> $l {
      # self.set_tab($ti++, $a, $l);
      self.set_tab($ti++, $l);
    }
  }

}
