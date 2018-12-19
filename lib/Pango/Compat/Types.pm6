
use v6.c;

use NativeCall;

use Cairo;
use Pango::Roles::Pointers;

# Number of times I've had to force compile the whole project.
constant forced = 0;

our $DEBUG is export = 0;

unit package Pango::Compat::Types;

sub cast($cast-to, $obj) is export {
  nativecast($cast-to, $obj);
}

sub set-function-ptr-p(Blob, Str, & (Pointer) --> int32)
  is export
  is symbol('sprintf')
  is native { * }

constant glib       is export = 'glib-2.0',v0;
constant gio        is export = 'gio-2.0',v0;
constant gobject    is export = 'gobject-2.0',v0;
constant cairo      is export = 'cairo',v2;
constant pango      is export = 'pango-1.0',v0;
constant pangocairo is export = 'pangocairo-1.0',v0;
constant pangoft2   is export = 'pangoft2-1.0',v0;

sub g_destroy_none(Pointer)
  is export
  { }

sub g_free (Pointer)
  is native(glib)
  is export
  { * }

class GError is repr('CStruct') does Pango::Roles::Pointers is export {
  has uint32        $.domain;
  has int32         $.code;
  has Str           $.message;
}

# Used ONLY in those situations where cheating is just plain REQUIRED.
class GObjectStruct is repr('CStruct') does Pango::Roles::Pointers is export {
  has uint64  $.g_type_instance;
  has uint32   $.ref_count;
}

our $ERROR is export;

sub gerror is export {
  my $cge = CArray[Pointer[GError]].new;
  $cge[0] = Pointer[GError];
  $cge;
}

sub g_error_free(GError $err)
  is native(glib)
  is export
  { *  }

sub clear_error($error = $ERROR) is export {
  g_error_free($error[0]) with $error[0];
  $ERROR = Nil;
}

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

constant gboolean            is export := uint32;
constant gchar               is export := Str;
constant gconstpointer       is export := Pointer;
constant gdouble             is export := num64;
constant gfloat              is export := num32;
constant gint                is export := int32;
constant gint16              is export := int16;
constant gint64              is export := int64;
constant gint8               is export := int8;
constant glong               is export := int64;
constant gpointer            is export := Pointer;
constant gsize               is export := uint64;
constant gssize              is export := int64;
constant guchar              is export := Str;
constant gshort              is export := int8;
constant gushort             is export := uint8;
constant guint               is export := uint32;
constant guint16             is export := uint16;
constant guint32             is export := uint32;
constant guint64             is export := uint64;
constant guint8              is export := uint8;
constant gulong              is export := uint64;
constant gunichar            is export := uint32;
constant va_list             is export := Pointer;

constant FcConfig            is export := Pointer;
constant FcPattern           is export := Pointer;
constant FT_Bitmap           is export := Pointer;

constant GAsyncReadyCallback is export := Pointer;
constant GCallback           is export := Pointer;
constant GCancellable        is export := Pointer;
constant GClosure            is export := Pointer;
constant GCompareDataFunc    is export := Pointer;
constant GCompareFunc        is export := Pointer;
constant GCopyFunc           is export := Pointer;
constant GDestroyNotify      is export := Pointer;
constant GEqualFunc          is export := Pointer;
constant GQuark              is export := uint32;
constant GStrv               is export := CArray[Str];
constant GType               is export := uint64;
constant GVariant            is export := Pointer;

class GList is repr('CStruct') does Pango::Roles::Pointers is export {
  has Pointer $.data;
  has GList   $.next;
  has GList   $.prev;
}

class GPermission is repr('CStruct') does Pango::Roles::Pointers is export {
  has uint64 $.dummy1;
  has uint64 $.dummy2;
  has uint64 $.dummy3;
  has uint64 $.dummy4;
}

class GSList is repr('CStruct') does Pango::Roles::Pointers is export {
  has Pointer $!data;
  has GSList  $.next;
}

