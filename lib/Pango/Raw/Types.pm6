use v6.c;

use CompUnit::Util :re-export;

use GLib::Raw::Exports;
use Pango::Raw::Exports;

unit package Pango::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Structs;
need GLib::Raw::Struct_Subs;
need GLib::Raw::Subs;
need Pango::Raw::Definitions;
need Pango::Raw::Enums;
need Pango::Raw::Structs;
need Pango::Raw::Subs;

BEGIN {
  re-export($_) for |@glib-exports, |@pango-exports;
}
