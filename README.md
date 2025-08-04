Aqui está um script bash que gera opções `--enable` para o `configure.ac`:

```bash
#!/bin/bash

# Verifica os argumentos
if [[ $# -lt 2 ]]; then
    echo "Uso: $0 <nome_opção> <descrição>"
    echo "Exemplo: $0 debug 'compilar com código de depuração'"
    echo ---
    echo "./$0 debug 'compilar com código de depuração'"
    echo "./$0 featureX 'habilita a feature especial X'"
    exit 1
fi

option="$1"
description="$2"
define_name=$(echo "$option" | tr '[:lower:]' '[:upper:]')  # Converte para maiúsculas

# Gera o bloco para o configure.ac
cat << EOF
dnl --enable-${option} => adiciona #define ${define_name} 1
AC_ARG_ENABLE([${option}],
  AS_HELP_STRING([--enable-${option}], [${description}]),
  [test "x\\\$enable_${option}" = xyes && AC_DEFINE([${define_name}], [1],
               [Define para ${description}])])

EOF

echo "Adicione o bludo acima ao seu configure.ac!"
```

### Como usar:
1. Salve como `gera-opcao.sh`
2. Dê permissão de execução: `chmod +x gera-opcao.sh`
3. Execute com o nome da opção e descrição:
```bash
./gera-opcao.sh debug 'compilar com código de depuração'
./gera-opcao.sh featureX 'habilita a feature especial X'
```

### Funcionamento:
1. Recebe o nome da opção (ex: `debug`) e a descrição como parâmetros
2. Converte o nome para maiúsculas para criar o `#define`
3. Gera automaticamente:
   - O comentário dnl
   - A macro `AC_ARG_ENABLE`
   - A lógica de `AC_DEFINE` condicional

O código gerado será compatível com o estilo do exemplo
fornecido, funcionando para qualquer nome de opção que
você desejar.


Vou criar dois scripts separados: um para opções
`--disable-*` (usando `AC_ARG_ENABLE`) e outro para opções
`--with-*` (usando `AC_ARG_WITH`). Aqui estão eles:

---

### 1. Script para opções **--disable-feature** (AC_ARG_ENABLE):

```bash
#!/bin/bash
# Script: gera-disable-opcao.sh

if [[ $# -lt 2 ]]; then
    echo "Uso: $0 <nome_da_opcao> <descricao>"
    echo "Exemplo: $0 security 'desabilita verificações de segurança'"
    exit 1
fi

option="$1"
description="$2"
define_name=$(echo "$option" | tr '[:lower:]' '[:upper:]')

cat << EOF
dnl --disable-${option} => adiciona #define ${define_name} 1
AC_ARG_ENABLE([${option}],
  AS_HELP_STRING([--disable-${option}], [${description}]),
  [test "x\\\$enable_${option}" = xno && AC_DEFINE([${define_name}], [1],
               [Define para ${description}])])

EOF

echo "Adicione o bloco acima ao configure.ac!"
```

**Uso:**
```bash
./gera-disable-opcao.sh security 'desabilita verificações de segurança'
```

**Saída Gerada:**
```autoconf
dnl --disable-security => adiciona #define SECURITY 1
AC_ARG_ENABLE([security],
  AS_HELP_STRING([--disable-security], [desabilita verificações de segurança]),
  [test "x$enable_security" = xno && AC_DEFINE([SECURITY], [1],
               [Define para desabilita verificações de segurança])])
```

---

### 2. Script para opções **--with-feature** (AC_ARG_WITH):

```bash
#!/bin/bash
# Script: gera-with-opcao.sh

if [[ $# -lt 2 ]]; then
    echo "Uso: $0 <nome_da_opcao> <descricao>"
    echo "Exemplo: $0 openssl 'usa biblioteca OpenSSL do diretório especificado'"
    exit 1
fi

option="$1"
description="$2"
define_name=$(echo "$option" | tr '[:lower:]' '[:upper:]')

cat << EOF
dnl --with-${option} => adiciona #define WITH_${define_name} e define variável
AC_ARG_WITH([${option}],
  AS_HELP_STRING([--with-${option}=@<:@DIR@:>@], [${description}]),
  [
    if test "x\\\$with_${option}" != xno; then
      AC_DEFINE([WITH_${define_name}], [1], [Define se ${option} está habilitado])
      ${define_name}_PATH="\\\$with_${option}"
      AC_SUBST([${define_name}_PATH])
    fi
  ])

EOF

echo "Adicione o bloco acima ao configure.ac!"
```

**Uso:**
```bash
./gera-with-opcao.sh openssl 'usa biblioteca OpenSSL do diretório especificado'
```

**Saída Gerada:**
```autoconf
dnl --with-openssl => adiciona #define WITH_OPENSSL e define variável
AC_ARG_WITH([openssl],
  AS_HELP_STRING([--with-openssl=@<:@DIR@:>@], [usa biblioteca OpenSSL do diretório especificado]),
  [
    if test "x$with_openssl" != xno; then
      AC_DEFINE([WITH_OPENSSL], [1], [Define se openssl está habilitado])
      OPENSSL_PATH="$with_openssl"
      AC_SUBST([OPENSSL_PATH])
    fi
  ])
```

---

### Funcionamento dos Scripts:
1. **--disable-feature** (`AC_ARG_ENABLE`):
   - Verifica se a opção foi desabilitada (`test "x$enable_*" = xno`).
   - Define um símbolo no código (ex: `#define SECURITY 1`).

2. **--with-feature** (`AC_ARG_WITH`):
   - Aceita valores opcionais (ex: `--with-openssl=/usr/local`).
   - Define um símbolo (`WITH_OPENSSL`) e exporta uma variável (`OPENSSL_PATH`).
   - Trata o caso especial `--without-openssl` (valor `no`).

### Aplicação Típica:
- Use `--disable-*` para funcionalidades que podem ser removidas.
- Use `--with-*` para integrações com bibliotecas externas ou caminhos personalizados.
