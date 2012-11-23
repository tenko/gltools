# -*- coding: utf-8 -*-
from __future__ import print_function
import sys
import math
import array
import geotools as geo
import gltools as gl

# cube
#    v6----- v5
#   /|      /|
#  v1------v0|
#  | |     | |
#  | |v7---|-|v4
#  |/      |/
#  v2------v3

vertices = array.array('f',(
    1, 1, 1,  -1, 1, 1,  -1,-1, 1,   1,-1, 1,   # v0,v1,v2,v3 (front)
    1, 1, 1,   1,-1, 1,   1,-1,-1,   1, 1,-1,   # v0,v3,v4,v5 (right)
    1, 1, 1,   1, 1,-1,  -1, 1,-1,  -1, 1, 1,   # v0,v5,v6,v1 (top)
   -1, 1, 1,  -1, 1,-1,  -1,-1,-1,  -1,-1, 1,   # v1,v6,v7,v2 (left)
   -1,-1,-1,   1,-1,-1,   1,-1, 1,  -1,-1, 1,   # v7,v4,v3,v2 (bottom)
    1,-1,-1,  -1,-1,-1,  -1, 1,-1,   1, 1,-1,   # v4,v7,v6,v5 (back)
))

normals = array.array('f',(
    0, 0, 1,   0, 0, 1,   0, 0, 1,   0, 0, 1,   # v0,v1,v2,v3 (front)
    1, 0, 0,   1, 0, 0,   1, 0, 0,   1, 0, 0,   # v0,v3,v4,v5 (right)
    0, 1, 0,   0, 1, 0,   0, 1, 0,   0, 1, 0,   # v0,v5,v6,v1 (top)
   -1, 0, 0,  -1, 0, 0,  -1, 0, 0,  -1, 0, 0,   # v1,v6,v7,v2 (left)
    0,-1, 0,   0,-1, 0,   0,-1, 0,   0,-1, 0,   # v7,v4,v3,v2 (bottom)
    0, 0,-1,   0, 0,-1,   0, 0,-1,   0, 0,-1,   # v4,v7,v6,v5 (back)
))

colors = array.array('f',(
    1, 1, 1,   1, 1, 0,   1, 0, 0,   1, 0, 1,   # v0,v1,v2,v3 (front)
    1, 1, 1,   1, 0, 1,   0, 0, 1,   0, 1, 1,   # v0,v3,v4,v5 (right)
    1, 1, 1,   0, 1, 1,   0, 1, 0,   1, 1, 0,   # v0,v5,v6,v1 (top)
    1, 1, 0,   0, 1, 0,   0, 0, 0,   1, 0, 0,   # v1,v6,v7,v2 (left)
    0, 0, 0,   0, 0, 1,   1, 0, 1,   1, 0, 0,   # v7,v4,v3,v2 (bottom)
    0, 0, 1,   0, 0, 0,   0, 1, 0,   0, 1, 1,   # v4,v7,v6,v5 (back)
))

indices = array.array('B',(
    0, 1, 2,   2, 3, 0,      # front
    4, 5, 6,   6, 7, 4,      # right
    8, 9,10,  10,11, 8,      # top
    12,13,14,  14,15,12,     # left
    16,17,18,  18,19,16,     # bottom
    20,21,22,  22,23,20,     # back
))

