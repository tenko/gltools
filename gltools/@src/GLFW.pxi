# -*- coding: utf-8 -*-

from glfwLib cimport *

cpdef Init():
    '''
    Initialize GLFW.
    
    Raise GLError on failure
    '''
    if not glfwInit():
        raise GLError('failed to initialize glfw')

cpdef Terminate():
    '''
    Terminate GLFW
    '''
    glfwTerminate()
    
# event handling
cpdef PollEvents():
    '''
    Process pending events and return
    '''
    glfwPollEvents()

cpdef WaitEvents():
    '''
    Wait for events
    '''
    glfwWaitEvents()
    
# timer functions     
cpdef double GetTime():
    '''
    Get current time since call to Init as float value
    '''
    Init()
    return glfwGetTime()

cpdef SetTime(double time):
    '''
    Sets current time
    '''
    Init()   
    glfwSetTime(time)

# gamma value
cpdef SetGamma(float gamma):
    '''
    Set gamma value
    '''
    Init()   
    glfwSetGamma(gamma)

# get desktop size
cpdef tuple GetDesktopSize():
    '''
    Return desktop size
    '''
    cdef GLFWvidmode vidmode
    
    Init()
    glfwGetDesktopMode(&vidmode)
    return vidmode.width, vidmode.height
            

cdef class Window:
    '''
    GLFW based window
    
    If width and height are not set then the window is
    sized to the current desktop size
    '''
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
        glfwSetWindowSizeCallback(<GLFWwindow>self.thisptr, cb_onSize)
        glfwSetWindowRefreshCallback(<GLFWwindow>self.thisptr, cb_onRefresh)
        glfwSetCursorPosCallback(<GLFWwindow>self.thisptr, cb_onCursorPos)
        glfwSetMouseButtonCallback(<GLFWwindow>self.thisptr, cb_onMouseButton)
        glfwSetKeyCallback(<GLFWwindow>self.thisptr, cb_onKey)
        glfwSetCharCallback(<GLFWwindow>self.thisptr, cb_onChar)
        glfwSetWindowCloseCallback(<GLFWwindow>self.thisptr, cb_onClose)
        glfwSetWindowFocusCallback(<GLFWwindow>self.thisptr, cb_onFocus)
        glfwSetCursorEnterCallback(<GLFWwindow>self.thisptr, cb_onEnter)
        glfwSetScrollCallback(<GLFWwindow>self.thisptr, cb_onScroll)
        glfwSetWindowIconifyCallback(<GLFWwindow>self.thisptr, cb_onIconify)
    
        # Get window size (may be different than the requested size)
        glfwGetWindowSize(<GLFWwindow>self.thisptr, &width, &height);
        self.onSize(width, max(1, height))
    
    def __dealloc__(self):
        glfwTerminate()
    
    cpdef setTitle(self, title):
        '''
        Set window title
        '''
        cdef char *c_title
        
        # decode to UTF-8
        bytetext = unicode(title).encode('UTF-8','ignore')
        c_title = bytetext
        
        glfwSetWindowTitle(<GLFWwindow>self.thisptr, c_title)
    
    cpdef tuple getSize(self):
        '''
        Get window size
        '''
        cdef int width, height
        glfwGetWindowSize(<GLFWwindow>self.thisptr, &width, &height)
        return width, height
    
    cpdef setSize(self, int width, int height):
        '''
        Set window size
        '''
        if width <= 0 or height <= 0:
            raise GLError('window size not valid')
        glfwSetWindowSize(<GLFWwindow>self.thisptr, width, height)
    
    cpdef setClipboard(self, content):
        '''
        Set clipboard text
        '''
        glfwSetClipboardString(<GLFWwindow>self.thisptr, content)
    
    cpdef getClipboard(self):
        '''
        Get clipboard text
        '''
        cdef const_char *content = glfwGetClipboardString(<GLFWwindow>self.thisptr)
        return content
    
    cpdef iconify(self):
        '''
        Iconify window
        '''
        glfwIconifyWindow(<GLFWwindow>self.thisptr)
        
    cpdef restore(self):
        '''
        Restore window from iconification
        '''
        glfwRestoreWindow(<GLFWwindow>self.thisptr)
    
    cpdef show(self):
        '''
        Show window
        '''
        glfwShowWindow(<GLFWwindow>self.thisptr)
    
    cpdef hide(self):
        '''
        Hide window
        '''
        glfwHideWindow(<GLFWwindow>self.thisptr)
    
    cpdef close(self):
        '''
        Stop main loop and close window
        '''
        self.running = False
        glfwDestroyWindow(<GLFWwindow>self.thisptr)
        glfwTerminate()
        
    cpdef makeContextCurrent(self):
        '''
        Make window openGL context current
        '''
        glfwMakeContextCurrent(<GLFWwindow>self.thisptr)
        
    cpdef swapBuffers(self):
        '''
        Swap front and back buffers
        '''
        glfwSwapBuffers(<GLFWwindow>self.thisptr)
        
    cpdef mainLoop(self):
        '''
        Run main loop.
        
        The main loops waits for events. Mouse move events are special
        handled to avoid to quick update.
        '''
        # keep waiting for events until running is False
        cdef int x, y, lastX, lastY
        cdef double t
        
        glfwSetCursorPosCallback(<GLFWwindow>self.thisptr, NULL)
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
            
            if not self.error is None:
                error = self.error
                self.error = None
                raise error
                
            if not self.running:
                break
                
    cpdef onSize(self, int w, int h):
        '''
        Callback when size changes
        '''
        pass
    
    cpdef onRefresh(self):
        '''
        Callback when refresh of content is requested
        '''
        pass
    
    cpdef onCursorPos(self, int x, int y):
        '''
        Callback on change of mouse cursor position
        '''
        pass
    
    cpdef onMouseButton(self, int button, int action):
        '''
        Callback on mouse button press or release
        '''
        pass
    
    cpdef onKey(self, int key, int action):
        '''
        Callback on key press or relase.
        '''
        pass
    
    cpdef onChar(self, ch):
        '''
        Callback non-special key pressed
        '''
        pass
        
    cpdef onFocus(self, int status):
        '''
        Callback on windows focus change
        '''
        pass
    
    cpdef onEnter(self, int status):
        '''
        Callback on mouse pointer enter/leave event
        '''
        pass
    
    cpdef onScroll(self, double dx, double dy):
        '''
        Callback on mouse scroll wheel
        '''
        pass
    
    cpdef onIconify(self, int status):
        '''
        Callback on iconify status change
        '''
        pass
        
    cpdef bint onClose(self):
        '''
        Callback on close request.
        '''
        return False

