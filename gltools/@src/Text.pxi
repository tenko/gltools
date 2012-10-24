# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#
cpdef BeginText():
    '''
    Start text drawing
    '''
    if not c_beginText():
        raise GLError(errorMessage)

cpdef float DrawText(size, float x, float y, text):
    '''
    Draw text
    
    :size: font size
    :x: x coordinate
    :y: y coordinate
    :text: text (must encode to UTF-8)
    '''
    cdef float dx
    cdef char *c_str
        
    bytetext = unicode(text).encode('UTF-8','ignore')
    c_str = bytetext
    
    if not c_drawText(0, size, x, y, c_str, &dx):
        raise GLError(errorMessage)
    
    return dx

cpdef EndText():
    '''
    Finish text drawing. This will flush any pending text
    drawing operations.
    '''
    if not c_endText():
        raise GLError(errorMessage)