class GTypeValueList is repr('CUnion') is export {
  has int32	          $.v_int     is rw;
  has uint32          $.v_uint    is rw;
  has long            $.v_long    is rw;
  has ulong           $.v_ulong   is rw;
  has int64           $.v_int64   is rw;
  has uint64          $.v_uint64  is rw;
  has num32           $.v_float   is rw;
  has num64           $.v_double  is rw;
  has OpaquePointer   $.v_pointer is rw;
};

class GValue is repr('CStruct') does Pango::Roles::Pointers is export {
  has ulong           $.g_type is rw;
  HAS GTypeValueList  $.data1  is rw;
  HAS GTypeValueList  $.data2  is rw;
}

our enum GTypeEnum is export (
  G_TYPE_INVALID   => 0,
  G_TYPE_NONE      => (1  +< 2),
  G_TYPE_INTERFACE => (2  +< 2),
  G_TYPE_CHAR      => (3  +< 2),
  G_TYPE_UCHAR     => (4  +< 2),
  G_TYPE_BOOLEAN   => (5  +< 2),
  G_TYPE_INT       => (6  +< 2),
  G_TYPE_UINT      => (7  +< 2),
  G_TYPE_LONG      => (8  +< 2),
  G_TYPE_ULONG     => (9  +< 2),
  G_TYPE_INT64     => (10 +< 2),
  G_TYPE_UINT64    => (11 +< 2),
  G_TYPE_ENUM      => (12 +< 2),
  G_TYPE_FLAGS     => (13 +< 2),
  G_TYPE_FLOAT     => (14 +< 2),
  G_TYPE_DOUBLE    => (15 +< 2),
  G_TYPE_STRING    => (16 +< 2),
  G_TYPE_POINTER   => (17 +< 2),
  G_TYPE_BOXED     => (18 +< 2),
  G_TYPE_PARAM     => (19 +< 2),
  G_TYPE_OBJECT    => (20 +< 2),
  G_TYPE_VARIANT   => (21 +< 2),

  G_TYPE_RESERVED_GLIB_FIRST => 22,
  G_TYPE_RESERVED_GLIB_LAST  => 31,
  G_TYPE_RESERVED_BSE_FIRST  => 32,
  G_TYPE_RESERVED_BSE_LAST   => 48,
  G_TYPE_RESERVED_USER_FIRST => 49
);

our enum GVariantType is export <
  G_VARIANT_CLASS_BOOLEAN
  G_VARIANT_CLASS_BYTE
  G_VARIANT_CLASS_INT16
  G_VARIANT_CLASS_UINT16
  G_VARIANT_CLASS_INT32
  G_VARIANT_CLASS_UINT32
  G_VARIANT_CLASS_INT64
  G_VARIANT_CLASS_UINT64
  G_VARIANT_CLASS_HANDLE
  G_VARIANT_CLASS_DOUBLE
  G_VARIANT_CLASS_STRING
  G_VARIANT_CLASS_OBJECT_PATH
  G_VARIANT_CLASS_SIGNATURE
  G_VARIANT_CLASS_VARIANT
  G_VARIANT_CLASS_MAYBE
  G_VARIANT_CLASS_ARRAY
  G_VARIANT_CLASS_TUPLE
  G_VARIANT_CLASS_DICT_ENTRY
>;

our enum GApplicationFlags is export (
  G_APPLICATION_FLAGS_NONE           => 0,
  G_APPLICATION_IS_SERVICE           => 1,
  G_APPLICATION_IS_LAUNCHER          => 2,
  G_APPLICATION_HANDLES_OPEN         => 4,
  G_APPLICATION_HANDLES_COMMAND_LINE => 8,
  G_APPLICATION_SEND_ENVIRONMENT     => 16,
  G_APPLICATION_NON_UNIQUE           => 32,
  G_APPLICATION_CAN_OVERRIDE_APP_ID  => 64
);

