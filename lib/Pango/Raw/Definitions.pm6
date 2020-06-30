use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GLib::Roles::Pointers;

unit package Pango::Raw::Definitions;

# Number of times I've had to force compile the whole project.
my constant forced = 27;

constant cairo      is export = 'cairo',v2;
constant pango      is export = 'pango-1.0',v0;
constant pangocairo is export = 'pangocairo-1.0',v0;
constant pangoft2   is export = 'pangoft2-1.0',v0;

constant Display             is export := Pointer;
constant FT_Face             is export := Pointer;
constant Picture             is export := Pointer;
constant XftColor            is export := Pointer;
constant XftDraw             is export := Pointer;
constant XftFont             is export := Pointer;

constant cairo_t             is export := Cairo::cairo_t;
constant cairo_pattern_t     is export := Cairo::cairo_pattern_t;
constant cairo_region_t      is export := Pointer;
constant cairo_scaled_font_t is export := Pointer;
constant cairo_font_type_t   is export := Pointer;

constant FcConfig            is export := Pointer;
constant FcPattern           is export := Pointer;

constant PangoTabArray       is export := CArray[gint];
constant PangoAttrClass      is export := Pointer;
constant PangoGlyph          is export := uint32;
constant PangoGlyphUnit      is export := uint32;

constant PANGO_SCALE                            is export  = 1024;
constant PANGO_GLYPH_EMPTY                      is export  = 0x0FFFFFFF;
constant PANGO_GLYPH_INVALID_INPUT              is export  = 0xFFFFFFFF;
constant PANGO_GLYPH_UNKNOWN_FLAG               is export  = 0x10000000;
constant PANGO_ATTR_INDEX_FROM_TEXT_BEGINNING   is export  = 0;
constant PANGO_ATTR_INDEX_TO_TEXT_END           is export  = 4294967295;

class cairo_font_options_t  is repr<CPointer> is export does GLib::Roles::Pointers { }

class PangoAttrIter         is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoAttrIterator     is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoAttrList         is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoCairo            is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoCairoFont        is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoCairoFontMap     is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoContext          is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoCoverage         is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoEngineLang       is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoEngineShape      is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFcDecoder        is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFcFont           is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFCFont           is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFcFontKey        is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFcFontMap        is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFcFontsetKey     is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFont             is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFontDescription  is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFontFace         is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFontFamily       is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFontMap          is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFontMetrics      is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFontset          is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFontsetSimple    is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFT               is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoFT2FontMap       is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoLanguage         is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoLayout           is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoLayoutIter       is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoLayoutLine       is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoMarkupParser     is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoRenderer         is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoRenderPart       is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoXFTFont          is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoXFTRender        is repr<CPointer> is export does GLib::Roles::Pointers { }
class PangoXFTRenderer      is repr<CPointer> is export does GLib::Roles::Pointers { }