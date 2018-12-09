use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Tabs;
use Pango::Raw::Types;

use Pango::Roles::Types;

class Pango::Tabs {
  also does Pango::Roles::Types;

  has PangoTabArray $!pta;

  submethod BUILD (:$tabs) {
    $!pta = $tabs;
  }

  method new (Int() $positions_in_pixels) {
    my gint $pip = self.RESOLVE-INT($positions_in_pixels);
    my $tabs = pango_tab_array_new($!pta, $pip)
    self.bless(:$tabs);
  }

  method copy {
    my $tabs = pango_tab_array_copy($!pta);
    self.bless(:$tabs);
  }

  method free {
    pango_tab_array_free($!pta);
  }

  method get_positions_in_pixels {
    pango_tab_array_get_positions_in_pixels($!pta);
  }

  method get_size {
    pango_tab_array_get_size($!pta);
  }

  multi method get_tab ( Int() $tab_index ) {
    my ($a, $l);
    samewith($tab_index, $a, $l);
  }
  multi method get_tab (
    gint $tab_index,
    uint32 $alignment is rw,           # PangoTabAlign $alignment,
    gint $location
  ) {
    my gint ($ti, $l) = ( self.RESOLVE-INT($tab_index), 0 );
    my guint32 $a = 0;
    pango_tab_array_get_tab($!pta, $tab_index, $a, $l);
    ($alignment, $location) = ($a, $l);
  }

  multi method get_tabs {
    my (@a, @l);
    samewith(@a, @l);
    my @c = do for @a Z @l -> ($a, $l) {
      $a => $l;
    }
    @c;
  }
  method get_tabs (@alignments, @locations) {
    my $a = CArray[uint32].new;
    my $l = CArray[gint].new;
    pango_tab_array_get_tabs($!pta, $a, $l);
    my $size = self.get_size;
    @alignments.push($a[$_]) for ^$size;
    @locations.push($l[$_])  for ^$size;
  }

  method get_type {
    pango_tab_array_get_type();
  }

  method resize (Int() $new_size) {
    my gint $ns = self.RESOLVE-INT($new_size);
    pango_tab_array_resize($!pta, $ns);
  }

  method set_tab (
    Int() $tab_index,
    Int() $alignment,
    Int() $location
  ) {
    my @i = ($tab_index, $location);
    my gint ($t, $l) = self.RESOLVE-INT(@i);
    my guint $a = self.RESOLVE-UINT($alignment);
    pango_tab_array_set_tab($!pta, $t, $a, $l);
  }

}
