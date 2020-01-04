use v6.c;

unit package Pango::Raw::Exports;

our @pango-exports is export;

BEGIN {
  @pango-exports = <
    Pango::Raw::Definitions
    Pango::Raw::Enums
    Pango::Raw::Structs
    Pango::Raw::Subs
  >;
}
