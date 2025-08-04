bin_PROGRAMS = st

st_SOURCES   = st.c x.c
st_CFLAGS    = -I$(top_srcdir) -I/usr/X11R6/include \
               ${FREETYPE2_CFLAGS} ${FONTCONFIG_CFLAGS} \
               -DVERSION=\"$(PACKAGE_VERSION)\" -D_XOPEN_SOURCE=600 -O1
st_LDADD     = -L/usr/X11R6/lib -lm -lrt -lX11 -lutil -lXft \
               ${FONTCONFIG_LIBS} ${FREETYPE2_LIBS}

# Regra para copiar config.def.h para xconfig.h antes da compilação
BUILT_SOURCES = xconfig.h
xconfig.h: config.def.h
	cp config.def.h xconfig.h

CLEANFILES = config.h st
