use v6.c;

use GLib::Raw::Exports;
use Pango::Raw::Exports;

unit package Pango::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need GLib::Raw::Struct_Subs;
need GLib::Roles::Pointers;
need Pango::Raw::Definitions;
need Pango::Raw::Enums;
need Pango::Raw::Structs;
need Pango::Raw::Subs;

BEGIN {
  glib-re-export($_) for |@glib-exports, |@pango-exports;
}
