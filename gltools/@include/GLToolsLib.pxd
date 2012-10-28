# -*- coding: utf-8 -*-
cdef extern from "GLTools.h":
    ctypedef unsigned int GLenum
    ctypedef unsigned char GLboolean
    ctypedef unsigned int GLbitfield
    ctypedef signed char GLbyte
    ctypedef short GLshort
    ctypedef int GLint
    ctypedef int GLsizei
    ctypedef unsigned char GLubyte
    ctypedef unsigned short GLushort
    ctypedef unsigned int GLuint
    ctypedef float GLfloat
    ctypedef float GLclampf
    ctypedef double GLdouble
    ctypedef double GLclampd
    ctypedef void GLvoid
    ctypedef ssize_t GLintptr
    ctypedef ssize_t GLsizeiptr
    
    char errorMessage[256]
    int glCheck()
    
    int stbi_write_png(char *filename, int w, int h, int comp, void *data, int stride_in_bytes)
    
    int c_initText "initText"()
    int c_beginText "beginText"()
    int c_endText "endText"()
    int c_drawText "drawText"(int idx, float size, float x, float y, char *text, float *dx)

    int isGLExtLoaded
    int c_initGLExt "initGLExt"()
    
    cdef cppclass c_TextureRect2D "TextureRect2D":
        GLuint m_width
        GLuint m_height
        GLuint m_depth
        c_TextureRect2D(int width, int height, int depth, void *data)
        void blit(float x, float y)
        void copy(GLenum mode)

    cdef cppclass c_ClientBuffer "ClientBuffer":
        c_ClientBuffer(GLenum target)
        void bind()
        void unBind()
        int setDataType(GLenum type, GLenum dataType, GLenum dataTypeSize,
                        GLsizei stride, size_t pointer)
        int loadData(GLvoid *data, GLsizeiptr size, GLintptr offset, GLenum usage)
    
    cdef cppclass c_ShaderProgram "ShaderProgram":
        c_ShaderProgram()
        bint isValid()
        void begin()
        void end()
        GLint attribLocation(char *name)
        int loadUniform1i(char *name, GLint value)
        int loadUniform1f(char *name, GLfloat value)
        int loadUniform4f(char *name, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3)
        int loadUniformMatrix4vf(char *name, GLfloat *value, GLsizei count)
        int build(char *vertex_src, char *fragment_src)
        