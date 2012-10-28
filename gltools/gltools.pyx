# -*- coding: utf-8 -*-
#cython: embedsignature=True
#
# This file is part of gltools - See LICENSE.txt
#
from geotools cimport *
from GLToolsLib cimport *

class GLError(Exception):
    pass

include "Utilities.pxi"
include "Constants.pxi"
include "GLFW.pxi"
include "Color.pxi"
include "Image.pxi"
include "GL.pxi"
include "ClientBuffer.pxi"
include "ShaderProgram.pxi"
include "Text.pxi"
include "Texture.pxi"
include "UI.pxi"
        
def test2d(double [:, ::1] arr):
    for row in range(4):
        for col in range(4):
            print row, col, arr[row][col]
        print
    print

def test1d(double [:] vec):
    for col in range(4):
        print col, vec[col]
    print

def test1f(float [:] vec):
    for col in range(4):
        print col, vec[col]
    print