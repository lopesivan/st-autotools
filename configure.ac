dnl ====== Metadados do pacote ===============================================
AC_INIT([st], [0.9.2], [http://github.com/lopesivan/st/issue], [st], [http://github.com/lopesivan/st])

dnl ====== Force autoconf to be at least this version number:
AC_PREREQ([2.68])

dnl build-aux
# Put autotools auxiliary files in a subdir, so they don't
# clutter top dir:
AC_CONFIG_AUX_DIR([build-aux])

dnl AM_INIT_AUTOMAKE
AM_INIT_AUTOMAKE([1.10 -Wall foreign])

dnl "about.c"
# Safety check - list a source file that wouldn't be in other
# directories:
AC_CONFIG_SRCDIR([about.c])

dnl "config.h"
# Put configuration results here, #include "config.h"
AC_CONFIG_HEADERS([config.h])

dnl "config.h" -> LICENSE_URL
# Crio uma variável no config.h de nome `LICENSE_URL' e seto como
# "http://gnu.org/licenses/gpl.html".
AC_DEFINE(LICENSE_URL, ["http://gnu.org/licenses/gpl.html"], [Essa variável aparece no config.h])

dnl "config.h" -> AUTHOR
# Crio uma variável no config.h de nome `AUTHOR' e seto como
# "Ivan Lopes".
AC_DEFINE(AUTHOR, ["Ivan Lopes"], [Essa variável aparece no config.h])

dnl ====== bibliotescas ======================================================
PKG_PROG_PKG_CONFIG
PKG_CHECK_MODULES(FONTCONFIG, [fontconfig])
#PKG_CHECK_MODULES(FREETYPE2,  [freetype2])

AC_SUBST(FONTCONFIG_CFLAGS)
AC_SUBST(FONTCONFIG_LIBS)
#AC_SUBST(FREETYPE2_CFLAGS)
#AC_SUBST(FREETYPE2_LIBS)

# Configurações adicionais para wxWidgets
#CFLAGS="$CFLAGS ${FREETYPE2_CFLAGS} ${FONTCONFIG_CFLAGS}"
#LIBS="$LIBS ${FONTCONFIG_LIBS} ${FREETYPE2_LIBS}"

dnl ====== Adiciona suporte à macro personalizada ============================
MY_ENABLE_DEBUG
if test "x$enable_debug" = "xyes"; then
	CFLAGS="-g -O0 -DDEBUG"
else
	CFLAGS="-O2"
fi

dnl ====== Compilador ========================================================
AC_PROG_CC
AC_PROG_CC_C_O

AC_CANONICAL_HOST
AC_CONFIG_FILES([Makefile
		         src/Makefile])

dnl ====== Fecha o script ====================================================
AC_OUTPUT

echo "
$PACKAGE_NAME $PACKAGE_VERSION

    Configuração:
    Debug:              $debug

    Compilador:         $CC
    CFLAGS:             $CFLAGS
    LDFLAGS:            $LDFLAGS
    LIBS:               $LIBS

    Agora execute 'make' para compilar.
"
# modeline
# vim:set nowrap foldtext=getline(v\:foldstart) foldmethod=expr foldexpr=getline(v\:lnum)=~'^dnl'?'>1'\:'=':
