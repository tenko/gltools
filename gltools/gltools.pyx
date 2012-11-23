# -*- coding: utf-8 -*-
#cython: embedsignature=True
#
# This file is part of gltools - See LICENSE.txt
#
import sys

if sys.hexversion > 0x03000000:
    unicode = str
    
from geotools cimport *
from GLToolsLib cimport *

class GLError(Exception):
    pass

include "Config.pxi"
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