# We don't want to follow GNU file setup (no README, no AUTHORS, etc)
AUTOMAKE_OPTIONS = foreign

ACLOCAL_AMFLAGS  = -I m4 --install

WARNINGCFLAGS    = -std=gnu99 -Wall -Wno-parentheses
AM_CFLAGS        = $(WARNINGCFLAGS)

bin_PROGRAMS     = about
include_HEADERS  = config.h
about_SOURCES    = about.c
about_CFLAGS     =
about_LDFLAGS    =
#about_CFLAGS    = $(AM_CFLAGS)

SUBDIRS = src