our enum GAppInfoCreateFlags is export (
  G_APP_INFO_CREATE_NONE                           => 0,         # nick=none
  G_APP_INFO_CREATE_NEEDS_TERMINAL                 => 1,         # nick=needs-terminal
  G_APP_INFO_CREATE_SUPPORTS_URIS                  => (1 +< 1),  # nick=supports-uris
  G_APP_INFO_CREATE_SUPPORTS_STARTUP_NOTIFICATION  => (1 +< 2)   # nick=supports-startup-notification
);

our enum GKeyFileFlags is export (
  G_KEY_FILE_NONE              => 0,
  G_KEY_FILE_KEEP_COMMENTS     => 1,
  G_KEY_FILE_KEEP_TRANSLATIONS => 2
);

our enum GFileCreateFlags is export (
  G_FILE_CREATE_NONE                => 0,
  G_FILE_CREATE_PRIVATE             => 1,
  G_FILE_CREATE_REPLACE_DESTINATION => 2
);

class cairo_content_t       is repr('CPointer') is export does Pango::Roles::Pointers { }
class cairo_font_options_t  is repr('CPointer') is export does Pango::Roles::Pointers { }
#class cairo_surface_t       is repr('CPointer') is export does Pango::Roles::Pointers { }

class AtkObject             is repr('CPointer') is export does Pango::Roles::Pointers { }

class GActionGroup          is repr('CPointer') is export does Pango::Roles::Pointers { }
class GAppInfo              is repr('CPointer') is export does Pango::Roles::Pointers { }
class GAppInfoMonitor       is repr('CPointer') is export does Pango::Roles::Pointers { }
class GAppLaunchContext     is repr('CPointer') is export does Pango::Roles::Pointers { }
class GApplication          is repr('CPointer') is export does Pango::Roles::Pointers { }
class GAsyncResult          is repr('CPointer') is export does Pango::Roles::Pointers { }
class GByteArray            is repr('CPointer') is export does Pango::Roles::Pointers { }
class GBytes                is repr('CPointer') is export does Pango::Roles::Pointers { }
class GFile                 is repr('CPointer') is export does Pango::Roles::Pointers { }
class GFunc                 is repr('CPointer') is export does Pango::Roles::Pointers { }
class GHashTable            is repr('CPointer') is export does Pango::Roles::Pointers { }
class GIcon                 is repr('CPointer') is export does Pango::Roles::Pointers { }
class GInputStream          is repr('CPointer') is export does Pango::Roles::Pointers { }
class GKeyFile              is repr('CPointer') is export does Pango::Roles::Pointers { }
class GListModel            is repr('CPointer') is export does Pango::Roles::Pointers { }
class GMarkupParser         is repr('CPointer') is export does Pango::Roles::Pointers { }
class GMenu                 is repr('CPointer') is export does Pango::Roles::Pointers { }
class GMenuItem             is repr('CPointer') is export does Pango::Roles::Pointers { }
class GMenuAttributeIter    is repr('CPointer') is export does Pango::Roles::Pointers { }
class GMenuLinkIter         is repr('CPointer') is export does Pango::Roles::Pointers { }
class GMenuModel            is repr('CPointer') is export does Pango::Roles::Pointers { }
class GMountOperation       is repr('CPointer') is export does Pango::Roles::Pointers { }
class GObject               is repr('CPointer') is export does Pango::Roles::Pointers { }
class GOutputStream         is repr('CPointer') is export does Pango::Roles::Pointers { }
class GParamSpec            is repr('CPointer') is export does Pango::Roles::Pointers { }
class GPtrArray             is repr('CPointer') is export does Pango::Roles::Pointers { }
class GVolume               is repr('CPointer') is export does Pango::Roles::Pointers { }

class GArray is repr('CStruct') does Pango::Roles::Pointers is export {
  has Str    $.data;
  has uint32 $.len;
}
