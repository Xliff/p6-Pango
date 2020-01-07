use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Struct_Subs;
use Pango::Raw::Definitions;
use Pango::Raw::Enums;

use GLib::Roles::Pointers;

unit package Pango::Raw::Structs;

class PangoRectangle        is repr<CStruct> is export does GLib::Roles::Pointers {
  has gint $.x      is rw;
  has gint $.y      is rw;
  has gint $.width  is rw;
  has gint $.height is rw;

  submethod BUILD (:$!x, :$!y, :$!width, :$!height) { }

  method new($x = 0, $y = 0, $width = 0, $height = 0) {
    self.bless(:$x, :$y, :$width, :$height);
  }
}

class PangoLogAttr          is repr<CStruct> is export does GLib::Roles::Pointers {
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

class PangoAnalysis         is repr<CStruct> is export does GLib::Roles::Pointers {
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

class PangoItem             is repr<CStruct> is export does GLib::Roles::Pointers {
  has gint          $.offset;
  has gint          $.length;
  has gint          $.num_chars;
  HAS PangoAnalysis $.analysis;
}

class PangoGlyphVisAttr     is repr<CStruct> is export does GLib::Roles::Pointers {
  has guint $.is_cluster_start; # :1
}

class PangoGlyphGeometry    is repr<CStruct> is export does GLib::Roles::Pointers {
  has PangoGlyphUnit $.width;
  has PangoGlyphUnit $.x_offset;
  has PangoGlyphUnit $.y_offset;
}

class PangoGlyphInfo        is repr<CStruct> is export does GLib::Roles::Pointers {
   has PangoGlyph         $.glyph;
   HAS PangoGlyphGeometry $.geometry;
   HAS PangoGlyphVisAttr  $.attr;
}

class PangoGlyphString      is repr<CStruct> is export does GLib::Roles::Pointers {
  has gint           $.num_glyphs;
  has PangoGlyphInfo $.glyphs;
  has gint           $.log_clusters;
}

class PangoGlyphItem        is repr<CStruct> is export does GLib::Roles::Pointers {
  has PangoItem        $.item;
  has PangoGlyphString $.glyphs;
}

constant PangoLayoutRun     is export := PangoGlyphItem;

class PangoMatrix           is repr<CStruct> is export does GLib::Roles::Pointers {
  has gdouble $.xx is rw;
  has gdouble $.xy is rw;
  has gdouble $.yx is rw;
  has gdouble $.yy is rw;
  has gdouble $.x0 is rw;
  has gdouble $.y0 is rw;
}

class PangoGlyphItemIter    is repr<CStruct> is export does GLib::Roles::Pointers {
  has PangoGlyphItem $.glyph_item;
  has Str            $.text;

  has gint           $.start_glyph;
  has gint           $.start_index;
  has gint           $.start_char;

  has gint           $.end_glyph;
  has gint           $.end_index;
  has gint           $.end_char;
}

class PangoColor            is repr<CStruct> is export does GLib::Roles::Pointers {
  has guint16 $.red   is rw;
  has guint16 $.green is rw;
  has guint16 $.blue  is rw;
}

class PangoAttribute        is repr<CStruct> is export does GLib::Roles::Pointers
{ ... }

role PangoAttributeRole {

  method Pango::Raw::Structs::PangoAttribute
    is also<
      PangoAttribute
      attr
    >
  {
    nativecast(PangoAttribute, self);
  }

  # We have to do some really weird end-arounds to avoid circular references!
  method start_index is also<start-index> is rw {
    self ~~ PangoAttribute ??
      self._start_index !! self.attr.start_index;
  }

  method end_index is also<end-index> is rw {
    self ~~ PangoAttribute ??
      self._end_index !! self.attr.end_index;
  }

}

# All remaining classes do PangoAttributeRole.
class PangoAttribute does PangoAttributeRole {
  has Pointer $.klass;
  has guint   $!start_index;
  has guint   $!end_index  ;

  method _start_index is rw {
    $!start_index;
  }

  method _end_index is rw {
    $!end_index;
  }
}

class PangoAttrString       is repr<CStruct> is export does GLib::Roles::Pointers does PangoAttributeRole {
  HAS PangoAttribute $.attr;
  has Str            $.value;
}

class PangoAttrLanguage     is repr<CStruct> is export does GLib::Roles::Pointers does PangoAttributeRole {
  HAS PangoAttribute $.attr;
  has PangoLanguage  $.value;
}

class PangoAttrColor        is repr<CStruct> is export does GLib::Roles::Pointers does PangoAttributeRole {
  HAS PangoAttribute $.attr;
  has PangoColor     $.value;
}

class PangoAttrInt          is repr<CStruct> is export does GLib::Roles::Pointers does PangoAttributeRole {
  HAS PangoAttribute $.attr;
  has gint           $.value;
}

class PangoAttrFloat        is repr<CStruct> is export does GLib::Roles::Pointers does PangoAttributeRole {
  HAS PangoAttribute $.attr;
  has gdouble        $.value;
}

class PangoAttrFontDesc     is repr<CStruct> is export does GLib::Roles::Pointers does PangoAttributeRole {
  HAS PangoAttribute       $.attr;
  has PangoFontDescription $.value;
}

class PangoAttrShape        is repr<CStruct> is export does GLib::Roles::Pointers does PangoAttributeRole {
  HAS PangoAttribute $.attr;
  HAS PangoRectangle $.ink_rect    ;
  HAS PangoRectangle $.logical_rect;

  has Pointer        $!data;
  has Pointer        $!copy_func;
  has Pointer        $!destroy_func;

  method data is rw {
    Proxy.new:
      FETCH => -> $       { $!data },
      STORE => -> $, \val { self.^attributes[3].set_value( self, nativecast(Pointer, val) ) };
  }

  method copy_func is rw {
    Proxy.new:
      FETCH => -> $       { $!copy_func },
      STORE => -> $, \val { self.^attributes[4].set_value( self, set_func_pointer(val, &sprintf-P-P) ) };
  }

  method destroy_func {
    Proxy.new:
      FETCH => -> $       { $!destroy_func },
      STORE => -> $, \val { self.^attributes[5].set_value( self, set_func_pointer(val, &sprintf-P) ) };
  }
}

class PangoAttrSize         is repr<CStruct> is export does GLib::Roles::Pointers does PangoAttributeRole {
  HAS PangoAttribute $.attr;
  has gint           $.size;
  has guint          $.absolute; # :1
}

class PangoAttrFontFeatures is repr<CStruct> is export does GLib::Roles::Pointers does PangoAttributeRole {
  HAS PangoAttribute $.attr;
  has Str            $.features;
}

subset PangoAttributes      is export where
  PangoAttribute        | PangoAttrString | PangoAttrLanguage |
  PangoAttrColor        | PangoAttrInt    | PangoAttrFloat    |
  PangoAttrFontDesc     | PangoAttrShape  | PangoAttrSize     |
  PangoAttrFontFeatures;
