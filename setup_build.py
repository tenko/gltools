#!/usr/bin/python2
# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#
import sys
import os
import glob

from distutils.core import setup
from distutils.extension import Extension

try:
    from Cython.Distutils import build_ext
except ImportError:
    print >>sys.stderr, "Cython is required to build geotools"
    sys.exit(1)

#sys.argv.append('build_ext')
#sys.argv.extend(['sdist','--formats=gztar,zip'])
#sys.argv.append('bdist_wininst')

# create config file
sys.dont_write_bytecode = True
import version

CONFIG = 'gltools/@src/Config.pxi'
if not os.path.exists(CONFIG) and 'sdist' not in sys.argv:
    with open(CONFIG, 'w') as fh:
        fh.write("__version__ = '%s'\n" % version.STRING)
        args = version.MAJOR, version.MINOR, version.BUILD
        fh.write("__version_info__ = (%d,%d,%d)\n" % args)

# platform specific settings
OBJECTS, LIBS, LINK_ARGS, COMPILE_ARGS = [],[],[],[]
if sys.platform == 'win32':
    LIBS.append('OPENGL32')
    LIBS.append('glfw3')
    LIBS.append('user32')
    LIBS.append('gdi32')
    OBJECTS.append('glfw3.lib')
    
elif sys.platform == 'darwin':
    LINK_ARGS.extend(['-framework', 'OpenGL', '-arch', 'x86_64'])
    COMPILE_ARGS.extend(['-arch', 'x86_64'])
    LIBS.append('glfw')
else:
    LIBS.append('GL')
    LIBS.append('glfw')
    COMPILE_ARGS.append("-fpermissive")

classifiers = '''\
Development Status :: 4 - Beta
Environment :: MacOS X
Environment :: Win32 (MS Windows)
Environment :: X11 Applications
Intended Audience :: Science/Research
License :: OSI Approved :: GNU General Public License v2 (GPLv2)
Operating System :: OS Independent
Programming Language :: Cython
Topic :: Scientific/Engineering :: Visualization
'''

SRC = [
    "gltools/gltools.pyx",
    "gltools/@src/GLTools.cpp",
    "gltools/@contrib/fontstash.c",
    "gltools/@contrib/stb_image_write.c",
    "gltools/@contrib/imgui.cpp",
    "gltools/@contrib/imguiRenderGL.cpp"
]

DEP = \
    ["gltools/gltools.pxd",] + \
    glob.glob("gltools/@src/*.pxi") + \
    glob.glob("gltools/@src/*.cpp") + \
    glob.glob("gltools/@include/*.pxd") + \
    glob.glob("gltools/@include/*.h")
                              
try:
    setup(
        name = 'gltools',
        version = version.STRING,
        description = 'Library to create OpenGL based applications',
        long_description = \
'''**gltools** is library for quickly creating OpenGL based
application in Python/Cython with support for:

 * Access to vertex buffers and GLSL shaders
 * Access to truetype fonts
 * Windows handling through GLFW
 * Saving framebuffer content to PNG file.
 * Simple GUI controls

**History**

 * v0.1.1 : Added missing files in source distribution
''',
        classifiers = [value for value in classifiers.split("\n") if value],
        author='Runar Tenfjord',
        author_email = 'runar.tenfjord@gmail.com',
        license = 'GPLv2',
        download_url='http://pypi.python.org/pypi/gltools/',
        url = 'http://github.com/tenko/gltools',
        platforms = ['any'],
        requires = ['geotools'],
        
        ext_modules=[
            Extension("gltools",
                        sources = SRC,
                        depends = DEP,
                        include_dirs = ['gltools/@include','gltools/@src',
                                        'gltools/@contrib'],
                        library_dirs = ['gltools'],
                        libraries = LIBS,
                        extra_link_args = LINK_ARGS,
                        extra_compile_args = COMPILE_ARGS,
                        extra_objects = OBJECTS,
                        language="c++"
            ),
        ],
        
        cmdclass = {'build_ext': build_ext}
    )
except:
    print('Traceback\n:%s\n' % str(sys.exc_info()[-2]))
    sys.exit(1)