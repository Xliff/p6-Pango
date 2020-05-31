/*
  List created from the output of:
    ( find . -name \*.h -exec grep -Hn 'typedef struct'} \; 1>&2 ) 2>&1 | \
       cut -d\  -f 4 | grep -v \{
*/

/* Strategy provided by p6-XML-LibXML:author<FROGGS> */
#ifdef _WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT extern
#endif

#include <pango/pango.h>
#include <pango/pangofc-decoder.h>
#include <pango/pango-renderer.h>
#include <pango/pangoxft-render.h>
#include <pango/pango-ot.h>
#include <pango/pango-modules.h>

#define s(name)     DLLEXPORT int sizeof_ ## name () { return sizeof(name); }

s(PangoAnalysis)
s(PangoAttrClass)
s(PangoAttrColor)
s(PangoAttrFloat)
s(PangoAttrFontDesc)
s(PangoAttrFontFeatures)
s(PangoAttribute)
s(PangoAttrInt)
s(PangoAttrLanguage)
s(PangoAttrShape)
s(PangoAttrSize)
s(PangoAttrString)
s(PangoColor)
s(PangoEngine)
s(PangoEngineClass)
s(PangoEngineInfo)
s(PangoEngineLang)
s(PangoEngineLangClass)
s(PangoEngineScriptInfo)
s(PangoEngineShape)
s(PangoEngineShapeClass)
s(PangoFcDecoder)
s(PangoFcDecoderClass)
s(PangoFcFont)
s(PangoFont)
s(PangoFontClass)
s(PangoFontFace)
s(PangoFontFaceClass)
s(PangoFontFamily)
s(PangoFontFamilyClass)
s(PangoFontMap)
s(PangoFontMapClass)
s(PangoFontMetrics)
s(PangoFontset)
s(PangoFontsetClass)
s(PangoGlyphGeometry)
s(PangoGlyphInfo)
s(PangoGlyphItem)
s(PangoGlyphItemIter)
s(PangoGlyphString)
s(PangoGlyphVisAttr)
s(PangoIncludedModule)
s(PangoItem)
s(PangoLayoutLine)
s(PangoLogAttr)
s(PangoMatrix)
s(PangoOTFeatureMap)
s(PangoOTGlyph)
s(PangoOTRulesetDescription)
s(PangoRectangle)
s(PangoRenderer)
s(PangoRendererClass)
s(PangoXftRenderer)
s(PangoXftRendererClass)
