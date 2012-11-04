# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#
cdef class ColorRGBA:
    '''
    RGBA color with components stored as unsigned
    bytes.
    '''
    def __init__(self, GLubyte red = 255, GLubyte green = 255, GLubyte blue = 255,
                       GLubyte alpha = 255):
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    
    def __str__(self):
        return "ColorRGBA%s" % repr(self)
    
    def __repr__(self):
        args = self.red, self.green, self.blue, self.alpha
        return "(red=%d, green=%d, blue=%d, alpha=%d)" % args
    
    def __len__(self):
        return 4
    
    def __getitem__(self, int key):
        if key == 0:
            return self.red
        elif key == 1:
            return self.green
        elif key == 2:
            return self.blue
        elif key == 3:
            return self.alpha
        raise IndexError('index out of range')
    
    def __mul__(double factor, ColorRGBA rhs):
        '''
        Scale color components and leaves alpha unchanged
        '''
        cdef ColorRGBA ret = ColorRGBA.__new__(ColorRGBA)
        
        if factor < 0.:
            raise GLError('factor < 0.')
            
        ret.red   = <unsigned char>fmin(255, factor*rhs.red)
        ret.green = <unsigned char>fmin(255, factor*rhs.green)
        ret.blue  = <unsigned char>fmin(255, factor*rhs.blue)
        ret.alpha = rhs.alpha
        
        return ret
        
    cpdef ColorRGBA copy(self, int red = -1, int green = -1, int blue = -1, alpha = -1):
        '''
        Create copy with optional changes.
        '''
        cdef ColorRGBA ret = ColorRGBA.__new__(ColorRGBA)
        
        ret.red = self.red
        ret.green = self.green
        ret.blue = self.blue
        ret.alpha = self.alpha
        
        if red >= 0 and red < 256:
            ret.red = red
        
        if green >= 0 and green < 256:
            ret.green = green
        
        if blue >= 0 and blue < 256:
            ret.blue = blue
        
        if alpha >= 0 and alpha < 256:
            ret.alpha = alpha
            
        return ret
        
    cpdef unsigned toInt(self):
        '''
        Pack color to a single unsigned int
        '''
        return self.alpha << 24 | self.blue << 16 | self.green << 8 | self.red
    
    cpdef fromInt(self, unsigned int value):
        '''
        Unpack color from unsigned int
        '''
        self.red = value & 0x000000FF
        self.green = (value & 0x0000FF00) >> 8
        self.blue = (value & 0x00FF0000) >> 16
        self.alpha = (value & 0xFF000000) >> 14
        
    cpdef tuple toFloatVector(self):
        '''
        Return color as float normalized [0.0 - 1.0]
        '''
        return (self.red / 255., self.green / 255., self.blue / 255., self.alpha / 255.)
    
    cdef setFloatVector(self, float *vec):
        vec[0] = self.red / 255.
        vec[1] = self.green / 255.
        vec[2] = self.blue / 255.
        vec[3] = self.alpha / 255.
        
WHITE = ColorRGBA(255,255,255,255)
BLACK = ColorRGBA(0,0,0,255)
    
cdef class Material:
    '''
    Abstraction of OpenGL material
    '''
    def __init__(self, int mode = GL_FRONT_AND_BACK, **kwargs):
        self.mode = mode
        self.shininess = -1.
        
        for name, value in kwargs.iteritems():
            if name in {'ambient','diffuse','specular','emissive','shininess'}:
                setattr(self, name, value)
            else:
                raise GLError("attribute '%s' not known")
    
    def __str__(self):
        return "Material%s" % repr(self)
    
    def __repr__(self):
        return "()"
    
    cpdef enable(self):
        '''
        Set OpenGL material state
        '''
        cdef float mat[4]
        cdef int i
        if not self.ambient is None:
            self.ambient.setFloatVector(mat)
            glMaterialfv(self.mode, GL_AMBIENT, mat)
        
        if not self.diffuse is None:
            self.diffuse.setFloatVector(mat)
            glMaterialfv(self.mode, GL_DIFFUSE, mat)
        
        if not self.specular is None:
            self.specular.setFloatVector(mat)
            glMaterialfv(self.mode, GL_SPECULAR, mat)
        
        if not self.emissive is None:
            self.emissive.setFloatVector(mat)
            glMaterialfv(self.mode, GL_EMISSION, mat)
        
        if self.shininess > 0:
            mat[0] = fmin(fmax(0., self.shininess), 128)
            glMaterialfv(self.mode, GL_SHININESS, mat)

cpdef AmbientLight(ColorRGBA col):
    '''
    Set global ambient light color.
    '''
    cdef float c_col[4]
    col.setFloatVector(c_col)
    glLightModelfv(GL_LIGHT_MODEL_AMBIENT, c_col)
    
cdef class Light:
    '''
    Abstraction of OpenGL light
    '''
    def __init__(self, int index = 0, Material material = None,
                 Point position = None, directional = True,
                 Vector direction = None):
        if index == 0:
            self.index = GL_LIGHT0
        elif index == 1:
            self.index = GL_LIGHT1
        elif index == 2:
            self.index = GL_LIGHT2
        elif index == 3:
            self.index = GL_LIGHT3
        elif index == 4:
            self.index = GL_LIGHT4
        elif index == 5:
            self.index = GL_LIGHT5
        elif index == 6:
            self.index = GL_LIGHT6
        elif index == 7:
            self.index = GL_LIGHT7
        else:
            raise GLError('Light index out of range (0-7)')
        
        self.material = material
        self.position = position
        self.directional = directional
        self.direction = direction
    
    def __str__(self):
        return "Light%s" % repr(self)
    
    def __repr__(self):
        return "()"
        
    cpdef enable(self):
        '''
        Enable light and set OpenGL state
        '''
        cdef float mat[4]
        
        glEnable(self.index)
        
        if not self.material.ambient is None:
            self.material.ambient.setFloatVector(mat)
            glLightfv(self.index, GL_AMBIENT, mat)
        
        if not self.material.diffuse is None:
            self.material.diffuse.setFloatVector(mat)
            glLightfv(self.index, GL_DIFFUSE, mat)
            
        if not self.material.specular is None:
            self.material.specular.setFloatVector(mat)
            glLightfv(self.index, GL_SPECULAR, mat)
            
        if self.directional:
            mat[3] = 0.
        else:
            mat[3] = 1.
        
        if not self.direction is None:
            mat[0], mat[1], mat[2] = self.direction
        else:
            mat[0], mat[1], mat[2] = 0., 0., -1.
        
        glLightfv(self.index, GL_SPOT_DIRECTION, mat)
        
        if not self.position is None:
            mat[0], mat[1], mat[2] = self.position
        else:
            mat[0], mat[1], mat[2] = 0., 0., 0.
        
        glLightfv(self.index, GL_POSITION, mat)
        
        glLightf(self.index, GL_SPOT_CUTOFF, 180.)
        glLightf(self.index, GL_SPOT_EXPONENT, 0.)
        
    cpdef disable(self):
        '''
        Disable light
        '''
        glDisable(self.index)