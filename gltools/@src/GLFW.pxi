# -*- coding: utf-8 -*-

from glfwLib cimport *

cpdef Init():
    if not glfwInit():
        raise GLError('failed to initialize glfw')

# timer functions     
cpdef double getTime():
    Init()
    return glfwGetTime()

cpdef SetTime(double time):
    Init()   
    glfwSetTime(time)

# gamma value
cpdef SetGamma(float gamma):
    Init()   
    glfwSetGamma(gamma)

# get desktop size
cpdef tuple GetDesktopSize():
    cdef GLFWvidmode vidmode
    
    Init()
    glfwGetDesktopMode(&vidmode)
    return vidmode.width, vidmode.height
            

cdef class Window:
    def __init__(self, int width = -1, int height = -1, title = None,
                 bint fullscreen = False):
        cdef GLFWvidmode vidmode
        cdef int mode = GLFW_WINDOWED
        cdef char *c_title
        
        # Initialise GLFW
        if not glfwInit():
            raise GLError('failed to initialize glfw')
        
        # set window hints
        glfwWindowHint(GLFW_RED_BITS, 8)
        glfwWindowHint(GLFW_GREEN_BITS, 8)
        glfwWindowHint(GLFW_BLUE_BITS, 8)
        glfwWindowHint(GLFW_ALPHA_BITS, 8)
        glfwWindowHint(GLFW_DEPTH_BITS, 24)
        glfwWindowHint(GLFW_STENCIL_BITS, 8)
        
        glfwWindowHint(GLFW_OPENGL_VERSION_MAJOR, 2)
        glfwWindowHint(GLFW_OPENGL_VERSION_MINOR, 1)
        
        # open window
        if width < 0 or height < 0:
            # default to desktop size
            glfwGetDesktopMode(&vidmode)
            width, height = vidmode.width, vidmode.height
            glfwWindowHint(GLFW_RED_BITS, vidmode.redBits)
            glfwWindowHint(GLFW_GREEN_BITS, vidmode.greenBits)
            glfwWindowHint(GLFW_BLUE_BITS, vidmode.blueBits)
        
        if fullscreen:
            mode = GLFW_FULLSCREEN
        
        # decode to UTF-8
        if title is None:
            title = ''
        bytetext = unicode(title).encode('UTF-8','ignore')
        c_title = bytetext
        
        self.thisptr = glfwCreateWindow(width, height, mode, c_title, NULL)
        if self.thisptr == NULL:
            raise GLError('failed to open window')
        
        # Set pointer back to this class for callbacks
        glfwSetWindowUserPointer(<GLFWwindow>self.thisptr, <void *>self)
        
        # Set callback functions
        glfwSetWindowSizeCallback(cb_onSize)
        glfwSetWindowRefreshCallback(cb_onRefresh)
        glfwSetMouseButtonCallback(cb_onMouseButton)
        glfwSetKeyCallback(cb_onKey)
        glfwSetCharCallback(cb_onChar)
        glfwSetWindowCloseCallback(cb_onClose)
        glfwSetWindowFocusCallback(cb_onFocus)
        glfwSetCursorEnterCallback(cb_onEnter)
        glfwSetScrollCallback(cb_onScroll)
        glfwSetWindowIconifyCallback(cb_onIconify)
    
        # Get window size (may be different than the requested size)
        glfwGetWindowSize(<GLFWwindow>self.thisptr, &width, &height);
        self.onSize(width, max(1, height))
    
    def __dealloc__(self):
        glfwTerminate()
    
    cpdef setTitle(self, title):
        cdef char *c_title
        
        # decode to UTF-8
        bytetext = unicode(title).encode('UTF-8','ignore')
        c_title = bytetext
        
        glfwSetWindowTitle(<GLFWwindow>self.thisptr, c_title)
    
    cpdef tuple getSize(self):
        cdef int width, height
        glfwGetWindowSize(<GLFWwindow>self.thisptr, &width, &height)
        return width, height
    
    cpdef setSize(self, int width, int height):
        if width <= 0 or height <= 0:
            raise GLError('window size not valid')
        glfwSetWindowSize(<GLFWwindow>self.thisptr, width, height)
    
    cpdef tuple getPos(self):
        cdef int x, y
        glfwGetWindowPos(<GLFWwindow>self.thisptr, &x, &y)
        return x, y
    
    cpdef setPos(self, int x, int y):
        glfwSetWindowPos(<GLFWwindow>self.thisptr, x, y)
    
    cpdef setClipboard(self, content):
        glfwSetClipboardString(<GLFWwindow>self.thisptr, content)
    
    cpdef getClipboard(self):
        cdef char *content = glfwGetClipboardString(<GLFWwindow>self.thisptr)
        return content
    
    cpdef iconify(self):
        glfwIconifyWindow(<GLFWwindow>self.thisptr)
        
    cpdef restore(self):
        glfwRestoreWindow(<GLFWwindow>self.thisptr)
    
    cpdef show(self):
        glfwShowWindow(<GLFWwindow>self.thisptr)
    
    cpdef hide(self):
        glfwHideWindow(<GLFWwindow>self.thisptr)
    
    cpdef close(self):
        self.running = False
        glfwDestroyWindow(<GLFWwindow>self.thisptr)
        glfwTerminate()
        
    cpdef makeContextCurrent(self):
        glfwMakeContextCurrent(<GLFWwindow>self.thisptr)
        
    cpdef swapBuffers(self):
        glfwSwapBuffers(<GLFWwindow>self.thisptr)
        
    cpdef mainLoop(self):
        # keep waiting for events until running is False
        cdef int x, y, lastX, lastY
        cdef double t
        
        glfwGetCursorPos(<GLFWwindow>self.thisptr, &lastX, &lastY)
        self.running = True
        while True:
            # Wait for new events
            glfwWaitEvents()
            
            # Avoid to quick update due to mouse move
            glfwGetCursorPos(<GLFWwindow>self.thisptr, &x, &y)
            if x != lastX or y != lastY:
                # in mouse move
                t = glfwGetTime()
                while True and self.running:
                    glfwWaitEvents()
                    if glfwGetTime() - t > .025:
                        break
                
                glfwGetCursorPos(<GLFWwindow>self.thisptr, &x, &y)
                self.onCursorPos(x, y)
            
            lastX, lastY = x, y
            
            if not self.running:
                break
                
    cpdef onSize(self, int w, int h):
        pass
    
    cpdef onRefresh(self):
        pass
    
    cpdef onCursorPos(self, int x, int y):
        pass
    
    cpdef onMouseButton(self, int button, int action):
        pass
    
    cpdef onKey(self, int key, int action):
        pass
    
    cpdef onChar(self, ch):
        pass
        
    cpdef onFocus(self, int status):
        pass
    
    cpdef onEnter(self, int status):
        pass
    
    cpdef onScroll(self, double dx, double dy):
        pass
    
    cpdef onIconify(self, int status):
        pass
        
    cpdef bint onClose(self):
        return False

# callback functions
cdef void cb_onSize(GLFWwindow window, int w, int h):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    self.onSize(w, max(1, h))

cdef void cb_onRefresh(GLFWwindow window):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    # avoid refresh when request closing
    self.onRefresh()

cdef void cb_onMouseButton(GLFWwindow window, int button, int action):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    self.onMouseButton(button, action)

cdef void cb_onKey(GLFWwindow window, int key, int action):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    self.onKey(key, action)

cdef void cb_onChar(GLFWwindow window, int ch):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    cdef char st[2]
    
    st[0] = <char>(ch & 0xff)
    st[1] = 0
    
    self.onChar(st.decode('UTF-8', 'ignore'))

cdef void cb_onFocus(GLFWwindow window, int status):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    self.onFocus(status)

cdef void cb_onEnter(GLFWwindow window, int status):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    self.onEnter(status)
    
cdef void cb_onScroll(GLFWwindow window, double dx, double dy):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    self.onScroll(dx, dy)

cdef void cb_onIconify(GLFWwindow window, int status):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    self.onIconify(status)
    
cdef int cb_onClose(GLFWwindow window):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    cdef int ret = self.onClose()
    if ret:
        self.running = False
    return ret
    