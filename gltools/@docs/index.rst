Overview
========

**gltools** is library for quickly creating OpenGL based
application in Python/Cython with support for:

 * Access to vertex buffers and GLSL shaders
 * Access to truetype fonts
 * Windows handling through GLFW
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

For Linux build scripts are available for ArchLinux in the AUR_
repository. These could be adapted to other Linux distros.

Note that currently I can not find a way to install the required
Cython 'pxd' files with distutils and this file has to be copied
manually.

History
=======

 * v0.1.1 : Added missing files and fix building against GLFW3 trunk.

API Docs
========

.. toctree::
    :maxdepth: 2
    
    content
    
Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

.. _geotools: http://github.com/tenko/geotools

.. _GLFW: http://github.com/elmindreda/glfw

.. _pypi: http://pypi.python.org/pypi/gltools

.. _AUR: https://aur.archlinux.org/packages/?O=0&K=gltools