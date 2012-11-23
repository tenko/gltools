#
# File:  Makefile (for library)
#
# The variables 'PYTHON' and 'PYVER' can be modified by
# passing parameters to make: make PYTHON=python PYVER=2.6
#
PYTHON=python2
PYVER=2.7

.PHONY: all docs test install clean

all:
	@echo lib Makefile - building python extension
	$(PYTHON) setup_build.py build_ext --inplace
    
docs: all
	@echo lib Makefile - building documentation
	@cd gltools/@docs ; $(PYTHON) ../../setup_docs.py build_sphinx
	@cp -rf gltools/@docs/build/sphinx/html/* gltools/@docs/html/
    
install: all
	@cp gltools.so ~/.local/lib/python$(PYVER)/site-packages/
	@cp gltools/gltools.pxd ~/.local/lib/python$(PYVER)/site-packages/

sdist: clean
	@echo lib Makefile - creating source distribution
	$(PYTHON) setup_build.py sdist --formats=gztar,zip
    
clean:
	-rm -rf build dist
	-rm -rf gltools/@docs/build
	-rm -rf gltools/@docs/html
	-rm gltools/@src/Config.pxi
	-rm gltools/gltools.cpp gltools.so gltools/gltools.so MANIFEST
	-find gltools -iname '*.so' -exec rm {} \;
	-find gltools -iname '*.pyc' -exec rm {} \;
	-find gltools -iname '*.pyo' -exec rm {} \;
	-find gltools -iname '*.pyd' -exec rm {} \;