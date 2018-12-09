use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;

unit package Pango::Raw::Tabs;

sub pango_tab_array_copy (PangoTabArray $src)
  returns PangoTabArray
  is native(pango)
  is export
  { * }

sub pango_tab_array_free (PangoTabArray $tab_array)
  is native(pango)
  is export
  { * }

sub pango_tab_array_get_positions_in_pixels (PangoTabArray $tab_array)
  returns uint32
  is native(pango)
  is export
  { * }

sub pango_tab_array_get_size (PangoTabArray $tab_array)
  returns gint
  is native(pango)
  is export
  { * }

sub pango_tab_array_get_tab (
  PangoTabArray $tab_array,
  gint $tab_index,
  PangoTabAlign $alignment is rw,
  gint $location is rw
)
  is native(pango)
  is export
  { * }

sub pango_tab_array_get_tabs (
  PangoTabArray $tab_array,
  PangoTabAlign $alignments,
  gint $locations
)
  is native(pango)
  is export
  { * }

sub pango_tab_array_get_type ()
  returns GType
  is native(pango)
  is export
  { * }

sub pango_tab_array_new (
  gint $initial_size,
  gboolean $positions_in_pixels
)
  returns PangoTabArray
  is native(pango)
  is export
  { * }

sub pango_tab_array_resize (PangoTabArray $tab_array, gint $new_size)
  is native(pango)
  is export
  { * }

sub pango_tab_array_set_tab (
  PangoTabArray $tab_array,
  gint $tab_index,
  PangoTabAlign $alignment,
  gint $location
)
  is native(pango)
  is export
  { * }
