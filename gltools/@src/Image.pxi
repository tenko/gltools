# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#
from ImageLib cimport *

cdef class Image:
    '''
    Image buffer containing either an RGB/RGBA 8bit
    channel image.
    
    :width: image width
    :height: image height
    :format: gl.RGB or gl.RGBA
    '''
    def __init__(self, int width, int height, int format):
        cdef int bytesPerPixel
        
        self.width = width
        self.height = height
        
        if format == GL_RGB:
            self.bytesPerPixel = 3
        elif format == GL_RGBA:
            self.bytesPerPixel = 4
        else:
            raise GLError('Image format not supported')
            
        self._buffer = <unsigned char *>malloc(width * height * self.bytesPerPixel * sizeof(unsigned char))
        if self._buffer == NULL:
            raise MemoryError('Could not allocate memory')
        
    def __dealloc__(self):
        if not self._buffer == NULL:
            free(self._buffer)
    
    def __getbuffer__(self, Py_buffer* buffer, int flags):
        self.__shape[0] = self.width * self.height * self.bytesPerPixel
        self.__strides[0] = 1
        
        buffer.buf = <void *>self._buffer
        buffer.obj = self
        buffer.len =  self.width * self.height * self.bytesPerPixel
        buffer.readonly = 0
        buffer.format = <char*>"B"
        buffer.ndim = 1
        buffer.shape = <Py_ssize_t *>&self.__shape[0]
        buffer.strides = <Py_ssize_t *>&self.__strides[0]
        buffer.suboffsets = NULL
        buffer.itemsize = sizeof(unsigned char)
        buffer.internal = NULL
        
    def __releasebuffer__(self, Py_buffer* buffer):
        pass
    
    def __len__(self):
        return self.width * self.height * self.bytesPerPixel
    
    cpdef flipY(self):
        '''
        Flip inplace the image in the vertical direction
        '''
        cdef unsigned char *pixels = self._buffer
        cdef int x, y, i, swapY, offset, swapOffset
        
        for y in range(self.height/ 2):
            swapY = self.height - y - 1
            
            for x in range(self.width):
                offset = self.bytesPerPixel * (x + y * self.width)
                swapOffset =  self.bytesPerPixel * (x + swapY * self.width)
                
                # Swap R, G and B or A of the 2 pixels
                for i in range(self.bytesPerPixel):
                    pixels[swapOffset + i], pixels[offset + i] = pixels[offset + i], pixels[swapOffset + i]
    
    cpdef writePNG(self, char *filename, int stride = 0):
        '''
        Write image to PNG file. Note that the file
        will be overwritten if not locked.
        
        :filename: image file name
        :stride: stride into buffer
        
        Raises GLError on failure.
        '''
        if not stbi_write_png(filename, self.width, self.height, self.bytesPerPixel,
                              self._buffer, stride):
            raise GLError("failed to write to PNG '%s'" % filename)
            
        
        