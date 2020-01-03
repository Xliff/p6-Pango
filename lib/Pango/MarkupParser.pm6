use v6.c;

use NativeCall;

use Pango::Raw::Attr;
use Pango::Raw::Types;

class Pango::MarkupParser {
  # has PangoMarkupParser $!pmp;

  # Object method requires more GLib integration than is necessary since
  # we have the static parse method, below.
  #
  # If there is a need, then object method can be implemented at a later time.

  # submethod BUILD (:$parser) {
  #   $!pmp = $parser;
  # }

  # method new {
  #   self.bless( parser => pango_markup_parser_new() );
  # }
  #
  # method finish (
  #   CArray[Pointer[PangoAttrList]] $attr_list,
  #   Str() $text,
  #   Int() $accel_char,
  #   CArray[Pointer[GError]] $error = gerror
  # ) {
  #   my guint $ac = $accel_char;
  #   my $rc = pango_markup_parser_finish($!pmp, $attr_list, $text, $ac, $error);
  #   $ERROR = $error[0].deref with $error[0];
  #   $rc;
  # }

  method parse (
    Pango::MarkupParser:U:
    Str() $markup_text;
    Int() $length,
    Int() $accel_marker,
    CArray[Pointer[PangoAttrList]] $attr_list,
    Str $text is rw,
    Int() $accel_char is rw,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gint $l = $length;
    my guint ($am, $ac) = ($accel_marker, $accel_char);
    my $to = CArray[Str].new;

    clear_error;
    my $rc = pango_parse_markup(
      $markup_text,
      $length,
      $am,
      $attr_list,
      $to,
      $ac,
      $error
    );
    set_error($error);
    ($accel_char, $text) = ($ac, $to[0]);
    $rc;
  }

}
