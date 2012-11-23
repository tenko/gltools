#include "GLTools.h"
#include "fontstash.h"
#include <Python.h>

// error handling
char errorMessage[256];

void setErrorMessage(const char *err) {
    strncpy(errorMessage, err, 255);
}

int glCheck() {
    switch(glGetError()) {
        case GL_NO_ERROR:
			return 1;
        
		case GL_INVALID_ENUM:
			setErrorMessage("GL_INVALID_ENUM");
			break;
        
        case GL_INVALID_VALUE:
			setErrorMessage("GL_INVALID_VALUE");
			break;
 
		case GL_INVALID_OPERATION:
			setErrorMessage("GL_INVALID_OPERATION");
			break;
 
		case GL_INVALID_FRAMEBUFFER_OPERATION:
			setErrorMessage("GL_INVALID_FRAMEBUFFER_OPERATION");
			break;
        
        case GL_OUT_OF_MEMORY:
			setErrorMessage("GL_OUT_OF_MEMORY");
			break;
 
		default:
			setErrorMessage("GL_UNKNOWN");
			break;
    }
    return 0;
}
    
// load font
struct sth_stash *_fonts;

void destroyFont(void)
{
    sth_delete(_fonts);
    _fonts = NULL;
}

int initFont(void)
{
    _fonts = sth_create(512,512);
    if (!_fonts) {
        setErrorMessage("failed to initialize font structure");
        printf("failed to initialize font structure\n");
        return 0;
    }
    
    atexit(destroyFont);
    
    if (!sth_add_font(_fonts, 0, NULL)) {
        setErrorMessage("failed to initialize default font");
        printf("failed to initialize default font\n");
        return 0;
    }
    return 1;
}

int initText(void)
{
    if (!_fonts) {
        if (!initFont())
            return 0;
    }
    return 1;
}

int beginText(void)
{
    if (!_fonts) {
        if (!initFont())
            return 0;
    }
    sth_begin_draw(_fonts);
    return 1;
}

int endText(void)
{
    if (!_fonts) {
        if (!initFont())
            return 0;
    }
    sth_end_draw(_fonts);
    return 1;
}

int drawText(int idx, float size, float x, float y, const char *text, float *dx)
{
    if (!_fonts) {
        if (!initFont())
            return 0;
    }
    if (!sth_draw_text(_fonts, idx, size, x, y, text, dx)) {
        setErrorMessage("failed to draw text string");
        return 0;
    }
        
    return 1;
}

// opengl 2.1 extensions
#define GLEXTPROCSIZE 28
int isGLExtLoaded = 0;

