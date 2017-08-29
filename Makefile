CC        := gcc
CFLAGS    := -O2 -fPIC
PROGRAM   := libgstfaac.dll

INCLUDES  := \
	-isystem /c/gstreamer/1.0/x86_64/lib/glib-2.0/include \
	-isystem /c/gstreamer/1.0/x86_64/include/glib-2.0 \
	-isystem /c/gstreamer/1.0/x86_64/include/gstreamer-1.0 \
	-isystem faac/include

DEFINES   := \
	-DVERSION=\""1.0\"" \
	-DPACKAGE=\""gst-plugins-bad"\" \
	-DGST_PACKAGE_NAME=\""GStreamer Voysys git"\" \
	-DGST_PACKAGE_ORIGIN=\""https://github.com/voysys/libgstfaac"\"

LIBDIR    := \
	-Lfaac/libfaac/.libs \
	-L/c/gstreamer/1.0/x86_64/lib
LIBRARIES := \
	-l:libfaac.a \
	-l:glib-2.0.lib \
	-l:gobject-2.0.lib \
	-l:gstreamer-1.0.lib \
	-l:gstaudio-1.0.lib \
	-l:gstpbutils-1.0.lib

HEADERS   := $(wildcard *.h)
SOURCES   := $(wildcard *.c)
OBJECTS   := $(patsubst %.c, %.o, $(SOURCES))

all: $(PROGRAM)

$(PROGRAM): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(PROGRAM) -shared $(LIBDIR) $(LIBRARIES)

$(OBJECTS): %.o : %.c $(HEADERS)
	$(CC) -c $(CFLAGS) $(DEFINES) $(INCLUDES) -o $@ $<

clean:
	rm -f $(PROGRAM)
	rm -f $(OBJECTS)

.PHONY: all clean
