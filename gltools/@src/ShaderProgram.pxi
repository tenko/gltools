# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#
cdef class ShaderProgram:
    '''
    Class to encapsulate compiled GLSL shaders
    '''
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
        '''
        Return status
        '''
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        return prog.isValid()
    
    cpdef begin(self):
        '''
        Set program as current
        '''
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        prog.begin()
    
    cpdef end(self):
        '''
        Unset program. This will enable the fixed openGL pipeline
        '''
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        prog.end()
    
    cpdef loadUniform1i(self, char *name, int value):
        '''
        Load named uniform integer value
        '''
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        if not prog.loadUniform1i(name, value):
            raise GLError(errorMessage)
    
    cpdef loadUniform1f(self, char *name, float value):
        '''
        Load named uniform float value
        '''
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        if not prog.loadUniform1f(name, value):
            raise GLError(errorMessage)
    
    cpdef loadUniform4f(self, char *name, float v0, float v1, float v2, float v3):
        '''
        Load named uniform float vector
        '''
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        if not prog.loadUniform4f(name, v0, v1, v2, v3):
            raise GLError(errorMessage)
    
    cpdef loadUniformMatrix4vf(self, char *name, float [::1] value, int count = 1):
        '''
        Load named uniform matrix value
        '''
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        if not prog.loadUniformMatrix4vf(name, &value[0], count):
            raise GLError(errorMessage)
    
    cpdef build(self, vertex_src = None, fragment_src = None):
        '''
        Compile program source. If no argument is given the
        default program simulating the fixed pipeline is
        loaded.
        
        Raises GLError if failed.
        '''
        cdef c_ShaderProgram *prog = <c_ShaderProgram *>self.thisptr
        cdef int ret
        
        if vertex_src is None and fragment_src is None:
            ret = prog.build(NULL,NULL)
        else:
            if not isinstance(vertex_src, bytes):
                vertex_src = vertex_src.encode('ascii')
                
            if not isinstance(fragment_src, bytes):
                fragment_src = fragment_src.encode('ascii')
                
            ret = prog.build(vertex_src, fragment_src)
        
        if not ret:
            raise GLError(errorMessage)
    
    @classmethod
    def flat(cls):
        cdef ShaderProgram ret = ShaderProgram()
        ret.build(GLSL_VERTEX_FLAT, GLSL_FRAG_FLAT)
        return ret
    
    @classmethod
    def pongDiffuse(cls, int lights):
        cdef ShaderProgram ret = ShaderProgram()
        
        if lights < 1 or lights > 8:
            raise GLError('lights must be between 1 and 8')
            
        INIT = "#define MAX_LIGHTS %d" % lights
        FRAG_SRC = b"\n".join((INIT.encode('ascii'), GLSL_FRAG_PONG_COMMON, GLSL_FRAG_PONG_DIFFUSE))
        
        ret.build(GLSL_VERTEX_PONG, FRAG_SRC)
        return ret
    
    @classmethod
    def pongSpecular(cls, int lights):
        cdef ShaderProgram ret = ShaderProgram()
        
        if lights < 1 or lights > 8:
            raise GLError('lights must be between 1 and 8')
            
        INIT = "#define MAX_LIGHTS %d" % lights
        FRAG_SRC = b"\n".join((INIT.encode('ascii'), GLSL_FRAG_PONG_COMMON, GLSL_FRAG_PONG_SPECULAR))
        
        ret.build(GLSL_VERTEX_PONG, FRAG_SRC)
        return ret
        
# simple flat shader for overlay & background
cdef char *GLSL_VERTEX_FLAT = \
"""
varying vec4 col;

void main(void)  
{     
   col = gl_Color;
   gl_Position = ftransform();
}
"""

cdef char *GLSL_FRAG_FLAT = \
"""
varying vec4 col;

void main (void) 
{ 
   gl_FragColor = col; 
}
"""

# two sided per-pixel phong shader
# ref: http://www.gamedev.net/page/resources/_/technical/opengl/creating-a-glsl-library-r2428

cdef char *GLSL_VERTEX_PONG = \
"""
varying vec3 normal;
varying vec3 vertex;

void main()
{
    // Calculate the normal
    normal = normalize(gl_NormalMatrix * gl_Normal);
   
    // Transform the vertex position to eye space
    vertex = vec3(gl_ModelViewMatrix * gl_Vertex);
       
    gl_Position = ftransform();
}
"""

