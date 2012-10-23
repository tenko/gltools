# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#

cdef class ClientBuffer:
    '''
    Abstraction of OpenGL vertex buffer
    '''
    def __init__(self, target = GL_ARRAY_BUFFER):
        if not isGLExtLoaded:
            raise GLError('OpenGL 2.1 function pointers not found')
        
        self.thisptr = new c_ClientBuffer(target)
    
    def __dealloc__(self):
        cdef c_ClientBuffer *tmp
        
        if self.thisptr != NULL:
            tmp = <c_ClientBuffer *>self.thisptr
            del tmp
    
    def __str__(self):
        return "ClientBuffer%s" % repr(self)
    
    def __repr__(self):
        return "()"
        
    cpdef bind(self):
        cdef c_ClientBuffer *buf = <c_ClientBuffer *>self.thisptr
        buf.bind()
        
    cpdef unBind(self):
        cdef c_ClientBuffer *buf = <c_ClientBuffer *>self.thisptr
        buf.unBind()
    
    cpdef setDataType(self, int type, int dataType, int dataTypeSize,
                      int stride, size_t pointer):
        '''
        Set datatye for data in buffer. Pointer is an integer with an
        offset into the buffer with optional stride.
        '''
        cdef c_ClientBuffer *buf = <c_ClientBuffer *>self.thisptr
        
        if not buf.setDataType(type, dataType, dataTypeSize, stride, pointer):
            raise GLError(errorMessage)
    
    cdef cloadData(self, void *data, ssize_t size, ssize_t offset, int usage):
        cdef c_ClientBuffer *buf = <c_ClientBuffer *>self.thisptr
        if not buf.loadData(data, size, offset, usage):
            raise GLError(errorMessage)
            
    cpdef loadData(self, data, ssize_t size, ssize_t offset = 0, int usage = GL_STATIC_DRAW):
        '''
        Upload data to client side buffer. Passing None
        for data will reserve capacity.
        '''
        if data is None:
            self.cloadData(NULL, size, offset, usage)
        else:
            self.cloadData(getVoidPtr(data), size, offset, usage)
