use v6.c;

use NativeCall;

use Pango::Compat::Types;
use Pango::Roles::Pointers;

unit package Pango::Raw::Types;

constant PANGO_SCALE    is export = 1024;
constant PangoTabArray  is export := CArray[gint];
constant PangoAttrClass is export := Pointer;

constant PANGO_GLYPH_EMPTY is export         = 0x0FFFFFFF;
constant PANGO_GLYPH_INVALID_INPUT is export = 0xFFFFFFFF;
constant PANGO_GLYPH_UNKNOWN_FLAG is export  = 0x10000000;

constant PANGO_ATTR_INDEX_FROM_TEXT_BEGINNING = 0;
constant PANGO_ATTR_INDEX_TO_TEXT_END         = 4294967295;

class PangoMatrix    is repr('CStruct') is export { ... }
class PangoRectangle is repr('CStruct') is export { ... }

sub PANGO_MATRIX_INIT is export {
  PangoMatrix.new( :xx(1), :xy(0), :yx(0), :yy(1), :x0(0), :y0(0) );
}

sub       PANGO_PIXELS($d) { (($d.Int + 512)  +> 10) }
sub PANGO_PIXELS_FLOOR($d) { ($d.Int          +> 10) }
sub  PANGO_PIXELS_CEIL($d) { (($d.Int + 1023) +> 10) }

sub    PANGO_ASCENT(PangoRectangle $r) { -$r.y            }
sub   PANGO_DESCENT(PangoRectangle $r) { $r.y + $r.height }
sub  PANGO_LBEARING(PangoRectangle $r) { $r.x             }
sub  PANGO_RBEARING(PangoRectangle $r) { $r.x + $r.width  }

sub PANGO_GET_UNKNOWN_GLYPH(Int() $wc) { $wc +| PANGO_GLYPH_UNKNOWN_FLAG }

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

our enum PangoWeight is export (
  PANGO_WEIGHT_THIN       => 100,
  PANGO_WEIGHT_ULTRALIGHT => 200,
  PANGO_WEIGHT_LIGHT      => 300,
  PANGO_WEIGHT_SEMILIGHT  => 350,
  PANGO_WEIGHT_BOOK       => 380,
  PANGO_WEIGHT_NORMAL     => 400,
  PANGO_WEIGHT_MEDIUM     => 500,
  PANGO_WEIGHT_SEMIBOLD   => 600,
  PANGO_WEIGHT_BOLD       => 700,
  PANGO_WEIGHT_ULTRABOLD  => 800,
  PANGO_WEIGHT_HEAVY      => 900,
  PANGO_WEIGHT_ULTRAHEAVY => 1000
);

our enum PangoFontMask (
  PANGO_FONT_MASK_FAMILY     => 1,
  PANGO_FONT_MASK_STYLE      => 1 +< 1,
  PANGO_FONT_MASK_VARIANT    => 1 +< 2,
  PANGO_FONT_MASK_WEIGHT     => 1 +< 3,
  PANGO_FONT_MASK_STRETCH    => 1 +< 4,
  PANGO_FONT_MASK_SIZE       => 1 +< 5,
  PANGO_FONT_MASK_GRAVITY    => 1 +< 6,
  PANGO_FONT_MASK_VARIATIONS => 1 +< 7,
);

our enum PangoScale (
  PANGO_SCALE_XX_SMALL => 0.5787037037037,
  PANGO_SCALE_X_SMALL  => 0.6444444444444,
  PANGO_SCALE_SMALL    => 0.8333333333333,
  PANGO_SCALE_MEDIUM   => 1.0,
  PANGO_SCALE_LARGE    => 1.2,
  PANGO_SCALE_X_LARGE  => 1.4399999999999,
  PANGO_SCALE_XX_LARGE => 1.728,
);

our enum PangoGravity is export <
  PANGO_GRAVITY_SOUTH
  PANGO_GRAVITY_EAST
  PANGO_GRAVITY_NORTH
  PANGO_GRAVITY_WEST
  PANGO_GRAVITY_AUTO
>;

our enum PangoGravityHint is export <
  PANGO_GRAVITY_HINT_NATURAL
  PANGO_GRAVITY_HINT_STRONG
  PANGO_GRAVITY_HINT_LINE
