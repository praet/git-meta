#
#  git-meta - Track metadata of git-versioned files and folders
#  Copyright (C) 2011  Pieter Praet <pieter@praet.org>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

SHELL = /bin/sh

prefix=/usr
bindir=$(prefix)/bin
datarootdir=$(prefix)/share
docdir=$(datarootdir)/doc/git-meta

INSTALL=install
INSTALL_PROGRAM=$(INSTALL) -D
INSTALL_DATA=$(INSTALL) -D -m 0644

DIST_FILES=Makefile git-meta README CHANGELOG COPYING
VERSION=$(shell git describe)

all: $(DIST_FILES)

install: $(DIST_FILES) install-doc
	$(INSTALL_PROGRAM) git-meta $(DESTDIR)$(bindir)/git-meta
	sed -i -e "s/@VERSIONTAG@/$(VERSION)/" $(DESTDIR)$(bindir)/git-meta

install-doc: doc
	$(INSTALL_DATA) README $(DESTDIR)$(docdir)/README
	$(INSTALL_DATA) CHANGELOG $(DESTDIR)$(docdir)/CHANGELOG
	$(INSTALL_DATA) COPYING $(DESTDIR)$(docdir)/COPYING

clean:
	rm -rf *.tar.gz git-meta-$(VERSION)

uninstall:
	rm -f $(DESTDIR)$(bindir)/git-meta
	rm -rf $(DESTDIR)$(docdir)

doc: README CHANGELOG

README: git-meta
	./git-meta --usage 2>README
	sed -i -e "s/@VERSIONTAG@/$(VERSION)/" ./README

dist: git-meta-$(VERSION).tar.gz

git-meta-$(VERSION).tar.gz: $(DIST_FILES)
	mkdir -p git-meta-$(VERSION)
	cp --preserve=timestamps $(DIST_FILES) git-meta-$(VERSION)
	sed -i -e "s/@VERSIONTAG@/$(VERSION)/" git-meta-$(VERSION)/git-meta
	tar -cvzf git-meta-$(VERSION).tar.gz git-meta-$(VERSION)
	rm -rf git-meta-$(VERSION)


## EOF
