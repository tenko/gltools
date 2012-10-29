# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#

from glLib cimport *

# init OpenGL function pointers
cpdef InitGLExt():
    '''
    Initialize OpenGL 2.1 extension
    
    Raise GLError if extensions not found
    '''
    if not c_initGLExt():
        raise GLError(errorMessage)

cpdef int Check():
    '''
    Check for OpenGL errors.
    
    Raises GLError.
    '''
    if not glCheck():
        raise GLError(errorMessage)
        
cpdef BlendFunc(unsigned int sfactor, unsigned int dfactor):
    '''
    Specify pixel arithmetic
    
    :sfactor:   Specifies how the red, green, blue, and alpha source blending
                factors are computed. The initial value is GL_ONE.

    :dfactor:   Specifies how the red, green, blue, and alpha destination
                blending factors are computed. gl.ONE_MINUS_SRC_COLOR etc.
    '''
    glBlendFunc(sfactor, dfactor)
    
cpdef Clear(unsigned int mask):
    '''
    Clear selected buffers to preset values.
    
    :mask: bit flags are gl.COLOR_BUFFER_BIT, gl.DEPTH_BUFFER_BIT, and 
           gl.STENCIL_BUFFER_BIT
    '''
    glClear(mask)
    
cpdef ClearColor(ColorRGBA col):
    '''
    Specify clear values for the color buffers
    '''
    glClearColor(col.red / 255., col.green / 255., col.blue / 255., col.alpha / 255.)

cpdef ClearDepth(double depth):
    '''
    Specify the clear value for the depth buffer
    '''
    glClearDepth(depth)

cpdef Color(ColorRGBA col):
    '''
    Sets the current color.
    '''
    glColor4ub(col.red, col.green, col.blue, col.alpha )
    
cpdef Disable(unsigned int cap):
    '''
    Disable server-side GL capabilities
    '''
    glDisable(cap)

cpdef DrawArrays(unsigned int mode, int first, int count):
    '''
    Render primitives from array data
    
    :mode: Primitive type gl.POINTS, gl.LINE_STRIP, etc.
    :first: Specifies the starting index in the enabled arrays.
    :count: Specifies the number of indices to be rendered.
    '''
    glDrawArrays(mode, first, count)

cpdef DrawElements(unsigned int mode, int count, int type, indices):
    '''
    Render primitives from array data with indices.
    
    :mode: Primitive type gl.POINTS, gl.LINE_STRIP, etc.
    :count: Specifies the number of indices to be rendered.
    :type: Indices data type. One of gl.UNSIGNED_BYTE, gl.UNSIGNED_SHORT, or
           gl.UNSIGNED_INT
    :indices: Either a python object with valid buffer interface or and
              integer as a pointer into a already bound ClientBuffer of
              element array type.
    '''
    cdef int offset
    try:
        offset = indices
        glDrawElements(mode, count, type, <void *>offset)
    except TypeError:
        glDrawElements(mode, count, type, getVoidPtr(indices))
    
cpdef Enable(unsigned int cap):
    '''
    Enable server-side GL capabilities
    '''
    glEnable(cap)

cpdef Hint(int target, int mode):
    '''
    specify implementation-specific hints
    '''
    glHint(target, mode)

cpdef LineWidth(float width):
    '''
    Specify the width of rasterized lines
    '''
    glLineWidth(width)
    
cpdef LightModeli(int pname, int param):
    '''
    Sets lighting model parameters.
    
    Example::
        gl.LightModeli(gl.LIGHT_MODEL_TWO_SIDE, gl.TRUE)
    '''
    glLightModeli(pname, param)
    
cpdef LoadIdentity():
    '''
    Replace the current matrix with the identity matrix
    '''
    glLoadIdentity()

cpdef LoadMatrixd(Transform tr):
    '''
    Replace the current matrix with given matrix.
    '''
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
    '''
    Specify which matrix is the current matrix
    
    :mode: gl.MODELVIEW, gl.PROJECTION, or gl.TEXTURE
    '''
    glMatrixMode(mode)

cpdef Ortho(double left, double right, double bottom, double top, double zNear, 
            double zFar):
    '''
    Multiply the current matrix with an orthographic matrix
    
    :left: Specify the coordinates for the left vertical clipping plane.
    :right: Specify the coordinates for the vertical clipping plane.
    :bottom: Specify the coordinates for the bottom horizontal clipping plane.
    :top: Specify the coordinates for the top horizontal clipping plane.
    :zNear: Specify the distances to the nearer clipping plane.
    :zFar: Specify the distances to the farther depth clipping plane.
    '''
    glOrtho(left, right, bottom, top, zNear, zFar)

cpdef PolygonMode(unsigned int face, unsigned int mode):
    '''
    Select a polygon rasterization mode
    
    Example::
        gl.PolygonMode(gl.FRONT_AND_BACK, gl.FILL)
    '''
    glPolygonMode(face, mode)

cpdef PolygonOffset(float factor, float units):
    '''
    Set the scale and units used to calculate depth values
    
    :factor: Specifies a scale factor that is used to create a variable depth
             offset for each polygon.
    :units: Is multiplied by an implementation-specific value to create a
            constant depth offset.
    '''
    glPolygonOffset(factor, units)

cpdef ColorRGBA ReadPixel(int x, int y):
    '''
    Read a sigle pixel from the frame buffer.
    '''
    cdef unsigned char pixel[4]
    cdef ColorRGBA ret = ColorRGBA.__new__(ColorRGBA)
    
    glReadPixels(x, y, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, pixel)
    
    ret.red = pixel[0]
    ret.green = pixel[1]
    ret.blue = pixel[2]
    ret.alpha = pixel[3]
    return ret
    
cpdef ReadPixels(int x, int y, Image img):
    '''
    Read a block of pixels from the frame buffer
    '''
    cdef  GLenum format
    
    if img.bytesPerPixel == 3:
        format = GL_RGB
    else:
        format = GL_RGBA
    
    glPixelStorei(GL_PACK_ALIGNMENT, 1)
    glReadPixels(x, y, img.width, img.height, format, GL_UNSIGNED_BYTE, img._buffer)
    
    
cpdef Viewport(int x, int y, int width, int height):
    '''
    Set the viewport
    
    :x: x coordiante of lower left corner.
    :y: y coordiante of lower left corner.
    :width: viewport width
    :height: viewport height
    '''
    glViewport(x, y, width, height)
    