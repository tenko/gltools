# -*- coding: utf-8 -*-
from imguiLib cimport *

cdef class UI:
    '''
    Draw UI elements
    '''
    def __init__(self):
        self.scrollIdx = 0
        imguiRenderGLInit()
        
        if not c_initText():
            raise GLError(errorMessage)
    
    cpdef bint anyActive(self):
        '''
        Return true if any ui element is active
        '''
        return imguiAnyActive()
        
    cpdef flush(self):
        '''
        Flush drawing pipeline
        '''
        self.scrollIdx = 0
        imguiRenderGLDraw()
    
    cpdef beginFrame(self, int mx, int my, char mbut, int scroll):
        '''
        Start frame
        '''
        if mbut == GLFW_MOUSE_BUTTON_LEFT:
            mbut = IMGUI_MBUT_LEFT
        elif mbut == GLFW_MOUSE_BUTTON_RIGHT:
            mbut = IMGUI_MBUT_RIGHT
        elif mbut == -1:
            mbut = 0
            
        imguiBeginFrame(mx, my, mbut, scroll)
    
    cpdef endFrame(self):
        '''
        End frame
        '''
        imguiEndFrame()
        
    cpdef bint beginScrollArea(self, name, int x, int y, int w, int h):
        '''
        Begin scroll area
        
        Up to 10 scroll areas can be used, but not nested.
        '''
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
        '''
        End scroll area
        '''
        imguiEndScrollArea()
    
    cpdef bint beginArea(self, name, int x, int y, int w, int h):
        '''
        Begin fixed area
        '''
        cdef char *c_name
        
        bytetext = unicode(name).encode('UTF-8','ignore')
        c_name = bytetext
        
        return imguiBeginArea(c_name, x, y, w, h)
        
    cpdef endArea(self):
        '''
        End fixed area
        '''
        imguiEndArea()
        
    cpdef indent(self):
        '''
        Indent current x position
        '''
        imguiIndent()
        
    cpdef unindent(self):
        '''
        Unindent current x position
        '''
        imguiUnindent()
        
    cpdef separator(self):
        '''
        Add horisontal separator space
        '''
        imguiSeparator()

    cpdef separatorLine(self):
        '''
        Add horisontal separator line
        '''
        imguiSeparatorLine()
        
    cpdef bint button(self, text, bint enabled, int x = -1, int y = -1,
                      int w = -1, int h = -1):
        '''
        Button element
        '''
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
    
        return imguiButton(c_text, enabled, x, y, w, h)

    cpdef bint item(self, text, bint enabled):
        '''
        Item element
        '''
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        return imguiItem(c_text, enabled)


    cpdef bint check(self, text, bint checked, bint enabled):
        '''
        Check box element
        '''
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        return imguiCheck(c_text, checked, enabled)


    cpdef bint collapse(self, text, subtext, bint checked, bint enabled):
        '''
        Collapse element
        '''
        cdef char *c_text, *c_subtext
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        bytetext = unicode(subtext).encode('UTF-8','ignore')
        c_subtext = bytetext
        
        return imguiCollapse(c_text, c_subtext, checked, enabled)

    cpdef label(self, text):
        '''
        Text label (left aligned)
        '''
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        imguiLabel(c_text)

    cpdef value(self, text):
        '''
        Text label (right aligned)
        '''
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        imguiValue(c_text)

    cpdef float slider(self, text, float val, float vmin, float vmax,
                       float vinc, bint enabled):
        '''
        Horisontal slider
        '''
        cdef float c_val = val
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        imguiSlider(c_text, &c_val, vmin, vmax, vinc, enabled)
        return c_val

    cpdef drawText(self, int x, int y, int align, text, ColorRGBA color):
        '''
        Draw text
        '''
        cdef char *c_text
        
        bytetext = unicode(text).encode('UTF-8','ignore')
        c_text = bytetext
        
        imguiDrawText(x, y, align, c_text, color.toInt())


    cpdef drawLine(self, float x0, float y0, float x1, float y1, float r, ColorRGBA color):
        '''
        Draw single line
        '''
        imguiDrawLine(x0, y0, x1, y1, r, color.toInt())


    cpdef drawRoundedRect(self, float x, float y, float w, float h, float r, ColorRGBA color):
        '''
        Draw rounded rectangle
        '''
        imguiDrawRoundedRect(x, y, w, h, r, color.toInt())

    cpdef drawRect(self, float x, float y, float w, float h, ColorRGBA color):
        '''
        Draw rectangle
        '''
        imguiDrawRect(x, y, w, h, color.toInt())