class MainWindow(gl.Window):
    def __init__(self, width, height, title):
        self.initialized = False
        
        self.cam = geo.Camera()
        
        self.near = geo.Point(-2.,-2.,-2.)
        self.far = geo.Point(2.,2.,2.)
        
        self.lastPos = 0,0
        self.mouseCenter = geo.Point()
        self.uiScroll = 0
        self.currentButton = -1
        
        gl.Window.__init__(self, width, height, title)
        
        self.projectionMatrix = geo.Transform()
        self.modelviewMatrix = geo.Transform()
    
    def onSetup(self):
        self.ui = gl.UI()
        gl.ClearColor(gl.ColorRGBA(38,38,102,255))
        gl.ClearDepth(1.)
        
        gl.InitGLExt()
        
        # Material & lights
        mat = self.mat = gl.Material(
            ambient = gl.ColorRGBA(80,80,80,255),
            diffuse = gl.ColorRGBA(45,45,45,255),
            specular = gl.ColorRGBA(255,255,255,255),
            shininess = 100.,
        )
        
        lightMat = gl.Material(
            diffuse = gl.ColorRGBA(255,255,55,255),
            ambient = gl.ColorRGBA(55,55,25,255),
            specular = gl.ColorRGBA(255,255,255,255)
        )
        
        light0 = self.light0 = gl.Light(
            0,
            lightMat,
            geo.Point(0.,50.,100.),
        )
        
        light1 = self.light1 = gl.Light(
            1,
            lightMat,
            geo.Point(50.,0.,-100.),
        )
        
        light2 = self.light2 = gl.Light(
            2,
            lightMat,
            geo.Point(0.,-50.,0.),
        )
        
        # GLSL
        glsl = self.program = gl.ShaderProgram.pongDiffuse(3)
        
        # mesh
        fsize = vertices.itemsize
        buffer = self.buffer = gl.ClientBuffer()
        buffer.loadData(None, (len(vertices) + len(normals))*fsize)
        
        offset = 0
        size = len(vertices)*fsize
        buffer.setDataType(gl.VERTEX_ARRAY, gl.FLOAT, 3, 0, 0)
        buffer.loadData(vertices, size, offset)        # copy vertices starting from 0 offest
        offset += size
        
        size = len(normals)*fsize
        buffer.setDataType(gl.NORMAL_ARRAY, gl.FLOAT, 3, 0, offset)
        buffer.loadData(normals, size, offset)          # copy normals after vertices
        offset += size
        
        # index buffer
        idxbuffer = self.idxbuffer = gl.ClientBuffer(gl.ELEMENT_ARRAY_BUFFER)
        idxbuffer.loadData(indices, len(indices)*indices.itemsize)
        
        
    def onSize(self, w, h):
        #print('onSize ', w, h)
        self.width, self.height = w - 1, h - 1
        
        if self.width > 1 and self.height > 1:
            # Adjust frustum to viewport aspect
            frustum_aspect = float(self.width) / self.height
            self.cam.setFrustumAspect(frustum_aspect)
            self.cam.setViewportSize(self.width, self.height)
            
            self.makeContextCurrent()
            gl.Viewport(0, 0, self.width, self.height)
            
        # initialize
        if not self.initialized:
            self.onSetup()
            self.cam.zoomExtents(self.near, self.far)
            self.initialized = True
    
    def insideUI(self, x, y):
        y = self.height - y
        
        if x >= 10 and x <= 210:
            if y >= self.height - 260 and y <= self.height - 10:
                return True
                
        if x >= 10 and x <= 210:
            if y >= 10 and y <= self.height - 300:
                return True
        return False
        
    def onRefresh(self):
        #print('onRefresh')
        if not self.running:
            return
        
        ui = self.ui
        glsl = self.program
        x, y = self.lastPos
        w, h = self.width, self.height
        
        self.makeContextCurrent()
        gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
        
        gl.Enable(gl.DEPTH_TEST)
        gl.Enable(gl.MULTISAMPLE)
        gl.Enable(gl.DITHER)
        gl.Disable(gl.BLEND)
        gl.Disable(gl.CULL_FACE)
        gl.PolygonMode(gl.FRONT_AND_BACK, gl.FILL)
        gl.LightModeli(gl.LIGHT_MODEL_TWO_SIDE, gl.TRUE)
        
        gl.MatrixMode(gl.PROJECTION)
        self.projectionMatrix.cameraToClip(self.cam)
        gl.LoadMatrixd(self.projectionMatrix)
        
        gl.MatrixMode(gl.MODELVIEW)
        self.modelviewMatrix.worldToCamera(self.cam)
        gl.LoadMatrixd(self.modelviewMatrix)
        
        gl.Enable(gl.LIGHTING)
        self.light0.enable()
        self.light1.enable()
        self.light2.enable()
        self.mat.enable()
        
        glsl.begin()
        self.buffer.bind()
        self.idxbuffer.bind()
        gl.DrawElements(gl.TRIANGLES, 36, gl.UNSIGNED_BYTE, 0)
        self.buffer.unBind()
        self.idxbuffer.unBind()
        glsl.end()
        
        # draw font overlay
        gl.Disable(gl.DEPTH_TEST)
        gl.Disable(gl.LIGHTING)
        gl.Disable(gl.DITHER)
        gl.Enable(gl.BLEND)
        gl.BlendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA)
        
        gl.MatrixMode(gl.PROJECTION)
        gl.LoadIdentity()
        gl.Ortho(0,self.width,0,self.height,-1,1)
        gl.MatrixMode(gl.MODELVIEW)
        gl.LoadIdentity()
        
        scroll = self.uiScroll
        if scroll:
            self.uiScroll = 0
        
        ui.beginFrame(x,h - y,self.currentButton,scroll)
        ui.beginScrollArea("Scroll Area", 10, 10, 200, h-300)
        
        ui.label('Label test')
        
        ui.value(u'Value æøå')
        ui.separatorLine()
        ui.item('Item 1', True)
        ui.indent()
        ui.item('Item 2', False)
        ui.separator()
        ui.item('Item 3', True)
        ui.unindent()
        if ui.button("Button 1", True):
            print('Button 1 pressed')
            
        ui.button("Button 2", False)
        ui.separator()
        ui.check("Check 1", True, True)
        ui.check("Check 2", False, True)
        ui.check("Check 3", False, False)
        ui.separatorLine()
        ui.slider('Slider 1', 5, 0, 10, 1, True)
        ui.slider('Slider 2', 5, 0, 10, 1, False)
        ui.separatorLine()
        ui.collapse('Text line', 'Sub text line', True, True)
        ui.collapse('Text line', 'Sub text line', False, True)
        
        ui.endScrollArea()
        
        ui.beginArea("Fixed Area", 10, h - 260, 200, 250)
        ui.label('Message')
        if ui.button("OK", True, 5, 210, 40):
            print('Button OK pressed')
            
        ui.endArea()
        
        ui.endFrame()
        ui.flush()
        
        gl.Enable(gl.DEPTH_TEST)
        
        self.swapBuffers()
            
    def onCursorPos(self, x, y):
        width, height = self.width, self.height
        lastx,lasty = self.lastPos  
        cam = self.cam
        
        ui = self.insideUI(x, y)
        
        update = False
        if not ui and self.currentButton == gl.MOUSE.LEFT:
            # rotate view
            dx = x - lastx
            dy = y - lasty
            cam.rotateDeltas(dx, dy, target = self.mouseCenter)
            update = True
        
        elif not ui and self.currentButton == gl.MOUSE.RIGHT:
            # pan view
            cam.pan(lastx, lasty, x, y, target = self.mouseCenter)
            update = True
        
        #print('onCursorPos ', x, y)
        self.lastPos = x, y
        
        if ui or update:
            self.onRefresh()
        
    def onMouseButton(self, button, action):
        #print('onMouseButton ', button, action)
        if action == gl.ACTION.PRESS:
            if button in {gl.MOUSE.LEFT, gl.MOUSE.RIGHT}:
                # temporary rotation center to avoid exponential increase
                self.mouseCenter.set(self.cam.target)
                self.currentButton = button
        else:
            self.currentButton = -1
        
        self.onRefresh()
    
    def onKey(self, key, action):
        #print('onKey ', key, action)
        if key == gl.KEY.ESCAPE:
            self.running = False
        elif key == gl.KEY.F1:
            self.makeContextCurrent()
            img = gl.Image(self.width, self.height, gl.RGBA)
            gl.ReadPixels(0, 0, img)
            img.flipY()
            img.writePNG('screenshot01.png')
            
    def onChar(self, ch):
        #print('onChar ', ch)
        if ch == 'f':
            self.cam.zoomExtents(self.near, self.far)
            self.onRefresh()
        
    def onScroll(self, scx, scy):
        x, y = self.lastPos
        self.uiScroll = -int(scy)
        
        if not self.insideUI(x, y):        
            delta = 1e-4*scy
            dx = delta*self.width
            dy = delta*self.height
            
            self.cam.zoomFactor(1. + max(dx,dy), (x, y))
            
        self.onRefresh()
        
    def onClose(self):
        #print('onClose')
        return True

win = MainWindow(800, 600, title = u'title')
win.mainLoop()