bin_PROGRAMS = st

st_SOURCES   = st.c x.c

# Use apenas as flags vindas do pkg-config
st_CFLAGS    = -I$(top_srcdir) \
               ${FREETYPE2_CFLAGS} ${FONTCONFIG_CFLAGS} \
               -DVERSION=\"$(PACKAGE_VERSION)\" -D_XOPEN_SOURCE=600 -O2

# Use apenas as libs vindas do pkg-config e bibliotecas extras
st_LDADD     = ${FREETYPE2_LIBS} ${FONTCONFIG_LIBS} -lX11 -lutil -lXft -lm -lrt

# Regra para copiar config.def.h para xconfig.h antes da compilação
BUILT_SOURCES = xconfig.h
xconfig.h: config.def.h
	cp config.def.h xconfig.h

CLEANFILES = xconfig.h st
