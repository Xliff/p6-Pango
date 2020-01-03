use v6.c;

use CompUnit::Util :re-export;
use GLib::Raw::Types;

unit package Pango::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need Pango::Raw::Definitions;
need Pango::Raw::Enums;
need Pango::Raw::Structs;
need Pango::Raw::Subs;

our @pango-exports is export;
BEGIN {
  @pango-exports = <
    Pango::Raw::Definitions
    Pango::Raw::Enums
    Pango::Raw::Structs
    Pango::Raw::Subs
  >;

  re-export($_) for |@glib-exports, |@pango-exports;
}