cdef char *GLSL_FRAG_PONG_COMMON = \
""" 
varying vec3 normal;
varying vec3 vertex;

float calculateAttenuation(in int i, in float dist)
{
    return(1.0 / (gl_LightSource[i].constantAttenuation +
                  gl_LightSource[i].linearAttenuation * dist +
                  gl_LightSource[i].quadraticAttenuation * dist * dist));
}

void directionalLight(in int i, in vec3 N, in float shininess,
                      inout vec4 ambient, inout vec4 diffuse, inout vec4 specular)
{
    vec3 L = normalize(gl_LightSource[i].position.xyz);
   
    float nDotL = dot(N, L);
   
    if (nDotL > 0.0)
    {   
        vec3 H = gl_LightSource[i].halfVector.xyz;
       
        float pf = pow(max(dot(N,H), 0.0), shininess);

        diffuse  += gl_LightSource[i].diffuse  * nDotL;
        specular += gl_LightSource[i].specular * pf;
    }
   
    ambient  += gl_LightSource[i].ambient;
}

void pointLight(in int i, in vec3 N, in vec3 V, in float shininess,
                inout vec4 ambient, inout vec4 diffuse, inout vec4 specular)
{
    vec3 D = gl_LightSource[i].position.xyz - V;
    vec3 L = normalize(D);

    float dist = length(D);
    float attenuation = calculateAttenuation(i, dist);

    float nDotL = dot(N,L);

    if (nDotL > 0.0)
    {   
        vec3 E = normalize(-V);
        vec3 R = reflect(-L, N);
       
        float pf = pow(max(dot(R,E), 0.0), shininess);

        diffuse  += gl_LightSource[i].diffuse  * attenuation * nDotL;
        specular += gl_LightSource[i].specular * attenuation * pf;
    }
   
    ambient  += gl_LightSource[i].ambient * attenuation;
}

void spotLight(in int i, in vec3 N, in vec3 V, in float shininess,
               inout vec4 ambient, inout vec4 diffuse, inout vec4 specular)
{
    vec3 D = gl_LightSource[i].position.xyz - V;
    vec3 L = normalize(D);

    float dist = length(D);
    float attenuation = calculateAttenuation(i, dist);

    float nDotL = dot(N,L);

    if (nDotL > 0.0)
    {   
        float spotEffect = dot(normalize(gl_LightSource[i].spotDirection), -L);
       
        if (spotEffect > gl_LightSource[i].spotCosCutoff)
        {
            attenuation *=  pow(spotEffect, gl_LightSource[i].spotExponent);

            vec3 E = normalize(-V);
            vec3 R = reflect(-L, N);
       
            float pf = pow(max(dot(R,E), 0.0), shininess);

            diffuse  += gl_LightSource[i].diffuse  * attenuation * nDotL;
            specular += gl_LightSource[i].specular * attenuation * pf;
        }
    }
   
    ambient  += gl_LightSource[i].ambient * attenuation;
}

void calculateLighting(in vec3 N, in vec3 V, in float shininess,
                       inout vec4 ambient, inout vec4 diffuse, inout vec4 specular)
{
    // Just loop through each light, and add
    // its contributions to the color of the pixel.
    for (int i = 0; i < MAX_LIGHTS - 1; i++)
    {
        if (gl_LightSource[i].position.w == 0.0)
            directionalLight(i, N, shininess, ambient, diffuse, specular);
        else if (gl_LightSource[i].spotCutoff == 180.0)
            pointLight(i, N, V, shininess, ambient, diffuse, specular);
        else
             spotLight(i, N, V, shininess, ambient, diffuse, specular);
    }
}
"""

cdef char *GLSL_FRAG_PONG_SPECULAR = \
"""
void main()
{
    // Normalize the normal. A varying variable CANNOT
    // be modified by a fragment shader. So a new variable
    // needs to be created.
    vec3 n = normalize(normal);
   
    vec4 ambient, diffuse, specular, color;

    // Initialize the contributions.
    ambient  = vec4(0.0);
    diffuse  = vec4(0.0);
    specular = vec4(0.0);
   
    // In this case the built in uniform gl_MaxLights is used
    // to denote the number of lights. A better option may be passing
    // in the number of lights as a uniform or replacing the current
    // value with a smaller value.
    calculateLighting(n, vertex, gl_FrontMaterial.shininess,
                      ambient, diffuse, specular);
   
    color  = gl_FrontLightModelProduct.sceneColor  +
             (ambient  * gl_FrontMaterial.ambient) +
             (diffuse  * gl_FrontMaterial.diffuse) +
             (specular * gl_FrontMaterial.specular);

    // Re-initialize the contributions for the back
    // pass over the lights
    ambient  = vec4(0.0);
    diffuse  = vec4(0.0);
    specular = vec4(0.0);
          
    // Now caculate the back contribution. All that needs to be
    // done is to flip the normal.
    calculateLighting(-n, vertex, gl_BackMaterial.shininess,
                      ambient, diffuse, specular);

    color += gl_BackLightModelProduct.sceneColor  +
             (ambient  * gl_BackMaterial.ambient) +
             (diffuse  * gl_BackMaterial.diffuse) +
             (specular * gl_BackMaterial.specular);

    color = clamp(color, 0.0, 1.0);
   
    gl_FragColor = color;
}
"""

cdef char *GLSL_FRAG_PONG_DIFFUSE = \
"""
void main()
{
    // Normalize the normal. A varying variable CANNOT
    // be modified by a fragment shader. So a new variable
    // needs to be created.
    vec3 n = normalize(normal);
   
    vec4 ambient, diffuse, specular, color;

    // Initialize the contributions.
    ambient  = vec4(0.0);
    diffuse  = vec4(0.0);
    specular = vec4(0.0);
   
    // In this case the built in uniform gl_MaxLights is used
    // to denote the number of lights. A better option may be passing
    // in the number of lights as a uniform or replacing the current
    // value with a smaller value.
    calculateLighting(n, vertex, gl_FrontMaterial.shininess,
                      ambient, diffuse, specular);
   
    color  = gl_FrontLightModelProduct.sceneColor  +
             (ambient  * gl_FrontMaterial.ambient) +
             (diffuse  * gl_FrontMaterial.diffuse);

    // Re-initialize the contributions for the back
    // pass over the lights
    ambient  = vec4(0.0);
    diffuse  = vec4(0.0);
    specular = vec4(0.0);
          
    // Now caculate the back contribution. All that needs to be
    // done is to flip the normal.
    calculateLighting(-n, vertex, gl_BackMaterial.shininess,
                      ambient, diffuse, specular);

    color += gl_BackLightModelProduct.sceneColor  +
             (ambient  * gl_BackMaterial.ambient) +
             (diffuse  * gl_BackMaterial.diffuse);

    color = clamp(color, 0.0, 1.0);
   
    gl_FragColor = color;
}
"""
