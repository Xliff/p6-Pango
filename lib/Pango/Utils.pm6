use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Attr;
use Pango::Raw::Types;
use Pango::Raw::Utils;

unit package Pango::Utils;

sub pango_markup_parser_finish (
  PangoAttrList $attr_list,
  Str() $text,
  Int() $accel_char,
  CArray[Pointer[GError]] $error = gerror
) {
  my guint $ac = resolve-uint($accel_char);
  my $rc = pango_markup_parser_finish($!pa, $attr_list, $text, $ac, $error);
  $ERROR = $error[0].deref with $error[0];
  $rc;
}

sub pango_markup_parser_new {
  pango_markup_parser_new();
}

sub pango_parse_markup (
  Str() $markup_text;
  Int() $length,
  Int() $accel_marker,
  PangoAttrList $attr_list is rw,
  Str $text is rw,
  Int() $accel_char is rw,
  CArray[Pointer[GError]] $error = gerror
) {
  my gint $l = resolve-int($length);
  my @u = ($accel_marker, $accel_char);
  my guint ($am, $ac) = resolve-uint(@u);
  my $to = CArray[Str].new;
  my $rc = pango_parse_markup(
    $markup_text,
    $length,
    $am,
    $attr_list,
    $to,
    $ac,
    $error
  );
  ($accel_char, $text) = ($ac, $to[0]);
  $ERROR = $error[0].deref with $error[0];
  $rc;
}
