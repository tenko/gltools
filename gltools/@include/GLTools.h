// Copyright 2012 by Runar Tenfjord, Tenko as.
// See LICENSE.txt for details on conditions.
#ifndef GLTOOLS_H
#define GLTOOLS_H
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#include <GL/glfw3.h>
#include <GL/glext.h>

#define GLEXTPROCSIZE 27
#define VERTEXBUFFERATTRIBSIZE 8

extern char errorMessage[256];
void setErrorMessage(const char *err);

// opengl error check
int glCheck();

// opengl font
extern struct sth_stash *_fonts;
int initText(void);
int beginText(void);
int endText(void);
int drawText(int idx, float size, float x, float y, const char *text, float *dx);

/* OpenGL 2.1 function pointers */
extern int isGLExtLoaded;

static PFNGLACTIVETEXTUREPROC           pglActiveTexture = NULL;
static PFNGLGENBUFFERSPROC              pglGenBuffers = NULL;
static PFNGLDELETEBUFFERSPROC           pglDeleteBuffers = NULL;
static PFNGLCREATESHADERPROC            pglCreateShader = NULL;
static PFNGLSHADERSOURCEPROC            pglShaderSource = NULL;
static PFNGLCOMPILESHADERPROC           pglCompileShader = NULL;
static PFNGLGETSHADERIVPROC             pglGetShaderiv = NULL;
static PFNGLGETSHADERINFOLOGPROC        pglGetShaderInfoLog = NULL;
static PFNGLDELETESHADERPROC            pglDeleteShader = NULL;
static PFNGLCREATEPROGRAMPROC           pglCreateProgram = NULL;
static PFNGLATTACHSHADERPROC            pglAttachShader = NULL;
static PFNGLLINKPROGRAMPROC             pglLinkProgram = NULL;
static PFNGLUSEPROGRAMPROC              pglUseProgram = NULL;
static PFNGLGETPROGRAMIVPROC            pglGetProgramiv = NULL;
static PFNGLGETPROGRAMINFOLOGPROC       pglGetProgramInfoLog = NULL;
static PFNGLDELETEPROGRAMPROC           pglDeleteProgram = NULL;
static PFNGLGETUNIFORMLOCATIONPROC      pglGetUniformLocation = NULL;
static PFNGLUNIFORM1IPROC               pglUniform1i = NULL;
static PFNGLUNIFORM1FPROC               pglUniform1f = NULL;
static PFNGLUNIFORM4FPROC               pglUniform4f = NULL;
static PFNGLUNIFORMMATRIX4FVPROC        pglUniformMatrix4fv = NULL;
static PFNGLGETATTRIBLOCATIONPROC       pglGetAttribLocation = NULL;
static PFNGLBUFFERDATAPROC              pglBufferData = NULL;
static PFNGLBINDBUFFERPROC              pglBindBuffer = NULL;
static PFNGLBUFFERSUBDATAPROC           pglBufferSubData = NULL;
static PFNGLGETBUFFERPARAMETERIVPROC    pglGetBufferParameteriv = NULL;
static PFNGLENABLEVERTEXATTRIBARRAYPROC pglEnableVertexAttribArray = NULL;
static PFNGLVERTEXATTRIBPOINTERPROC     pglVertexAttribPointer = NULL;

int initGLExt(void);

class TextureRect2D {
public:
    GLuint m_id;
    GLuint m_width;
    GLuint m_height;
    GLuint m_depth;
    TextureRect2D(int width, int height, int depth, void *data);
    ~TextureRect2D();
    void blit(float x, float y);
    void copy(GLenum mode);
};

struct ClientBufferAttrib {
    int enabled;
    GLenum type;
    GLenum dataType;
    GLint dataTypeSize;
 	GLsizei  stride;
 	const GLvoid *pointer;
};

class ClientBuffer {
public:
    GLuint m_id;
    GLenum m_target;
    bool m_loaded;
    ClientBufferAttrib m_attrib[VERTEXBUFFERATTRIBSIZE];
    
    ClientBuffer(GLenum target);
    ~ClientBuffer();
    void bind();
    void unBind();
    int setDataType(GLenum type, GLenum dataType, GLenum dataTypeSize,
                    GLsizei stride, const uintptr_t pointer);
    int loadData(const GLvoid *data, GLsizeiptr size, GLintptr offset = 0,
                 GLenum usage = GL_STATIC_DRAW);
};

class ShaderProgram {
public:
    GLuint m_id;
    GLuint m_vertex_id;
    GLuint m_fragment_id;
    ShaderProgram();
    ~ShaderProgram();
    bool isValid();
    void begin();
    void end();
    GLint attribLocation(const GLchar *name);
    int loadUniform1i(const char *name, const GLint value);
    int loadUniform1f(const char *name, const GLfloat value);
    int loadUniform4f(const char *name, const GLfloat v0, const GLfloat v1,
                      const GLfloat v2, const GLfloat v3);
    int loadUniformMatrix4vf(const char *name, const GLfloat *value, GLsizei count = 1);
    int build(const char* vertex_src = NULL, const char* fragment_src = NULL);
private:
    static const char* default_vertex_shader;
    static const char* default_fragment_shader;
};
#endif