>;

our enum PangoAttrType is export (
  'PANGO_ATTR_INVALID',              # 0 is an invalid attribute type */
  'PANGO_ATTR_LANGUAGE',             # PangoAttrLanguage */
  'PANGO_ATTR_FAMILY',               # PangoAttrString */
  'PANGO_ATTR_STYLE',                # PangoAttrInt */
  'PANGO_ATTR_WEIGHT',               # PangoAttrInt */
  'PANGO_ATTR_VARIANT',              # PangoAttrInt */
  'PANGO_ATTR_STRETCH',              # PangoAttrInt */
  'PANGO_ATTR_SIZE',                 # PangoAttrSize */
  'PANGO_ATTR_FONT_DESC',            # PangoAttrFontDesc */
  'PANGO_ATTR_FOREGROUND',           # PangoAttrColor */
  'PANGO_ATTR_BACKGROUND',           # PangoAttrColor */
  'PANGO_ATTR_UNDERLINE',            # PangoAttrInt */
  'PANGO_ATTR_STRIKETHROUGH',        # PangoAttrInt */
  'PANGO_ATTR_RISE',                 # PangoAttrInt */
  'PANGO_ATTR_SHAPE',                # PangoAttrShape */
  'PANGO_ATTR_SCALE',                # PangoAttrFloat */
  'PANGO_ATTR_FALLBACK',             # PangoAttrInt */
  'PANGO_ATTR_LETTER_SPACING',       # PangoAttrInt */
  'PANGO_ATTR_UNDERLINE_COLOR',      # PangoAttrColor */
  'PANGO_ATTR_STRIKETHROUGH_COLOR',  # PangoAttrColor */
  'PANGO_ATTR_ABSOLUTE_SIZE',        # PangoAttrSize */
  'PANGO_ATTR_GRAVITY',              # PangoAttrInt */
  'PANGO_ATTR_GRAVITY_HINT',         # PangoAttrInt */
  'PANGO_ATTR_FONT_FEATURES',        # PangoAttrString */
  'PANGO_ATTR_FOREGROUND_ALPHA',     # PangoAttrInt */
  'PANGO_ATTR_BACKGROUND_ALPHA'      # PangoAttrInt */
);

our enum PangoCoverageLevel is export <
  PANGO_COVERAGE_NONE
  PANGO_COVERAGE_FALLBACK
  PANGO_COVERAGE_APPROXIMATE
  PANGO_COVERAGE_EXACT
>;

sub PANGO_GRAVITY_IS_VERTICAL(PangoGravity $g) {
  $g == (PANGO_GRAVITY_EAST, PANGO_GRAVITY_WEST).any
}
sub PANGO_GRAVITY_IS_IMPROPER(PangoGravity $g) {
  $g == (PANGO_GRAVITY_NORTH, PANGO_GRAVITY_WEST).any
}

class PangoAttrList         is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoAttrIterator     is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoCairoFont        is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoCairoFontMap     is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoContext          is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoCoverage         is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoEngineShape      is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoEngineLang       is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFcDecoder        is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFcFontKey        is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFcFontMap        is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFcFontsetKey     is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFT2FontMap       is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFont             is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontset          is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontsetSimple    is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontDescription  is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontFace         is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontFamily       is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontMap          is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoFontMetrics      is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoLanguage         is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoLayout           is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoLayoutIter       is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoLayoutLine       is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoXFTFont          is repr('CPointer') is export does Pango::Roles::Pointers { }
class PangoXFTRenderer      is repr('CPointer') is export does Pango::Roles::Pointers { }

class PangoRectangle does Pango::Roles::Pointers {
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
  method attr { nativecast(PangoAttribute, self) }
  method Pango::Raw::Types::PangoAttribute { self.attt }
}

class PangoAttribute
  does Pango::Roles::Pointers
  does PangoAttributeRole
{
  has Pointer $.klass;
  has guint   $.start_index;
  has guint   $.end_index;
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
  HAS PangoRectangle $.ink_rect;
  HAS PangoRectangle $.logical_rect;

  has Pointer        $.data;
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
