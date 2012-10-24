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
from Cython.Distutils import build_ext

SRC = [
    "gltools.pyx",
    "@src/GLTools.cpp",
    "@contrib/fontstash.c",
    "@contrib/stb_image_write.c",
    "@contrib/imgui.cpp",
    "@contrib/imguiRenderGL.cpp"
]

DEP = \
    ["gltools.pxd",] + \
    glob.glob("@src/*.pxi") + \
    glob.glob("@src/*.cpp") + \
    glob.glob("@include/*.pxd") + \
    glob.glob("@include/*.h")
                              
try:
    setup(
      name = 'gltools',
      ext_modules=[
        Extension("gltools",
                    sources=SRC,
                    depends = DEP,
                    include_dirs = ['@include','@src','@contrib'],
                    libraries = ["GL", "glfw"],
                    extra_compile_args = ["-fpermissive"],
                    language="c++"
        ),
        ],
        
      cmdclass = {'build_ext': build_ext}
    )
except:
    print('Traceback\n:%s\n' % str(sys.exc_info()[-2]))
    sys.exit(1)
else:
    print('\n')