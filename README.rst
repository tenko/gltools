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
 * GLFW_ v3.0
 * OpenGL headers

For Linux build scripts are available for ArchLinux in the AUR_
repository. These could be adapted to other Linux distros.

History
=======

 * v0.2.1 : Updated to released version of GLFW3
 * v0.1.1 : Added missing files and fix building against GLFW3 trunk.

Documentation
=============

See online Sphinx docs_

.. _docs: http://tenko.github.com/gltools/index.html

.. _geotools: http://github.com/tenko/geotools

.. _GLFW: http://github.com/elmindreda/glfw

.. _pypi: http://pypi.python.org/pypi/gltools

.. _AUR: https://aur.archlinux.org/packages/?O=0&K=gltools