use v6.c;

use NativeCall;

use Pango::Compat::Types;
use Pango::Roles::Pointers;

unit package Pango::Raw::Types;

constant PangoTabArray is export := CArray[gint];

our enum PangoAlignment is export <
  PANGO_ALIGN_LEFT
  PANGO_ALIGN_CENTER
  PANGO_ALIGN_RIGHT
>;

our enum PangoWrapMode is export <
  PANGO_WRAP_WORD
  PANGO_WRAP_CHAR
  PANGO_WRAP_WORD_CHAR
>;

our enum PangoEllipsizeMode is export <
  PANGO_ELLIPSIZE_NONE
  PANGO_ELLIPSIZE_START
  PANGO_ELLIPSIZE_MIDDLE
  PANGO_ELLIPSIZE_END
>;

our enum PangoStretch is export <
  PANGO_STRETCH_ULTRA_CONDENSED
  PANGO_STRETCH_EXTRA_CONDENSED
  PANGO_STRETCH_CONDENSED
  PANGO_STRETCH_SEMI_CONDENSED
  PANGO_STRETCH_NORMAL
  PANGO_STRETCH_SEMI_EXPANDED
  PANGO_STRETCH_EXPANDED
  PANGO_STRETCH_EXTRA_EXPANDED
  PANGO_STRETCH_ULTRA_EXPANDED
>;

our enum PangoStyle is export <
  PANGO_STYLE_NORMAL
  PANGO_STYLE_OBLIQUE
  PANGO_STYLE_ITALIC
>;

our enum PangoUnderline is export <
  PANGO_UNDERLINE_NONE
  PANGO_UNDERLINE_SINGLE
  PANGO_UNDERLINE_DOUBLE
  PANGO_UNDERLINE_LOW
  PANGO_UNDERLINE_ERROR
>;

our enum PangoVariant is export <
  PANGO_VARIANT_NORMAL
  PANGO_VARIANT_SMALL_CAPS
>;

our enum PangoDirection is export <
  PANGO_DIRECTION_LTR
  PANGO_DIRECTION_RTL
  PANGO_DIRECTION_TTB_LTR
  PANGO_DIRECTION_TTB_RTL
  PANGO_DIRECTION_WEAK_LTR
  PANGO_DIRECTION_WEAK_RTL
  PANGO_DIRECTION_NEUTRAL
>;

class PangoAttrList         is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoContext          is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoEngineShape      is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoEngineLang       is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFont             is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontDescription  is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontFace         is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontFamily       is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontMap          is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoLanguage         is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoLayout           is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoLayoutIter       is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoLayoutLine       is repr('CPointer') is export does Pango::Roles::Pointers { }

class PangoRectangle is repr('CStruct') is export does Pango::Roles::Pointers {
  has gint $.x     is rw;
  has gint $.y     is rw;
  has gint $.width is rw;
  has gint $.heigh is rw;
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

constant PangoGlyph     is export := uint32;
constant PangoGlyphUnit is export := uint32;

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

class PangoGlyphItem is repr('CStruct') is export does Pango::Roles::Pointers {
  has PangoItem        $.item;
  has PangoGlyphString $.glyphs;
}

constant PangoLayoutRun is export := PangoGlyphItem;
