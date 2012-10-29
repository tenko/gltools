# -*- coding: utf-8 -*-

cdef extern from "GL/glfw3.h":
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
    
    void glBlendFunc(GLenum sfactor, GLenum dfactor)
    void glClear(GLbitfield mask)
    void glClearColor(GLclampf red, GLclampf green, GLclampf blue, GLclampf alpha)
    void glClearDepth(GLclampd depth)
    void glColor4ub(GLubyte red, GLubyte green, GLubyte blue, GLubyte alpha )
    void glDisable(GLenum cap)
    void glDrawArrays(GLenum mode, GLint first, GLsizei count)
    void glDrawElements(GLenum mode, GLsizei count, GLenum type, GLvoid *indices)
    void glEnable(GLenum cap)
    void glGetIntegerv(GLenum pname, GLint *params)
    void glHint(GLenum target, GLenum mode)
    void glLineWidth(GLfloat width)
    void glLightf(GLenum light, GLenum pname, GLfloat param)
    void glLightfv(GLenum light, GLenum pname, GLfloat *params )
    void glLightModeli(GLenum pname, GLint param)
    void glLightModelfv(GLenum pname, GLfloat *params)
    void glLoadIdentity()
    void glLoadMatrixd(GLdouble *m)
    void glMaterialfv(GLenum face, GLenum pname, GLfloat *params)
    void glMatrixMode(GLenum mode)
    void glOrtho(GLdouble left, GLdouble right, GLdouble bottom, GLdouble top, GLdouble zNear, GLdouble zFar)
    void glPixelStorei(GLenum pname, GLint param)
    void glPolygonMode(GLenum face, GLenum mode)
    void glPolygonOffset(GLfloat factor, GLfloat units)
    void glReadPixels(GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid *pixels)
    void glViewport(GLint x, GLint y, GLsizei width, GLsizei height)
    
    cdef enum:
        # Boolean values
        GL_FALSE
        GL_TRUE

        # DataType
        GL_BYTE
        GL_UNSIGNED_BYTE
        GL_SHORT
        GL_UNSIGNED_SHORT
        GL_INT
        GL_UNSIGNED_INT
        GL_FLOAT
        GL_2_BYTES
        GL_3_BYTES
        GL_4_BYTES
        GL_DOUBLE
        
        # BeginMode
        GL_POINTS
        GL_LINES
        GL_LINE_LOOP
        GL_LINE_STRIP
        GL_TRIANGLES
        GL_TRIANGLE_STRIP
        GL_TRIANGLE_FAN
        GL_QUADS
        GL_QUAD_STRIP
        GL_POLYGON
        
        # AlphaFunction
        GL_NEVER
        GL_LESS
        GL_EQUAL
        GL_LEQUAL
        GL_GREATER
        GL_NOTEQUAL
        GL_GEQUAL
        GL_ALWAYS

        # AttribMask
        GL_CURRENT_BIT
        GL_POINT_BIT
        GL_LINE_BIT
        GL_POLYGON_BIT
        GL_POLYGON_STIPPLE_BIT
        GL_PIXEL_MODE_BIT
        GL_LIGHTING_BIT
        GL_FOG_BIT
        GL_DEPTH_BUFFER_BIT
        GL_ACCUM_BUFFER_BIT
        GL_STENCIL_BUFFER_BIT
        GL_VIEWPORT_BIT
        GL_TRANSFORM_BIT
        GL_ENABLE_BIT
        GL_COLOR_BUFFER_BIT
        GL_HINT_BIT
        GL_EVAL_BIT
        GL_LIST_BIT
        GL_TEXTURE_BIT
        GL_SCISSOR_BIT
        GL_ALL_ATTRIB_BITS
        
        # Vertex Arrays
        GL_VERTEX_ARRAY
        GL_NORMAL_ARRAY
        GL_COLOR_ARRAY
        GL_INDEX_ARRAY
        GL_TEXTURE_COORD_ARRAY
        GL_EDGE_FLAG_ARRAY

        # BlendingFactorDest
        GL_ZERO
        GL_ONE
        GL_SRC_COLOR
        GL_ONE_MINUS_SRC_COLOR
        GL_SRC_ALPHA
        GL_ONE_MINUS_SRC_ALPHA
        GL_DST_ALPHA
        GL_ONE_MINUS_DST_ALPHA

        # BlendingFactorSrc
        GL_DST_COLOR
        GL_ONE_MINUS_DST_COLOR
        GL_SRC_ALPHA_SATURATE

        # DrawBufferMode
        GL_NONE
        GL_FRONT_LEFT
        GL_FRONT_RIGHT
        GL_BACK_LEFT
        GL_BACK_RIGHT
        GL_FRONT
        GL_BACK
        GL_LEFT
        GL_RIGHT
        GL_FRONT_AND_BACK
        GL_AUX0
        GL_AUX1
        GL_AUX2
        GL_AUX3
        GL_CW
        GL_CCW

        # ErrorCode
        GL_NO_ERROR
        GL_INVALID_ENUM
        GL_INVALID_VALUE
        GL_INVALID_OPERATION
        GL_STACK_OVERFLOW
        GL_STACK_UNDERFLOW
        GL_OUT_OF_MEMORY

        # GetTarget
        GL_POLYGON_MODE
        GL_POLYGON_SMOOTH
        GL_POLYGON_STIPPLE
        GL_FRONT_FACE
        GL_SHADE_MODEL
        GL_COLOR_MATERIAL_FACE
        GL_COLOR_MATERIAL_PARAMETER
        GL_COLOR_MATERIAL
        GL_DEPTH_RANGE
        GL_DEPTH_TEST
        GL_DEPTH_WRITEMASK
        GL_DEPTH_CLEAR_VALUE
        GL_DEPTH_FUNC
        GL_MATRIX_MODE
        GL_NORMALIZE
        GL_VIEWPORT
        GL_MODELVIEW_MATRIX
        GL_PROJECTION_MATRIX
        GL_TEXTURE_MATRIX
        GL_ALPHA_TEST
        GL_ALPHA_TEST_FUNC
        GL_ALPHA_TEST_REF
        GL_DITHER
        GL_BLEND_DST
        GL_BLEND_SRC
        GL_BLEND
        GL_LOGIC_OP_MODE
        GL_INDEX_LOGIC_OP
        GL_COLOR_LOGIC_OP
        GL_AUX_BUFFERS
        GL_DRAW_BUFFER
        GL_READ_BUFFER
        GL_SCISSOR_BOX
        GL_SCISSOR_TEST
        GL_INDEX_CLEAR_VALUE
        GL_INDEX_WRITEMASK
        GL_COLOR_CLEAR_VALUE
        GL_COLOR_WRITEMASK
        GL_INDEX_MODE
        GL_RGBA_MODE
        GL_DOUBLEBUFFER
        GL_STEREO
        GL_RENDER_MODE
        GL_SUBPIXEL_BITS
        GL_INDEX_BITS
        GL_RED_BITS
        GL_GREEN_BITS
        GL_BLUE_BITS
        GL_ALPHA_BITS
        GL_DEPTH_BITS
        GL_STENCIL_BITS
        GL_CULL_FACE
        
        # Hints
        GL_PERSPECTIVE_CORRECTION_HINT
        GL_POINT_SMOOTH_HINT
        GL_LINE_SMOOTH_HINT
        GL_POLYGON_SMOOTH_HINT
        GL_FOG_HINT
        GL_DONT_CARE
        GL_FASTEST
        GL_NICEST
        
        # Ligthing & Material
        GL_AMBIENT
        GL_DIFFUSE
        GL_SPECULAR
        GL_SHININESS
        GL_EMISSION
        GL_POSITION
        GL_SPOT_DIRECTION
        GL_SPOT_EXPONENT
        GL_SPOT_CUTOFF
        GL_AMBIENT_AND_DIFFUSE
        GL_COLOR_INDEXES
        GL_LIGHTING
        GL_LIGHT0
        GL_LIGHT1
        GL_LIGHT2
        GL_LIGHT3
        GL_LIGHT4
        GL_LIGHT5
        GL_LIGHT6
        GL_LIGHT7
        GL_LIGHT_MODEL_TWO_SIDE
        GL_LIGHT_MODEL_LOCAL_VIEWER
        GL_LIGHT_MODEL_AMBIENT
        
        # MatrixMode
        GL_MODELVIEW
        GL_PROJECTION
        GL_TEXTURE
        
        # Lines
        GL_LINE_SMOOTH
        
        # PolygonMode
        GL_POINT
        GL_LINE
        GL_FILL
        GL_POLYGON_OFFSET_LINE
        GL_POLYGON_OFFSET_FILL
        
        # ShadingModel
        GL_FLAT
        GL_SMOOTH
        
        # Images
        GL_RGB
        GL_RGBA
        GL_PACK_ALIGNMENT

        # Texture mapping
        GL_TEXTURE_1D
        GL_TEXTURE_2D

        # glext.h
        GL_MULTISAMPLE
        GL_STATIC_DRAW
        
        GL_ARRAY_BUFFER
        GL_ELEMENT_ARRAY_BUFFER
        