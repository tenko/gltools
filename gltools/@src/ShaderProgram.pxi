# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#
cdef class ShaderProgram:
    def __init__(self):
        if not isGLExtLoaded:
            raise GLError('OpenGL 2.1 function pointers not found')
        self.thisptr = new c_ShaderProgram()
    
    def __dealloc__(self):
        cdef c_ShaderProgram *tmp
        
        if self.thisptr != NULL:
            tmp = <c_ShaderProgram *>self.thisptr
            del tmp
    
    def __str__(self):
        return "ShaderProgram%s" % repr(self)
    
    def __repr__(self):
        return "()"
    
    cpdef bint isValid(self):
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        return prog.isValid()
    
    cpdef begin(self):
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        prog.begin()
    
    cpdef end(self):
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        prog.end()
    
    cpdef loadUniform1i(self, char *name, int value):
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        if not prog.loadUniform1i(name, value):
            raise GLError(errorMessage)
    
    cpdef loadUniform1f(self, char *name, float value):
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        if not prog.loadUniform1f(name, value):
            raise GLError(errorMessage)
    
    cpdef loadUniform4f(self, char *name, float v0, float v1, float v2, float v3):
        print name, v0, v1, v2, v3
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        if not prog.loadUniform4f(name, v0, v1, v2, v3):
            raise GLError(errorMessage)
    
    cpdef loadUniformMatrix4vf(self, char *name, float [::1] value, int count = 1):
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        if not prog.loadUniformMatrix4vf(name, &value[0], count):
            raise GLError(errorMessage)
    
    cpdef build(self, vertex_src = None, fragment_src = None):
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        cdef int ret
        
        if vertex_src is None and fragment_src is None:
            ret = prog.build(NULL,NULL)
        else:
            ret = prog.build(vertex_src, fragment_src)
        
        if not ret:
            raise GLError(errorMessage)