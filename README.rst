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

 * Python 2.6 or later and Cython 0.17.
 * The geotools_ library.
 * GLFW_ v3.0 (not released, must be build from repo)
 * OpenGL headers
 
The extension have only been build on the Linux platform.

Documentation
=============

See online Sphinx docs_

.. _docs: http://tenko.github.com/gltools/index.html

.. _geotools: http://github.com/tenko/geotools

.. _GLFW: http://github.com/elmindreda/glfw