#include "config.h"
#include <stdio.h>

int main(int argc, char* argv[])
{
#ifdef DEBUG
    printf("Modo DEBUG ativado\n");
#endif

    printf("Name of package: '\e[1;34m%s\e[m'\n"
           "The address where bug reports for this package\n"
           "should be sent: '\e[1;34m%s\e[m'\n"
           "The full name of this package is '\e[1;34m%s\e[m'\n"
           "The full name and version of this package are '\e[1;34m%s\e[m'\n"
           "The one symbol short name of this package: '\e[1;34m%s\e[m'\n"
           "Home page for this package: '\e[1;34m%s\e[m'\n"
           "Version of this package: '\e[1;34m%s\e[m'\n"
           "Version number of package: '\e[1;34m%s\e[m'\n",
           PACKAGE, PACKAGE_BUGREPORT, PACKAGE_NAME, PACKAGE_STRING,
           PACKAGE_TARNAME, PACKAGE_URL, PACKAGE_VERSION, VERSION);
    return 0;
}
