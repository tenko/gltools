# -*- coding: utf-8 -*-
from imguiLib cimport *

cdef class UI:
    def __init__(self):
        self.scrollIdx = 0
        imguiRenderGLInit()
        
        if not c_initText():
            raise GLError(errorMessage)
    
    cpdef bint anyActive(self):
        return imguiAnyActive()
        
    cpdef flush(self):
        self.scrollIdx = 0
        imguiRenderGLDraw()
    
    cpdef beginFrame(self, int mx, int my, char mbut, int scroll):
        if mbut == GLFW_MOUSE_BUTTON_LEFT:
            mbut = IMGUI_MBUT_LEFT
        elif mbut == GLFW_MOUSE_BUTTON_RIGHT:
            mbut = IMGUI_MBUT_RIGHT
        elif mbut == -1:
            mbut = 0
            
        imguiBeginFrame(mx, my, mbut, scroll)
    
    cpdef endFrame(self):
        imguiEndFrame()
        
    cpdef bint beginScrollArea(self, name, int x, int y, int w, int h):
        cdef char *c_name
        cdef bint ret
        
        bytetext = unicode(name).encode('UTF-8','ignore')
        c_name = bytetext
        
        ret = imguiBeginScrollArea(c_name, x, y, w, h, &self.scroll[self.scrollIdx])
        self.scrollIdx += 1
        if self.scrollIdx >= 10:
            raise GLError('Only 10 scrool areas supported')
        
        return ret
        
    cpdef endScrollArea(self):
        imguiEndScrollArea()

    cpdef indent(self):
        imguiIndent()
        
    cpdef unindent(self):
        imguiUnindent()
        
    cpdef separator(self):
        imguiSeparator()

    cpdef separatorLine(self):
        imguiSeparatorLine()
        
    cpdef bint button(self, text, bint enabled):
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
    
        return imguiButton(c_text, enabled)

    cpdef bint item(self, text, bint enabled):
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        return imguiItem(c_text, enabled)


    cpdef bint check(self, text, bint checked, bint enabled):
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        return imguiCheck(c_text, checked, enabled)


    cpdef bint collapse(self, text, char* subtext, bint checked, bint enabled):
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        return imguiCollapse(c_text, subtext, checked, enabled)

    cpdef label(self, text):
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        imguiLabel(c_text)

    cpdef value(self, text):
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        imguiValue(c_text)

    cpdef float slider(self, text, float val, float vmin, float vmax,
                       float vinc, bint enabled):
        cdef float c_val = val
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        imguiSlider(c_text, &c_val, vmin, vmax, vinc, enabled)
        return c_val

    cpdef drawText(self, int x, int y, int align, text, ColorRGBA color):
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        imguiDrawText(x, y, align, c_text, color.toInt())


    cpdef drawLine(self, float x0, float y0, float x1, float y1, float r, ColorRGBA color):
        imguiDrawLine(x0, y0, x1, y1, r, color.toInt())


    cpdef drawRoundedRect(self, float x, float y, float w, float h, float r, ColorRGBA color):
        imguiDrawRoundedRect(x, y, w, h, r, color.toInt())

    cpdef drawRect(self, float x, float y, float w, float h, ColorRGBA color):
        imguiDrawRect(x, y, w, h, color.toInt())