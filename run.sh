./gera-opcao.sh enable debug 'Ativa modo de depuração'

sh ./autogen.sh

#./configure  --enable-debug
./configure
make
