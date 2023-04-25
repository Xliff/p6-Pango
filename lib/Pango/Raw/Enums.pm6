use v6.c;

use GLib::Raw::Definitions;
use Pango::Raw::Definitions;

unit package Pango::Raw::Enums;

constant PangoAlignment is export := guint32;
our enum PangoAlignmentEnum is export <
  PANGO_ALIGN_LEFT
  PANGO_ALIGN_CENTER
  PANGO_ALIGN_RIGHT
>;

constant PangoWrapMode is export := guint32;
our enum PangoWrapModeEnum is export <
  PANGO_WRAP_WORD
  PANGO_WRAP_CHAR
  PANGO_WRAP_WORD_CHAR
>;

constant PangoEllipsizeMode is export := guint32;
our enum PangoEllipsizeModeEnum is export <
  PANGO_ELLIPSIZE_NONE
  PANGO_ELLIPSIZE_START
  PANGO_ELLIPSIZE_MIDDLE
  PANGO_ELLIPSIZE_END
>;

constant PangoStretch is export := guint32;
our enum PangoStretchEnum is export <
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

constant PangoStyle is export := guint32;
our enum PangoStyleEnum is export <
  PANGO_STYLE_NORMAL
  PANGO_STYLE_OBLIQUE
  PANGO_STYLE_ITALIC
>;

constant PangoUnderline is export := guint32;
our enum PangoUnderlineEnum is export <
  PANGO_UNDERLINE_NONE
  PANGO_UNDERLINE_SINGLE
  PANGO_UNDERLINE_DOUBLE
  PANGO_UNDERLINE_LOW
  PANGO_UNDERLINE_ERROR
>;

constant PangoVariant is export := guint32;
our enum PangoVariantEnum is export <
  PANGO_VARIANT_NORMAL
  PANGO_VARIANT_SMALL_CAPS
>;

constant PangoDirection is export := guint32;
our enum PangoDirectionEnum is export <
  PANGO_DIRECTION_LTR
  PANGO_DIRECTION_RTL
  PANGO_DIRECTION_TTB_LTR
  PANGO_DIRECTION_TTB_RTL
  PANGO_DIRECTION_WEAK_LTR
  PANGO_DIRECTION_WEAK_RTL
  PANGO_DIRECTION_NEUTRAL
>;

constant PangoWeight is export := guint32;
our enum PangoWeightEnum is export (
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

constant PangoFontMask is export := guint32;
our enum PangoFontMaskEnum is export (
  PANGO_FONT_MASK_FAMILY     => 1,
  PANGO_FONT_MASK_STYLE      => 1 +< 1,
  PANGO_FONT_MASK_VARIANT    => 1 +< 2,
  PANGO_FONT_MASK_WEIGHT     => 1 +< 3,
  PANGO_FONT_MASK_STRETCH    => 1 +< 4,
  PANGO_FONT_MASK_SIZE       => 1 +< 5,
  PANGO_FONT_MASK_GRAVITY    => 1 +< 6,
  PANGO_FONT_MASK_VARIATIONS => 1 +< 7,
);

constant PangoScale is export := guint32;
our enum PangoScaleEnum is export (
  PANGO_SCALE_XX_SMALL => 0.5787037037037,
  PANGO_SCALE_X_SMALL  => 0.6444444444444,
  PANGO_SCALE_SMALL    => 0.8333333333333,
  PANGO_SCALE_MEDIUM   => 1.0,
  PANGO_SCALE_LARGE    => 1.2,
  PANGO_SCALE_X_LARGE  => 1.4399999999999,
  PANGO_SCALE_XX_LARGE => 1.728,
);

constant PangoGravity is export := guint32;
our enum PangoGravityEnum is export <
  PANGO_GRAVITY_SOUTH
  PANGO_GRAVITY_EAST
  PANGO_GRAVITY_NORTH
  PANGO_GRAVITY_WEST
  PANGO_GRAVITY_AUTO
>;

constant PangoGravityHint is export := guint32;
our enum PangoGravityHintEnum is export <
  PANGO_GRAVITY_HINT_NATURAL
  PANGO_GRAVITY_HINT_STRONG
  PANGO_GRAVITY_HINT_LINE
>;

constant PangoAttrType is export := guint32;
our enum PangoAttrTypeEnum is export (
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

constant PangoCoverageLevel is export := guint32;
our enum PangoCoverageLevelEnum is export <
  PANGO_COVERAGE_NONE
  PANGO_COVERAGE_FALLBACK
  PANGO_COVERAGE_APPROXIMATE
  PANGO_COVERAGE_EXACT
>;

constant PangoTabAlign is export := guint32;
our enum PangoTabAlignEnum is export <
  PANGO_TAB_LEFT
>;

constant PangoOverline is export := guint32;
our enum PangoOverlineEnum is export <
  PANGO_OVERLINE_NONE
  PANGO_OVERLINE_SINGLE
>;

constant PangoShowFlags is export := guint32;
our enum PangoShowFlagsEnum is export (
  PANGO_SHOW_NONE        => 0,
  PANGO_SHOW_SPACES      => 1,
  PANGO_SHOW_LINE_BREAKS => 1 +< 1,
  PANGO_SHOW_IGNORABLES  => 1 +< 2
);

constant PangoTextTransform is export := guint32;
our enum PangoTextTransformEnum is export <
  PANGO_TEXT_TRANSFORM_NONE
  PANGO_TEXT_TRANSFORM_LOWERCASE
  PANGO_TEXT_TRANSFORM_UPPERCASE
  PANGO_TEXT_TRANSFORM_CAPITALIZE
>;
