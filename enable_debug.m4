dnl === Macro para --enable-debug ===
AC_DEFUN([MY_ENABLE_DEBUG], [
  AC_ARG_ENABLE([debug],
    AS_HELP_STRING([--enable-debug], [Habilitar modo debug]),
    [debug=$enableval],
    [debug=no])

  if test "x$debug" = "xyes"; then
    AC_DEFINE([DEBUG], [1], [Habilita código de depuração])
    CFLAGS="$CFLAGS -g -O0 -DDEBUG"
  else
    AC_DEFINE([NDEBUG], [1], [Desativa código de depuração])
    CFLAGS="$CFLAGS -O2 -DNDEBUG"
  fi
])

