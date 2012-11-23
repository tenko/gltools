Introduction
============

gltools is library for quickly creating OpenGL based
application in Python/Cython with support for:

 * Access to vertex buffers and GLSL shaders
 * Access to truetype fonts
 * Windows handling through GLFW
 * Saving framebuffer content to PNG file.
 * Simple GUI controls

OpenGL version 2.1 is targeted which should be available
in most computers these days, even in a laptop's integrated
graphics.

The license is GPL v2.

Building
========

 * Python 2.7/3.x and Cython 0.17 or later.
 * The geotools_ library.
 * GLFW_ v3.0 (not released, must be build from GIT repo)
 * OpenGL headers
 
Prebuild installers are available on the pypi_ site
for the Windows platform.

Note that currently I can not find a way to install the required
Cython 'pxd' files with distutils and this file has to be copied
manually.

Documentation
=============

See online Sphinx docs_

.. _docs: http://tenko.github.com/gltools/index.html

.. _geotools: http://github.com/tenko/geotools

.. _GLFW: http://github.com/elmindreda/glfw

.. _pypi: http://pypi.python.org/pypi/gltools