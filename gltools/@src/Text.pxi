# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#
cpdef BeginText():
    if not c_beginText():
        raise GLError(errorMessage)

cpdef float DrawText(size, float x, float y, text):
    cdef float dx
    cdef char *c_str
        
    bytetext = unicode(text).encode('UTF-8','ignore')
    c_str = bytetext
    
    if not c_drawText(0, size, x, y, c_str, &dx):
        raise GLError(errorMessage)
    
    return dx

cpdef EndText():
    if not c_endText():
        raise GLError(errorMessage)