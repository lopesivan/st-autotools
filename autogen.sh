#!/bin/sh

# if not exist path `m4' then create
_d=m4
test -d $_d || mkdir $_d

# if not exist path `build-aux' then create
_d=build-aux
test -d $_d || mkdir $_d

aclocal -I m4
autoconf
autoheader
automake --add-missing
#./configure

# Verificar se foi bem-sucedido
if [ $? -eq 0 ]; then
    echo ""
    echo "Configuração gerada com sucesso!"
    echo "Agora execute:"
    echo "  ./configure"
    echo "  make"
    echo ""
    echo "Opções úteis do configure:"
    echo "  --enable-debug     Habilitar modo debug"
else
    echo "Erro ao gerar configuração!"
    exit 1
fi

exit 0
