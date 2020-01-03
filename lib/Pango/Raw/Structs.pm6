use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Pango::Raw::Definitions;
use Pango::Raw::Enums;

unit package Pango::Raw::Structs;

class PangoRectangle does Pango::Roles::Pointers {
  has gint $.x      is rw;
  has gint $.y      is rw;
  has gint $.width  is rw;
  has gint $.height is rw;

  submethod BUILD (:$!x, :$!y, :$!width, :$!height) { }

  method new($x = 0, $y = 0, $width = 0, $height = 0) {
    self.bless(:$x, :$y, :$width, :$height);
  }
}

class PangoLogAttr is repr('CStruct') is export does Pango::Roles::Pointers {
  has guint $.is_line_break               is rw; # :1
  has guint $.is_mandatory_break          is rw; # :1
  has guint $.is_char_break               is rw; # :1
  has guint $.is_white                    is rw; # :1
  has guint $.is_cursor_position          is rw; # :1
  has guint $.is_word_start               is rw; # :1
  has guint $.is_word_end                 is rw; # :1
  has guint $.is_sentence_boundary        is rw; # :1
  has guint $.is_sentence_start           is rw; # :1
  has guint $.is_sentence_end             is rw; # :1
  has guint $.backspace_deletes_character is rw; # :1
  has guint $.is_expandable_space         is rw; # :1
  has guint $.is_word_boundary            is rw; # :1
}

class PangoAnalysis is repr('CStruct')
  is export
  does Pango::Roles::Pointers
{
  has PangoEngineShape $.shape_engine;
  has PangoEngineLang  $.lang_engine;
  has PangoFont        $.font;
  has guint8           $.level;
  has guint8           $.gravity;
  has guint8           $.flags;
  has guint8           $.script;
  has PangoLanguage    $.language;
  has GSList           $.extra_attrs;
}

class PangoItem is repr('CStruct')
  is export
  does Pango::Roles::Pointers
{
  has gint          $.offset;
  has gint          $.length;
  has gint          $.num_chars;
  HAS PangoAnalysis $.analysis;
}

class PangoGlyphVisAttr is repr('CStruct')
  is export
  does Pango::Roles::Pointers
{
  has guint $.is_cluster_start; # :1
}

class PangoGlyphGeometry is repr('CStruct')
  is export
  does Pango::Roles::Pointers
{
  has PangoGlyphUnit $.width;
  has PangoGlyphUnit $.x_offset;
  has PangoGlyphUnit $.y_offset;
}

class PangoGlyphInfo is repr('CStruct')
  is export
  does Pango::Roles::Pointers
{
   has PangoGlyph         $.glyph;
   HAS PangoGlyphGeometry $.geometry;
   HAS PangoGlyphVisAttr  $.attr;
}

class PangoGlyphString is repr('CStruct')
  is export
  does Pango::Roles::Pointers
{
  has gint           $.num_glyphs;
  has PangoGlyphInfo $.glyphs;
  has gint           $.log_clusters;
}

class PangoGlyphItem is repr('CStruct')
  is export
  does Pango::Roles::Pointers
{
  has PangoItem        $.item;
  has PangoGlyphString $.glyphs;
}

constant PangoLayoutRun is export := PangoGlyphItem;

class PangoMatrix does Pango::Roles::Pointers {
  has gdouble $.xx is rw;
  has gdouble $.xy is rw;
  has gdouble $.yx is rw;
  has gdouble $.yy is rw;
  has gdouble $.x0 is rw;
  has gdouble $.y0 is rw;
}

class PangoGlyphItemIter is repr('CStruct')
  is export
  does Pango::Roles::Pointers
{
  has PangoGlyphItem $.glyph_item;
  has Str            $.text;

  has gint           $.start_glyph;
  has gint           $.start_index;
  has gint           $.start_char;

  has gint           $.end_glyph;
  has gint           $.end_index;
  has gint           $.end_char;
}

class PangoColor is repr('CStruct')
  is export
  does Pango::Roles::Pointers
{
  has guint16 $.red   is rw;
  has guint16 $.green is rw;
  has guint16 $.blue  is rw;
}

class PangoAttribute is repr('CStruct') is export { ... }

role PangoAttributeRole {
  method attr {
    nativecast(PangoAttribute, self)
  }

  method Pango::Raw::Types::PangoAttribute {
    self ~~ PangoAttribute ?? self !! self.attr
  }
}

class PangoAttribute
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  has Pointer $.klass;
  has guint   $.start_index is rw;
  has guint   $.end_index   is rw;
}

class PangoAttrString is repr('CStruct')
  is export
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  HAS PangoAttribute $.attr;
  has Str            $.value;
}

class PangoAttrLanguage is repr('CStruct')
  is export
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  HAS PangoAttribute $.attr;
  has PangoLanguage  $.value;
}

class PangoAttrColor is repr('CStruct')
  is export
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  HAS PangoAttribute $.attr;
  has PangoColor     $.value;
}

class PangoAttrInt is repr('CStruct')
  is export
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  HAS PangoAttribute $.attr;
  has gint           $.value;
}

class PangoAttrFloat is repr('CStruct')
  is export
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  HAS PangoAttribute $.attr;
  has gdouble        $.value;
}

class PangoAttrFontDesc is repr('CStruct')
  is export
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  HAS PangoAttribute       $.attr;
  has PangoFontDescription $.value;
}

class PangoAttrShape is repr('CStruct')
  is export
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  HAS PangoAttribute $.attr;
  HAS PangoRectangle $.ink_rect    ;
  HAS PangoRectangle $.logical_rect;

  has Pointer        $!data;
  #has               $copy_func (Pointer);
  #has               $destroy_func (Pointer);
  has Pointer        $.copy_func;
  has Pointer        $.destroy_func;

  # HACK! --
  # See: https://stackoverflow.com/questions/48772284/putting-function-pointers-in-a-perl6-nativecall-cstruct
  method !set-func (&func) {
    my $buf = buf8.allocate(20);
    my $len = set-function-ptr-p($buf, '%lld', &func);
    Pointer.new($buf.subbuf(^$len).decode.Int);
  }

  method data is rw {
    Proxy.new:
      FETCH => -> $       { $!data },
      STORE => -> $, \val { self.^attributes[3].set_value( self, nativecast(Pointer, val) ) };
  }

  method set-copy-func(&func)    {    $!copy_func := self!set-func(&func) }
  method set_destroy-func(&func) { $!destroy_func := self!set-func(&func) }
}

class PangoAttrSize is repr('CStruct')
  is export
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  HAS PangoAttribute $.attr;
  has gint           $.size;
  has guint          $.absolute; # :1
}

class PangoAttrFontFeatures is repr('CStruct')
  is export
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  HAS PangoAttribute $.attr;
  has Str            $.features;
}

subset PangoAttributes is export where
  PangoAttribute        | PangoAttrString | PangoAttrLanguage |
  PangoAttrColor        | PangoAttrInt    | PangoAttrFloat    |
  PangoAttrFontDesc     | PangoAttrShape  | PangoAttrSize     |
  PangoAttrFontFeatures;
