# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#
from geotools cimport Point, Transform

cdef class ColorRGBA:
    cdef readonly unsigned char red
    cdef readonly unsigned char green
    cdef readonly unsigned char blue
    cdef readonly unsigned char alpha
    cpdef ColorRGBA copy(self, int red = ?, int green = ?, int blue = ?, alpha = ?)
    cpdef unsigned toInt(self)
    cpdef tuple toFloatVector(self)
    cdef setFloatVector(self, float *vec)

cdef class Material:
    cdef public ColorRGBA ambient
    cdef public ColorRGBA diffuse
    cdef public ColorRGBA specular
    cdef public ColorRGBA emissive
    cdef public float shininess
    cdef readonly int mode
    cpdef enable(self)

cdef class Light:
    cdef public Material material
    cdef public Point position
    cdef public bint directional
    cdef readonly int index
    cpdef enable(self)
    cpdef disable(self)
    
cdef class ClientBuffer:
    cdef void *thisptr
    cpdef bind(self)
    cpdef unBind(self)
    cpdef setDataType(self, int type, int dataType, int dataTypeSize,
                      int stride, size_t pointer)
    cdef cloadData(self, void *data, ssize_t size, ssize_t offset, int usage)
    cpdef loadData(self, data, ssize_t size, ssize_t offset = ?, int usage = ?)

cpdef Init()
cpdef double getTime()
cpdef SetTime(double time)
cpdef SetGamma(float gamma)
cpdef tuple GetDesktopSize()

cdef class Window:
    cdef void *thisptr
    cdef public bint running
    cpdef setTitle(self, title)
    cpdef tuple getSize(self)
    cpdef setSize(self, int width, int height)
    cpdef tuple getPos(self)
    cpdef setPos(self, int x, int y)
    cpdef setClipboard(self, content)
    cpdef getClipboard(self)
    cpdef iconify(self)
    cpdef restore(self)
    cpdef show(self)
    cpdef hide(self)
    cpdef close(self)
    cpdef makeContextCurrent(self)
    cpdef swapBuffers(self)
    cpdef mainLoop(self)  
    cpdef onSize(self, int w, int h)
    cpdef onRefresh(self)
    cpdef onCursorPos(self, int x, int y)
    cpdef onMouseButton(self, int button, int action)
    cpdef onKey(self, int key, int action)
    cpdef onChar(self, ch)
    cpdef onFocus(self, int status)
    cpdef onEnter(self, int status)
    cpdef onScroll(self, double dx, double dy)
    cpdef onIconify(self, int status)
    cpdef bint onClose(self)

cdef class ShaderProgram:
    cdef void *thisptr
    cpdef bint isValid(self)
    cpdef begin(self)
    cpdef end(self)
    cpdef loadUniform1i(self, char *name, int value)
    cpdef loadUniform1f(self, char *name, float value)
    cpdef loadUniform4f(self, char *name, float v0, float v1, float v2, float v3)
    cpdef loadUniformMatrix4vf(self, char *name, float [::1] value, int count = ?)
    cpdef build(self, vertex_src = ?, fragment_src = ?)

cpdef BeginText()
cpdef float DrawText(size, float x, float y, text)
cpdef EndText()

cdef class UI:
    cdef int scroll[10]
    cdef int scrollIdx
    
    cpdef bint anyActive(self)
    cpdef flush(self)
    cpdef beginFrame(self, int mx, int my, char mbut, int scroll)
    cpdef endFrame(self)
    cpdef bint beginScrollArea(self, name, int x, int y, int w, int h)
    cpdef endScrollArea(self)
    cpdef indent(self)
    cpdef unindent(self)
    cpdef separator(self)
    cpdef separatorLine(self)
    cpdef bint button(self, text, bint enabled)
    cpdef bint item(self, text, bint enabled)
    cpdef bint check(self, text, bint checked, bint enabled)
    cpdef bint collapse(self, text, char* subtext, bint checked, bint enabled)
    cpdef label(self, text)
    cpdef value(self, text)
    cpdef float slider(self, text, float val, float vmin, float vmax,
                       float vinc, bint enabled)
    cpdef drawText(self, int x, int y, int align, text, ColorRGBA color)
    cpdef drawLine(self, float x0, float y0, float x1, float y1, float r, ColorRGBA color)
    cpdef drawRoundedRect(self, float x, float y, float w, float h, float r, ColorRGBA color)
    cpdef drawRect(self, float x, float y, float w, float h, ColorRGBA color)
    
cpdef InitGLExt()
cpdef BlendFunc(unsigned int sfactor, unsigned int dfactor)
cpdef Clear(unsigned int mask)
cpdef ClearColor(ColorRGBA col)
cpdef ClearDepth(double depth)
cpdef Color(ColorRGBA col)
cpdef Disable(unsigned int cap)
cpdef DrawArrays(unsigned int mode, int first, int count)
cpdef DrawElements(unsigned int mode, int count, int type, indices)
cpdef Enable(unsigned int cap)
cpdef LineWidth(float width)
cpdef LightModeli(int pname, int param)
cpdef LoadIdentity()
cpdef LoadMatrixd(Transform tr)
cpdef MatrixMode(unsigned int mode)
cpdef Ortho(double left, double right, double bottom, double top, double zNear, 
            double zFar)
cpdef PolygonMode(unsigned int face, unsigned int mode)
cpdef Viewport(int x, int y, int width, int height)