# callback functions
cdef void cb_onSize(GLFWwindow window, int w, int h):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    
    try:
        self.onSize(w, max(1, h))
    except Exception as err:
        self.error = err

cdef void cb_onRefresh(GLFWwindow window):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    try:
        self.onRefresh()
    except Exception as err:
        self.error = err
        
cdef void cb_onCursorPos(GLFWwindow window, int x, int y):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    
    try:
        self.onCursorPos(x, y)
    except Exception as err:
        self.error = err
    
cdef void cb_onMouseButton(GLFWwindow window, int button, int action):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    
    try:
        self.onMouseButton(button, action)
    except Exception as err:
        self.error = err

cdef void cb_onKey(GLFWwindow window, int key, int action):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    
    try:
        self.onKey(key, action)
    except Exception as err:
        self.error = err

cdef void cb_onChar(GLFWwindow window, int ch):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    cdef char st[2]
    
    st[0] = <char>(ch & 0xff)
    st[1] = 0
    
    try:
        self.onChar(st.decode('UTF-8', 'ignore'))
    except Exception as err:
        self.error = err

cdef void cb_onFocus(GLFWwindow window, int status):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    
    try:
        self.onFocus(status)
    except Exception as err:
        self.error = err

cdef void cb_onEnter(GLFWwindow window, int status):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    self.onEnter(status)
    
cdef void cb_onScroll(GLFWwindow window, double dx, double dy):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    
    try:
        self.onScroll(dx, dy)
    except Exception as err:
        self.error = err

cdef void cb_onIconify(GLFWwindow window, int status):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    
    try:
        self.onIconify(status)
    except Exception as err:
        self.error = err
    
cdef int cb_onClose(GLFWwindow window):
    cdef Window self = <Window>glfwGetWindowUserPointer(window)
    cdef int ret
    
    try:
        ret = self.onClose()
    except Exception as err:
        self.error = err
        
    if ret:
        self.running = False
    
    return ret
    