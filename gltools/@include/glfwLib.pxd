# -*- coding: utf-8 -*-

cdef extern from "GL/glfw3.h":
    cdef enum:
        GLFW_VERSION_MAJOR
        GLFW_VERSION_MINOR
        GLFW_VERSION_REVISION
        
        # Key and button state/action definitions
        GLFW_RELEASE
        GLFW_PRESS
        
        # Printable keys
        GLFW_KEY_SPACE
        GLFW_KEY_APOSTROPHE
        GLFW_KEY_COMMA
        GLFW_KEY_MINUS
        GLFW_KEY_PERIOD
        GLFW_KEY_SLASH
        GLFW_KEY_0
        GLFW_KEY_1
        GLFW_KEY_2
        GLFW_KEY_3
        GLFW_KEY_4
        GLFW_KEY_5
        GLFW_KEY_6
        GLFW_KEY_7
        GLFW_KEY_8
        GLFW_KEY_9
        GLFW_KEY_SEMICOLON
        GLFW_KEY_EQUAL
        GLFW_KEY_A
        GLFW_KEY_B
        GLFW_KEY_C
        GLFW_KEY_D
        GLFW_KEY_E
        GLFW_KEY_F
        GLFW_KEY_G
        GLFW_KEY_H
        GLFW_KEY_I
        GLFW_KEY_J
        GLFW_KEY_K
        GLFW_KEY_L
        GLFW_KEY_M
        GLFW_KEY_N
        GLFW_KEY_O
        GLFW_KEY_P
        GLFW_KEY_Q
        GLFW_KEY_R
        GLFW_KEY_S
        GLFW_KEY_T
        GLFW_KEY_U
        GLFW_KEY_V
        GLFW_KEY_W
        GLFW_KEY_X
        GLFW_KEY_Y
        GLFW_KEY_Z
        GLFW_KEY_LEFT_BRACKET
        GLFW_KEY_BACKSLASH
        GLFW_KEY_RIGHT_BRACKET
        GLFW_KEY_GRAVE_ACCENT
        GLFW_KEY_WORLD_1
        GLFW_KEY_WORLD_2
        
        # Function keys
        GLFW_KEY_ESCAPE
        GLFW_KEY_ENTER
        GLFW_KEY_TAB
        GLFW_KEY_BACKSPACE
        GLFW_KEY_INSERT
        GLFW_KEY_DELETE
        GLFW_KEY_RIGHT
        GLFW_KEY_LEFT
        GLFW_KEY_DOWN
        GLFW_KEY_UP
        GLFW_KEY_PAGE_UP
        GLFW_KEY_PAGE_DOWN
        GLFW_KEY_HOME
        GLFW_KEY_END
        GLFW_KEY_CAPS_LOCK
        GLFW_KEY_SCROLL_LOCK
        GLFW_KEY_NUM_LOCK
        GLFW_KEY_PRINT_SCREEN
        GLFW_KEY_PAUSE
        GLFW_KEY_F1
        GLFW_KEY_F2
        GLFW_KEY_F3
        GLFW_KEY_F4
        GLFW_KEY_F5
        GLFW_KEY_F6
        GLFW_KEY_F7
        GLFW_KEY_F8
        GLFW_KEY_F9
        GLFW_KEY_F10
        GLFW_KEY_F11
        GLFW_KEY_F12
        GLFW_KEY_F13
        GLFW_KEY_F14
        GLFW_KEY_F15
        GLFW_KEY_F16
        GLFW_KEY_F17
        GLFW_KEY_F18
        GLFW_KEY_F19
        GLFW_KEY_F20
        GLFW_KEY_F21
        GLFW_KEY_F22
        GLFW_KEY_F23
        GLFW_KEY_F24
        GLFW_KEY_F25
        GLFW_KEY_KP_0
        GLFW_KEY_KP_1
        GLFW_KEY_KP_2
        GLFW_KEY_KP_3
        GLFW_KEY_KP_4
        GLFW_KEY_KP_5
        GLFW_KEY_KP_6
        GLFW_KEY_KP_7
        GLFW_KEY_KP_8
        GLFW_KEY_KP_9
        GLFW_KEY_KP_DECIMAL
        GLFW_KEY_KP_DIVIDE
        GLFW_KEY_KP_MULTIPLY
        GLFW_KEY_KP_SUBTRACT
        GLFW_KEY_KP_ADD
        GLFW_KEY_KP_ENTER
        GLFW_KEY_KP_EQUAL
        GLFW_KEY_LEFT_SHIFT
        GLFW_KEY_LEFT_CONTROL
        GLFW_KEY_LEFT_ALT
        GLFW_KEY_LEFT_SUPER
        GLFW_KEY_RIGHT_SHIFT
        GLFW_KEY_RIGHT_CONTROL
        GLFW_KEY_RIGHT_ALT
        GLFW_KEY_RIGHT_SUPER
        GLFW_KEY_MENU
        GLFW_KEY_LAST
        
        # Mouse button definitions
        GLFW_MOUSE_BUTTON_1
        GLFW_MOUSE_BUTTON_2
        GLFW_MOUSE_BUTTON_3
        GLFW_MOUSE_BUTTON_4
        GLFW_MOUSE_BUTTON_5
        GLFW_MOUSE_BUTTON_6
        GLFW_MOUSE_BUTTON_7
        GLFW_MOUSE_BUTTON_8
        GLFW_MOUSE_BUTTON_LAST

        # Mouse button aliases
        GLFW_MOUSE_BUTTON_LEFT
        GLFW_MOUSE_BUTTON_RIGHT
        GLFW_MOUSE_BUTTON_MIDDLE

        # Joystick identifiers
        GLFW_JOYSTICK_1
        GLFW_JOYSTICK_2
        GLFW_JOYSTICK_3
        GLFW_JOYSTICK_4
        GLFW_JOYSTICK_5
        GLFW_JOYSTICK_6
        GLFW_JOYSTICK_7
        GLFW_JOYSTICK_8
        GLFW_JOYSTICK_9
        GLFW_JOYSTICK_10
        GLFW_JOYSTICK_11
        GLFW_JOYSTICK_12
        GLFW_JOYSTICK_13
        GLFW_JOYSTICK_14
        GLFW_JOYSTICK_15
        GLFW_JOYSTICK_16
        GLFW_JOYSTICK_LAST
        
        # glfwCreateWindow modes
        GLFW_WINDOWED
        GLFW_FULLSCREEN

        # glfwGetWindowParam tokens
        GLFW_ACTIVE
        GLFW_ICONIFIED
        GLFW_CLOSE_REQUESTED
        GLFW_OPENGL_REVISION

        # glfwWindowHint tokens
        GLFW_RED_BITS
        GLFW_GREEN_BITS
        GLFW_BLUE_BITS
        GLFW_ALPHA_BITS
        GLFW_DEPTH_BITS
        GLFW_STENCIL_BITS
        GLFW_REFRESH_RATE
        GLFW_ACCUM_RED_BITS
        GLFW_ACCUM_GREEN_BITS
        GLFW_ACCUM_BLUE_BITS
        GLFW_ACCUM_ALPHA_BITS
        GLFW_AUX_BUFFERS
        GLFW_STEREO
        GLFW_FSAA_SAMPLES

        # The following constants are used with both glfwGetWindowParam
        # and glfwWindowHint
        GLFW_CLIENT_API
        GLFW_OPENGL_VERSION_MAJOR
        GLFW_OPENGL_VERSION_MINOR
        GLFW_OPENGL_FORWARD_COMPAT
        GLFW_OPENGL_DEBUG_CONTEXT
        GLFW_OPENGL_PROFILE
        GLFW_OPENGL_ROBUSTNESS
        GLFW_RESIZABLE
        GLFW_VISIBLE

        # GLFW_CLIENT_API tokens
        GLFW_OPENGL_API
        GLFW_OPENGL_ES_API

        # GLFW_OPENGL_ROBUSTNESS mode tokens
        GLFW_OPENGL_NO_ROBUSTNESS
        GLFW_OPENGL_NO_RESET_NOTIFICATION
        GLFW_OPENGL_LOSE_CONTEXT_ON_RESET

        # GLFW_OPENGL_PROFILE bit tokens
        GLFW_OPENGL_NO_PROFILE
        GLFW_OPENGL_CORE_PROFILE
        GLFW_OPENGL_COMPAT_PROFILE

        # glfwGetInputMode/glfwSetInputMode tokens
        GLFW_CURSOR_MODE
        GLFW_STICKY_KEYS
        GLFW_STICKY_MOUSE_BUTTONS
        GLFW_SYSTEM_KEYS
        GLFW_KEY_REPEAT

        # GLFW_CURSOR_MODE values
        GLFW_CURSOR_NORMAL
        GLFW_CURSOR_HIDDEN
        GLFW_CURSOR_CAPTURED

        # glfwGetJoystickParam tokens
        GLFW_PRESENT
        GLFW_AXES
        GLFW_BUTTONS

        # glfwGetError/glfwErrorString tokens
        GLFW_NO_ERROR
        GLFW_NOT_INITIALIZED
        GLFW_NO_CURRENT_CONTEXT
        GLFW_INVALID_ENUM
        GLFW_INVALID_VALUE
        GLFW_OUT_OF_MEMORY
        GLFW_OPENGL_UNAVAILABLE
        GLFW_VERSION_UNAVAILABLE
        GLFW_PLATFORM_ERROR
        GLFW_WINDOW_NOT_ACTIVE
        GLFW_FORMAT_UNAVAILABLE

        # Gamma ramps
        GLFW_GAMMA_RAMP_SIZE
        
    # OpenGL function pointer type
    ctypedef void (*GLFWglproc)()
    
    # Window handle type
    ctypedef void* GLFWwindow

    # Function pointer types
    ctypedef void (* GLFWerrorfun)(int,char*)
    ctypedef void (* GLFWwindowsizefun)(GLFWwindow,int,int)
    ctypedef int  (* GLFWwindowclosefun)(GLFWwindow)
    ctypedef void (* GLFWwindowrefreshfun)(GLFWwindow)
    ctypedef void (* GLFWwindowfocusfun)(GLFWwindow,int)
    ctypedef void (* GLFWwindowiconifyfun)(GLFWwindow,int)
    ctypedef void (* GLFWmousebuttonfun)(GLFWwindow,int,int)
    ctypedef void (* GLFWcursorposfun)(GLFWwindow,int,int)
    ctypedef void (* GLFWcursorenterfun)(GLFWwindow,int)
    ctypedef void (* GLFWscrollfun)(GLFWwindow,double,double)
    ctypedef void (* GLFWkeyfun)(GLFWwindow,int,int)
    ctypedef void (* GLFWcharfun)(GLFWwindow,int)
    
    
    # The video mode structure used by glfwGetVideoModes
    cdef struct _GLFWvidmode:
        int width
        int height
        int redBits
        int blueBits
        int greenBits
    
    ctypedef _GLFWvidmode GLFWvidmode
    
    # Gamma ramp
    cdef struct _GLFWgammaramp:
        unsigned short red[GLFW_GAMMA_RAMP_SIZE]
        unsigned short green[GLFW_GAMMA_RAMP_SIZE]
        unsigned short blue[GLFW_GAMMA_RAMP_SIZE]
    
    ctypedef _GLFWgammaramp GLFWgammaramp

    # Initialization, termination and version querying
    int  glfwInit()
    void glfwTerminate()
    void glfwGetVersion(int* major, int* minor, int* rev)
    char* glfwGetVersionString()

    # Error handling
    int glfwGetError()
    char* glfwErrorString(int error)
    void glfwSetErrorCallback(GLFWerrorfun cbfun)

    # Video mode functions
    GLFWvidmode* glfwGetVideoModes(int* count)
    void glfwGetDesktopMode(GLFWvidmode* mode)

    # Gamma ramp functions
    void glfwSetGamma(float gamma)
    void glfwGetGammaRamp(GLFWgammaramp* ramp)
    void glfwSetGammaRamp(GLFWgammaramp* ramp)
    
    # Window handling
    void glfwWindowHint(int target, int hint)
    GLFWwindow glfwCreateWindow(int width, int height, int mode, char* title, GLFWwindow share)
    void glfwDestroyWindow(GLFWwindow window)
    void glfwSetWindowTitle(GLFWwindow window, char* title)
    void glfwGetWindowSize(GLFWwindow window, int* width, int* height)
    void glfwSetWindowSize(GLFWwindow window, int width, int height)
    void glfwGetWindowPos(GLFWwindow window, int* xpos, int* ypos)
    void glfwSetWindowPos(GLFWwindow window, int xpos, int ypos)
    void glfwIconifyWindow(GLFWwindow window)
    void glfwRestoreWindow(GLFWwindow window)
    void glfwShowWindow(GLFWwindow window)
    void glfwHideWindow(GLFWwindow window)
    int  glfwGetWindowParam(GLFWwindow window, int param)
    void glfwSetWindowUserPointer(GLFWwindow window, void* pointer)
    void* glfwGetWindowUserPointer(GLFWwindow window)
    void glfwSetWindowSizeCallback(GLFWwindow window, GLFWwindowsizefun cbfun)
    void glfwSetWindowCloseCallback(GLFWwindow window, GLFWwindowclosefun cbfun)
    void glfwSetWindowRefreshCallback(GLFWwindow window, GLFWwindowrefreshfun cbfun)
    void glfwSetWindowFocusCallback(GLFWwindow window, GLFWwindowfocusfun cbfun)
    void glfwSetWindowIconifyCallback(GLFWwindow window, GLFWwindowiconifyfun cbfun)
    
    # Event handling
    void glfwPollEvents()
    void glfwWaitEvents()

    # Input handling
    int  glfwGetInputMode(GLFWwindow window, int mode)
    void glfwSetInputMode(GLFWwindow window, int mode, int value)
    int  glfwGetKey(GLFWwindow window, int key)
    int  glfwGetMouseButton(GLFWwindow window, int button)
    void glfwGetCursorPos(GLFWwindow window, int* xpos, int* ypos)
    void glfwSetCursorPos(GLFWwindow window, int xpos, int ypos)
    void glfwGetScrollOffset(GLFWwindow window, double* xoffset, double* yoffset)
    void glfwSetKeyCallback(GLFWwindow window, GLFWkeyfun cbfun)
    void glfwSetCharCallback(GLFWwindow window, GLFWcharfun cbfun)
    void glfwSetMouseButtonCallback(GLFWwindow window, GLFWmousebuttonfun cbfun)
    void glfwSetCursorPosCallback(GLFWwindow window, GLFWcursorposfun cbfun)
    void glfwSetCursorEnterCallback(GLFWwindow window, GLFWcursorenterfun cbfun)
    void glfwSetScrollCallback(GLFWwindow window, GLFWscrollfun cbfun)

    # Joystick input
    int glfwGetJoystickParam(int joy, int param)
    int glfwGetJoystickAxes(int joy, float* axes, int numaxes)
    int glfwGetJoystickButtons(int joy, unsigned char* buttons, int numbuttons)

    # Clipboard
    void glfwSetClipboardString(GLFWwindow window, char* string)
    char* glfwGetClipboardString(GLFWwindow window)

    # Time
    double glfwGetTime()
    void   glfwSetTime(double time)

    # OpenGL support
    void glfwMakeContextCurrent(GLFWwindow window)
    GLFWwindow glfwGetCurrentContext()
    void  glfwSwapBuffers(GLFWwindow window)
    void  glfwSwapInterval(int interval)
    int   glfwExtensionSupported(char* extension)
    GLFWglproc glfwGetProcAddress(char* procname)
    void  glfwCopyContext(GLFWwindow src, GLFWwindow dst, unsigned long mask)