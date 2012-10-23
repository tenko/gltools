# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#

from glLib cimport *

# init OpenGL function pointers
cpdef InitGLExt():
    if not c_initGLExt():
        raise GLError(errorMessage)
        
cpdef BlendFunc(unsigned int sfactor, unsigned int dfactor):
    glBlendFunc(sfactor, dfactor)
    
cpdef Clear(unsigned int mask):
    glClear(mask)
    
cpdef ClearColor(ColorRGBA col):
    glClearColor(col.red / 255., col.green / 255., col.blue / 255., col.alpha / 255.)

cpdef ClearDepth(double depth):
    glClearDepth(depth)

cpdef Color(ColorRGBA col):
    glColor4ub(col.red, col.green, col.blue, col.alpha )
    
cpdef Disable(unsigned int cap):
    glDisable(cap)

cpdef DrawArrays(unsigned int mode, int first, int count):
    glDrawArrays(mode, first, count)

cpdef DrawElements(unsigned int mode, int count, int type, indices):
    cdef size_t offset
    if isinstance(indices, int):
        offset = indices
        glDrawElements(mode, count, type, <void *>offset)
    else:
        glDrawElements(mode, count, type, getVoidPtr(indices))
    
cpdef Enable(unsigned int cap):
    glEnable(cap)

cpdef LineWidth(float width):
    glLineWidth(width)
    
cpdef LightModeli(int pname, int param):
    glLightModeli(pname, param)
    
cpdef LoadIdentity():
    glLoadIdentity()

cpdef LoadMatrixd(Transform tr):
    cdef double cm[16]
    
    # col 1
    cm[0]  = tr.m[0][0]
    cm[1]  = tr.m[1][0]
    cm[2]  = tr.m[2][0]
    cm[3]  = tr.m[3][0]
    
    # col 2
    cm[4]  = tr.m[0][1]
    cm[5]  = tr.m[1][1]
    cm[6]  = tr.m[2][1]
    cm[7]  = tr.m[3][1]
    
    # col 3
    cm[8]  = tr.m[0][2]
    cm[9]  = tr.m[1][2]
    cm[10] = tr.m[2][2]
    cm[11] = tr.m[3][2]
    
    # col 4
    cm[12] = tr.m[0][3]
    cm[13] = tr.m[1][3]
    cm[14] = tr.m[2][3]
    cm[15] = tr.m[3][3]
    
    glLoadMatrixd(cm)
    
cpdef MatrixMode(unsigned int mode):
    glMatrixMode(mode)

cpdef Ortho(double left, double right, double bottom, double top, double zNear, 
            double zFar):
    glOrtho(left, right, bottom, top, zNear, zFar)
    
cpdef PolygonMode(unsigned int face, unsigned int mode):
    glPolygonMode(face, mode)
    
cpdef Viewport(int x, int y, int width, int height):
    glViewport(x, y, width, height)
    