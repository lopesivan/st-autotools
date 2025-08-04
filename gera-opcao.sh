#!/usr/bin/env bash

# Uso:
#   ./gera-opcao.sh enable nome "Descrição"
#   ./gera-opcao.sh disable nome "Descrição"
#   ./gera-opcao.sh with nome "Descrição"

set -e

if [[ $# -lt 3 ]]; then
    echo "Uso: $0 <enable|disable|with> <nome_opcao> <descricao>"
    echo "Exemplos:"
    echo "  $0 enable debug 'Ativa modo de depuração'"
    echo "  $0 disable security 'Desabilita checagens de segurança'"
    echo "  $0 with ssl 'Usa biblioteca OpenSSL do diretório especificado'"
    exit 1
fi

tipo="$1"
opcao="$2"
descricao="$3"
define_name=$(echo "$opcao" | tr '[:lower:]' '[:upper:]')
macro_file="m4/${tipo}_${opcao}.m4"

mkdir -p m4

DOLAR='$'

case "$tipo" in
    enable)
        cat >"$macro_file" <<EOF
dnl === Macro para --enable-${opcao} ===
AC_DEFUN([MY_ENABLE_${define_name}], [
  AH_TEMPLATE([${define_name}], [Define para ${descricao}])

  AC_ARG_ENABLE([$opcao],
    AS_HELP_STRING([--enable-${opcao}], [${descricao}]),
    [if test "x${DOLAR}enable_${opcao}" = xyes; then
       AC_DEFINE([${define_name}], [1])
     fi])
])
EOF
        ;;

    disable)
        cat >"$macro_file" <<EOF
dnl === Macro para --disable-${opcao} ===
AC_DEFUN([MY_DISABLE_${define_name}], [
  AH_TEMPLATE([${define_name}], [Define para ${descricao}])

  AC_DEFINE([${define_name}], [1])

  AC_ARG_ENABLE([$opcao],
    AS_HELP_STRING([--disable-${opcao}], [${descricao}]),
    [test "x${DOLAR}enable_${opcao}" = xno && AC_DEFINE([${define_name}], [0])])
])
EOF
        ;;

    with)
        cat >"$macro_file" <<EOF
dnl === Macro para --with-${opcao} ===
AC_DEFUN([MY_WITH_${define_name}], [
  AH_TEMPLATE([WITH_${define_name}], [Define se ${opcao} está habilitado])

  AC_ARG_WITH([$opcao],
    AS_HELP_STRING([--with-${opcao}=@<:@DIR@:>@], [${descricao}]),
    [
      if test "x${DOLAR}with_${opcao}" != xno; then
        AC_DEFINE([WITH_${define_name}], [1])
        ${define_name}_PATH="${DOLAR}with_${opcao}"
        AC_SUBST([${define_name}_PATH])
      fi
    ])

  AM_CONDITIONAL(WITH_${define_name}, [test "x${DOLAR}with_${opcao}" != xno])
])
EOF
        ;;

    *)
        echo "Tipo inválido: $tipo. Use enable, disable ou with."
        exit 1
        ;;
esac

echo "✅ Macro criada em: $macro_file"
echo "📌 Adicione ao configure.ac:  MY_${tipo^^}_${define_name}"
