#
# File:  Makefile (for library)
#
PYTHON=python2

.PHONY: all docs test install clean

all:
	@echo lib Makefile - building python extension
	$(PYTHON) setup_build.py build_ext --inplace
	-strip --strip-all gltools.so

docs: all
	@echo lib Makefile - building documentation
	@cd @docs ; $(PYTHON) ../setup_docs.py build_sphinx
	@cp -rf @docs/build/sphinx/html/* @docs/html/
    
install: all
	@cp gltools.so ~/.local/lib/python2.7/site-packages/
	@cp gltools.pxd ~/.local/lib/python2.7/site-packages/
    
clean:
	-rm -rf build
	-rm gltools.cpp
	-rm gltools.so