int initGLExt(void)
{
    // OpenGL 2.1 functions
    int status = 0;
    
    pglActiveTexture = (PFNGLACTIVETEXTUREPROC) glfwGetProcAddress("glActiveTexture");
    if (pglActiveTexture) status++;
    
    pglCreateShader = (PFNGLCREATESHADERPROC) glfwGetProcAddress("glCreateShader");
    if (pglCreateShader) status++;
    
    pglShaderSource = (PFNGLSHADERSOURCEPROC) glfwGetProcAddress("glShaderSource");
    if (pglShaderSource) status++;
    
    pglCompileShader = (PFNGLCOMPILESHADERPROC) glfwGetProcAddress("glCompileShader");
    if (pglCompileShader) status++;
    
    pglGetShaderiv = (PFNGLGETSHADERIVPROC) glfwGetProcAddress("glGetShaderiv");
    if (pglGetShaderiv) status++;
    
    pglGetShaderInfoLog = (PFNGLGETSHADERINFOLOGPROC) glfwGetProcAddress("glGetShaderInfoLog");
    if (pglGetShaderInfoLog) status++;
    
    pglDeleteShader = (PFNGLDELETESHADERPROC) glfwGetProcAddress("glDeleteShader");
    if (pglDeleteShader) status++;
    
    pglCreateProgram = (PFNGLCREATEPROGRAMPROC) glfwGetProcAddress("glCreateProgram");
    if (pglCreateProgram) status++;
    
    pglAttachShader = (PFNGLATTACHSHADERPROC) glfwGetProcAddress("glAttachShader");
    if (pglAttachShader) status++;
    
    pglLinkProgram = (PFNGLLINKPROGRAMPROC) glfwGetProcAddress("glLinkProgram");
    if (pglLinkProgram) status++;
    
    pglUseProgram = (PFNGLUSEPROGRAMPROC) glfwGetProcAddress("glUseProgram");
    if (pglUseProgram) status++;
    
    pglGetProgramiv = (PFNGLGETPROGRAMIVPROC) glfwGetProcAddress("glGetProgramiv");
    if (pglGetProgramiv) status++;
    
    pglGetProgramInfoLog = (PFNGLGETPROGRAMINFOLOGPROC) glfwGetProcAddress("glGetProgramInfoLog");
    if (pglGetProgramInfoLog) status++;
    
    pglDeleteProgram = (PFNGLDELETEPROGRAMPROC) glfwGetProcAddress("glDeleteProgram");
    if (pglDeleteProgram) status++;
    
    pglGetUniformLocation = (PFNGLGETUNIFORMLOCATIONPROC) glfwGetProcAddress("glGetUniformLocation");
    if (pglGetUniformLocation) status++;
    
    pglUniform1i = (PFNGLUNIFORM1IPROC) glfwGetProcAddress("glUniform1i");
    if (pglUniform1i) status++;
    
    pglUniform1f = (PFNGLUNIFORM1FPROC) glfwGetProcAddress("glUniform1f");
    if (pglUniform1f) status++;
    
    pglUniform4f = (PFNGLUNIFORM4FPROC) glfwGetProcAddress("glUniform4f");
    if (pglUniform4f) status++;
    
    pglUniformMatrix4fv = (PFNGLUNIFORMMATRIX4FVPROC) glfwGetProcAddress("glUniformMatrix4fv");
    if (pglUniformMatrix4fv) status++;
    
    pglGetAttribLocation = (PFNGLGETATTRIBLOCATIONPROC) glfwGetProcAddress("glGetAttribLocation");
    if (pglGetAttribLocation) status++;
    
    pglGenBuffers = (PFNGLGENBUFFERSPROC) glfwGetProcAddress("glGenBuffers");
    if (pglGenBuffers) status++;
    
    pglDeleteBuffers = (PFNGLDELETEBUFFERSPROC) glfwGetProcAddress("glDeleteBuffers");
    if (pglDeleteBuffers) status++;
    
    pglBindBuffer = (PFNGLBINDBUFFERPROC) glfwGetProcAddress("glBindBuffer");
    if (pglBindBuffer) status++;
    
    pglBufferData = (PFNGLBUFFERDATAPROC) glfwGetProcAddress("glBufferData");
    if (pglBufferData) status++;
    
    pglBufferSubData = (PFNGLBUFFERSUBDATAPROC) glfwGetProcAddress("glBufferSubData");
    if (pglBufferSubData) status++;
    
    pglGetBufferParameteriv = (PFNGLGETBUFFERPARAMETERIVPROC) glfwGetProcAddress("glGetBufferParameteriv");
    if (pglGetBufferParameteriv) status++;
    
    pglEnableVertexAttribArray = (PFNGLENABLEVERTEXATTRIBARRAYPROC) glfwGetProcAddress("glEnableVertexAttribArray");
    if (pglEnableVertexAttribArray) status++;
    
    pglVertexAttribPointer = (PFNGLVERTEXATTRIBPOINTERPROC) glfwGetProcAddress("glVertexAttribPointer");
    if (pglVertexAttribPointer) status++;
    
    if (status != GLEXTPROCSIZE) {
        setErrorMessage("Failed to load OpenGL 2.1 function pointers");
        return 0;
    }
    isGLExtLoaded = 1;
    return 1;
}

