# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#

cdef class TextureRect2D:
    '''
    Abstraction of OpenGL 2d rectangular texture used
    for keeping a buffer of the screen content.
    '''
    def __init__(self, int width, int height, int depth = 3):
        self.thisptr = new c_TextureRect2D(width, height, depth, NULL)
        if not glCheck():
            raise GLError(errorMessage)
        
    def __dealloc__(self):
        cdef c_TextureRect2D *tmp
        
        if self.thisptr != NULL:
            tmp = <c_TextureRect2D *>self.thisptr
            del tmp
    
    def __str__(self):
        return "TextureRect2D%s" % repr(self)
    
    def __repr__(self):
        cdef c_TextureRect2D *tex = <c_TextureRect2D *>self.thisptr
        args = tex.m_width, tex.m_height, tex.m_depth
        return "(width = %d, height = %d, depth = %d)" % args
    
    cpdef blit(self, float x = 0., float y = 0.):
        '''
        Blit content of the texture to the back buffer.
        '''
        cdef c_TextureRect2D *tex = <c_TextureRect2D *>self.thisptr
        tex.blit(x, y)
    
    cpdef copy(self, int mode = GL_BACK):
        '''
        Copy buffer content to texture.
        '''
        cdef c_TextureRect2D *tex = <c_TextureRect2D *>self.thisptr
        tex.copy(mode)
    
    @classmethod
    def fromImage(cls, Image img):
        '''
        Create texture from existing image
        '''
        cpdef TextureRect2D ret = TextureRect2D.__new__(TextureRect2D)
        ret.thisptr = new c_TextureRect2D(img.width, img.height, img.bytesPerPixel, img._buffer)
        return ret