// opengl texture rectangle
TextureRect2D::TextureRect2D(int width, int height, int depth, void *data = NULL) {
    GLint iformat, format;
    
    m_width = width;
    m_height = height;
    m_depth = depth;
    
    if (depth == 4) {
        iformat = GL_RGBA8;
        format = GL_RGBA;
    } else {
        iformat = GL_RGB8;
        format = GL_RGB;
    }
    
    glGenTextures(1, &m_id);
    glBindTexture(GL_TEXTURE_RECTANGLE, m_id);
    
    
    glTexParameteri(GL_TEXTURE_RECTANGLE, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_RECTANGLE, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
	
	glTexParameteri(GL_TEXTURE_RECTANGLE, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
	glTexParameteri(GL_TEXTURE_RECTANGLE, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    
	glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
    
    if (!data) {
        char *colorBits = new char[width * height * depth];
        memset(colorBits, 0, width * height * depth);
        glTexImage2D(GL_TEXTURE_RECTANGLE, 0, format, width, height, 0,
                     format, GL_UNSIGNED_BYTE, colorBits);
        delete[] colorBits;
    } else {
        glTexImage2D(GL_TEXTURE_RECTANGLE, 0, format, width, height, 0,
                     format, GL_UNSIGNED_BYTE, data);
    }
    
    glBindTexture(GL_TEXTURE_RECTANGLE, 0);
}

TextureRect2D::~TextureRect2D() {
    glDeleteTextures(1, &m_id);
}

void TextureRect2D::blit(float x, float y) {
    glEnable(GL_TEXTURE_RECTANGLE);
    pglActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_RECTANGLE, m_id);
    glColor3ub(255,255,255);
    
    glBegin(GL_QUADS);
    glTexCoord2f(0, 0);
    glVertex3f(x, y, 0);
    glTexCoord2f(m_width, 0);
    glVertex3f(x + m_width, y, 0);
    glTexCoord2f(m_width, m_height);
    glVertex3f(x + m_width, y + m_height, 0);
    glTexCoord2f(0, m_height);
    glVertex3f(x, y + m_height, 0);
    glEnd();
    
    glBindTexture(GL_TEXTURE_RECTANGLE, 0);
    glDisable(GL_TEXTURE_RECTANGLE);
}

void TextureRect2D::copy(GLenum mode = GL_BACK) {
    glReadBuffer(mode);
    glEnable(GL_TEXTURE_RECTANGLE);
    pglActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_RECTANGLE, m_id);
    glCopyTexSubImage2D(GL_TEXTURE_RECTANGLE,0,0,0,0,0,m_width, m_height);
    glBindTexture(GL_TEXTURE_RECTANGLE, 0);
    glDisable(GL_TEXTURE_RECTANGLE);
}

// opengl buffer interface
ClientBuffer::ClientBuffer(GLenum target = GL_ARRAY_BUFFER) { 
    pglGenBuffers(1, &m_id);
    m_target = target;
    m_loaded = false;
    for (unsigned i = 0; i < VERTEXBUFFERATTRIBSIZE; i++) {
        m_attrib[i].enabled = 0;
    }
}

ClientBuffer::~ClientBuffer() {
    pglDeleteBuffers(1, &m_id);
}

void ClientBuffer::bind() { 
    pglBindBuffer(m_target, m_id);
    if (m_target != GL_ARRAY_BUFFER)
        return;
    
    for (unsigned i = 0; i < VERTEXBUFFERATTRIBSIZE; i++) {
        ClientBufferAttrib *attr = &m_attrib[i];
        
        if(m_attrib[i].enabled) {
            glEnableClientState(attr->type);
            if (attr->type == GL_VERTEX_ARRAY) {
                glVertexPointer(attr->dataTypeSize, attr->dataType,
                                attr->stride, attr->pointer);
                
            } else if (attr->type == GL_NORMAL_ARRAY) {
                glNormalPointer(attr->dataType, attr->stride, attr->pointer);
                
            } else if (attr->type == GL_COLOR_ARRAY) {
                glColorPointer(attr->dataTypeSize, attr->dataType,
                               attr->stride, attr->pointer);
            
            }
        }
    }
}

void ClientBuffer::unBind() {
    if (m_target == GL_ARRAY_BUFFER) {
        for (unsigned i = 0; i < VERTEXBUFFERATTRIBSIZE; i++) {
            if(m_attrib[i].enabled) {
                glDisableClientState(m_attrib[i].type);
            }
        }
    } else {
        glDisableClientState(GL_INDEX_ARRAY);
    }
    pglBindBuffer(m_target, 0);
}

int ClientBuffer::setDataType(GLenum type, GLenum dataType, GLenum dataTypeSize,
                              GLsizei stride, const uintptr_t pointer) {
    int idx;
    switch (type)
    {
        case GL_VERTEX_ARRAY:
        {
            idx = 0; 
            break;
        }
        case GL_COLOR_ARRAY:
        {
            idx = 1;
            break;
        }
        case GL_NORMAL_ARRAY:
        {
            idx = 2; 
            break;
        }
        default:
        {
            setErrorMessage("Failed to allocate memory for buffer");
            return 0;
        }
    }
    m_attrib[idx].enabled = 1;
    m_attrib[idx].type = type;
    m_attrib[idx].dataType = dataType;
    m_attrib[idx].dataTypeSize = dataTypeSize;
    m_attrib[idx].stride = stride;
    m_attrib[idx].pointer = (void*)pointer;
    return 1;
}

int ClientBuffer::loadData(const GLvoid *data, GLsizeiptr size,
                           GLintptr offset, GLenum usage) {
    int bufferSize = 0;
    if (!m_loaded) {
        pglBindBuffer(m_target, m_id);
        pglBufferData(m_target, size, data, usage);
        pglGetBufferParameteriv(m_target, GL_BUFFER_SIZE_ARB, &bufferSize);
        pglBindBuffer(m_target, 0);
        if (bufferSize != size) {
            setErrorMessage("Failed to allocate memory for buffer");
            return 0;
        }
        m_loaded = true;
    } else {
        pglBindBuffer(m_target, m_id);
        pglBufferSubData(m_target, offset, size, data);
        pglBindBuffer(m_target, 0);
    }
    return 1;
}

// opengl shader program interface
ShaderProgram::ShaderProgram() { 
    m_id = 0u;
    m_vertex_id = 0u;
    m_fragment_id = 0u;
}

ShaderProgram::~ShaderProgram() {
    if (m_vertex_id) pglDeleteShader(m_vertex_id);
    if (m_fragment_id) pglDeleteShader(m_fragment_id);
    if (m_id) pglDeleteProgram(m_id);
}

bool ShaderProgram::isValid() {
    return (m_id != 0u && m_vertex_id != 0u && m_fragment_id != 0u);
}

void ShaderProgram::begin() {
    pglUseProgram(m_id);
}

void ShaderProgram::end() {
    pglUseProgram(0);
}

GLint ShaderProgram::attribLocation(const GLchar *name) {
    GLint uloc = pglGetAttribLocation(m_id, name);
    if (uloc == -1) {
        setErrorMessage("Failed to find attrib variable");
        return -1;
    }
    return uloc;
}

int ShaderProgram::loadUniform1i(const char *name, const GLint value) {
    GLint uloc = pglGetUniformLocation(m_id, name);
    if (uloc == -1) {
        setErrorMessage("Failed to find uniform variable");
        return 0;
    }
    pglUniform1i(uloc, value);
    return 1;
}

int ShaderProgram::loadUniform1f(const char *name, const GLfloat value) {
    GLint uloc = pglGetUniformLocation(m_id, name);
    if (uloc == -1) {
        setErrorMessage("Failed to find uniform variable");
        return 0;
    }
    pglUniform1f(uloc, value);
    return 1;
}

int ShaderProgram::loadUniform4f(const char *name, const GLfloat v0, const GLfloat v1,
                                 const GLfloat v2, const GLfloat v3) {
    GLint uloc = pglGetUniformLocation(m_id, name);
    if (uloc == -1) {
        setErrorMessage("Failed to find uniform variable");
        return 0;
    }
    pglUniform4f(uloc, v0, v1, v2, v3);
    return 1;
}

int ShaderProgram::loadUniformMatrix4vf(const char *name, const GLfloat *value,
                                        GLsizei count) {
    GLint uloc = pglGetUniformLocation(m_id, name);
    if (uloc == -1) {
        setErrorMessage("Failed to find uniform variable");
        return 0;
    }
    pglUniformMatrix4fv(uloc, count, GL_FALSE, value);
    return 1;
}

int ShaderProgram::build(const char* vertex_src,
                         const char* fragment_src) {
    GLint status;
    GLsizei log_length;
    char info_log[256];
    
    if (!vertex_src) vertex_src = default_vertex_shader;
    if (!fragment_src) fragment_src = default_fragment_shader;
    
    // build vertex shader
    m_vertex_id = pglCreateShader(GL_VERTEX_SHADER);
    if (m_vertex_id == 0u) {
        setErrorMessage("Failed to create vertex shader");
        return 0;
    }
    pglShaderSource(m_vertex_id, 1, (const GLchar**)&vertex_src, NULL);
    pglCompileShader(m_vertex_id);
    pglGetShaderiv(m_vertex_id, GL_COMPILE_STATUS, &status);
    if (status != GL_TRUE)
    {
        pglGetShaderInfoLog(m_vertex_id, sizeof(info_log), &log_length,info_log);
        setErrorMessage(info_log);
        return 0;
    }
    
    // build fragment shader
    m_fragment_id = pglCreateShader(GL_FRAGMENT_SHADER);
    if (m_fragment_id == 0u) {
        setErrorMessage("Failed to create fragment shader");
        return 0;
    }
    pglShaderSource(m_fragment_id, 1, (const GLchar**)&fragment_src, NULL);
    pglCompileShader(m_fragment_id);
    pglGetShaderiv(m_fragment_id, GL_COMPILE_STATUS, &status);
    if (status != GL_TRUE)
    {
        pglGetShaderInfoLog(m_fragment_id, sizeof(info_log), &log_length,info_log);
        setErrorMessage(info_log);
        return 0;
    }
    
    // create program and link shaders
    m_id = pglCreateProgram();
    if (m_id == 0u) {
        setErrorMessage("Failed to create program");
        return 0;
    }
    
    pglAttachShader(m_id, m_vertex_id);
    pglAttachShader(m_id, m_fragment_id);
    pglLinkProgram(m_id);
    pglGetProgramiv(m_id, GL_LINK_STATUS, &status);
    if (status != GL_TRUE)
    {
        pglGetShaderInfoLog(m_id, 8192, &log_length,info_log);
        setErrorMessage(info_log);
        return 0;
    }
    return 1;
}

const char* ShaderProgram::default_vertex_shader =
"#version 130\n"
"void main()\n"
"{\n"
"   gl_FrontColor = gl_Color;\n"
"   gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;\n"
"}\n";

const char* ShaderProgram::default_fragment_shader =
"#version 130\n"
"void main()\n"
"{\n"
"    gl_FragColor = gl_Color;\n"
"}\n";

