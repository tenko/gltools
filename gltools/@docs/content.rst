GLTools
=======

ColorRGBA
---------
.. autoclass:: gltools.ColorRGBA
    :members:
    :special-members:

Material
--------
.. autoclass:: gltools.Material
    :members:
    :special-members:

Light
-----
.. autoclass:: gltools.Light
    :members:
    :special-members:

Image
-----
.. autoclass:: gltools.Image
    :members:
    :special-members:
    
TextureRect2D
-------------
.. autoclass:: gltools.TextureRect2D
    :members:
    :special-members:
    
ClientBuffer
------------
.. autoclass:: gltools.ClientBuffer
    :members:
    :special-members:
    
ShaderProgram
-------------
.. autoclass:: gltools.ShaderProgram
    :members:
    :special-members:

GLFW
----

.. autofunction:: gltools.Init

.. autofunction:: gltools.Terminate

.. autofunction:: gltools.GetTime

.. autofunction:: gltools.SetTime

.. autofunction:: gltools.SetGamma

.. autofunction:: gltools.GetDesktopSize

Window
------
.. autoclass:: gltools.Window
    :members:
    :special-members:
    
UI
--
.. autoclass:: gltools.UI
    :members:
    :special-members:

GLFW Constants
--------------

ACTION
^^^^^^
.. data:: gltools.ACTION.PRESS
.. data:: gltools.ACTION.RELEASE

MOUSE
^^^^^
.. data:: gltools.MOUSE.LEFT
.. data:: gltools.MOUSE.RIGHT
.. data:: gltools.MOUSE.MIDDLE

KEY
^^^
.. data:: gltools.KEY.SPACE
.. data:: gltools.KEY.ESCAPE
.. data:: gltools.KEY.ENTER
.. data:: gltools.KEY.TAB
.. data:: gltools.KEY.BACKSPACE
.. data:: gltools.KEY.INSERT
.. data:: gltools.KEY.DELETE
.. data:: gltools.KEY.RIGHT
.. data:: gltools.KEY.LEFT
.. data:: gltools.KEY.DOWN
.. data:: gltools.KEY.UP
.. data:: gltools.KEY.PAGE_UP
.. data:: gltools.KEY.PAGE_DOWN
.. data:: gltools.KEY.HOME
.. data:: gltools.KEY.END
.. data:: gltools.KEY.CAPS_LOCK
.. data:: gltools.KEY.SCROLL_LOCK
.. data:: gltools.KEY.NUM_LOCK
.. data:: gltools.KEY.PRINT_SCREEN
.. data:: gltools.KEY.PAUSE
.. data:: gltools.KEY.F1
.. data:: gltools.KEY.F2
.. data:: gltools.KEY.F3
.. data:: gltools.KEY.F4
.. data:: gltools.KEY.F5
.. data:: gltools.KEY.F6
.. data:: gltools.KEY.F7
.. data:: gltools.KEY.F8
.. data:: gltools.KEY.F9
.. data:: gltools.KEY.F10
.. data:: gltools.KEY.F11
.. data:: gltools.KEY.F12
.. data:: gltools.KEY.LEFT_SHIFT
.. data:: gltools.KEY.LEFT_CONTROL
.. data:: gltools.KEY.LEFT_ALT
.. data:: gltools.KEY.RIGHT_SHIFT
.. data:: gltools.KEY.RIGHT_CONTROL
.. data:: gltools.KEY.RIGHT_ALT

OpenGL
------
    
.. autofunction:: gltools.InitGLExt

.. autofunction:: gltools.Check

.. autofunction:: gltools.BeginText

.. autofunction:: gltools.DrawText

.. autofunction:: gltools.EndText

.. autofunction:: gltools.AmbientLight

.. autofunction:: gltools.BlendFunc

.. autofunction:: gltools.Clear

.. autofunction:: gltools.ClearColor

.. autofunction:: gltools.ClearDepth

.. autofunction:: gltools.Color

.. autofunction:: gltools.Disable

.. autofunction:: gltools.DrawArrays

.. autofunction:: gltools.DrawElements

.. autofunction:: gltools.Hint

.. autofunction:: gltools.Enable

.. autofunction:: gltools.LineWidth

.. autofunction:: gltools.LightModeli

.. autofunction:: gltools.LoadIdentity

.. autofunction:: gltools.LoadMatrixd

.. autofunction:: gltools.MatrixMode

.. autofunction:: gltools.Ortho

.. autofunction:: gltools.PolygonMode

.. autofunction:: gltools.PolygonOffset

.. autofunction:: gltools.ReadPixel

.. autofunction:: gltools.ReadPixels

.. autofunction:: gltools.Viewport

OpenGL Constants
----------------

AlphaFunction
^^^^^^^^^^^^^
.. data:: gltools.NEVER
.. data:: gltools.LESS
.. data:: gltools.EQUAL
.. data:: gltools.LEQUAL
.. data:: gltools.GREATER
.. data:: gltools.NOTEQUAL
.. data:: gltools.GEQUAL
.. data:: gltools.ALWAYS

AttribMask
^^^^^^^^^^
.. data:: gltools.CURRENT_BIT
.. data:: gltools.POINT_BIT
.. data:: gltools.LINE_BIT
.. data:: gltools.POLYGON_BIT
.. data:: gltools.POLYGON_STIPPLE_BIT
.. data:: gltools.PIXEL_MODE_BIT
.. data:: gltools.LIGHTING_BIT
.. data:: gltools.FOG_BIT
.. data:: gltools.DEPTH_BUFFER_BIT
.. data:: gltools.ACCUM_BUFFER_BIT
.. data:: gltools.STENCIL_BUFFER_BIT
.. data:: gltools.VIEWPORT_BIT
.. data:: gltools.TRANSFORM_BIT
.. data:: gltools.ENABLE_BIT
.. data:: gltools.COLOR_BUFFER_BIT
.. data:: gltools.HINT_BIT
.. data:: gltools.EVAL_BIT
.. data:: gltools.LIST_BIT
.. data:: gltools.TEXTURE_BIT
.. data:: gltools.SCISSOR_BIT
.. data:: gltools.ALL_ATTRIB_BITS

BeginMode
^^^^^^^^^
.. data:: gltools.POINTS
.. data:: gltools.LINES
.. data:: gltools.LINE_LOOP
.. data:: gltools.LINE_STRIP
.. data:: gltools.TRIANGLES
.. data:: gltools.TRIANGLE_STRIP
.. data:: gltools.TRIANGLE_FAN
.. data:: gltools.QUADS
.. data:: gltools.QUAD_STRIP
.. data:: gltools.POLYGON

Vertex Arrays
^^^^^^^^^^^^^
.. data:: gltools.VERTEX_ARRAY
.. data:: gltools.NORMAL_ARRAY
.. data:: gltools.COLOR_ARRAY
.. data:: gltools.INDEX_ARRAY
.. data:: gltools.TEXTURE_COORD_ARRAY
.. data:: gltools.EDGE_FLAG_ARRAY
        
BlendingFactorDest
^^^^^^^^^^^^^^^^^^
.. data:: gltools.ZERO
.. data:: gltools.ONE
.. data:: gltools.SRC_COLOR
.. data:: gltools.ONE_MINUS_SRC_COLOR
.. data:: gltools.SRC_ALPHA
.. data:: gltools.ONE_MINUS_SRC_ALPHA
.. data:: gltools.DST_ALPHA
.. data:: gltools.ONE_MINUS_DST_ALPHA

BlendingFactorSrc
^^^^^^^^^^^^^^^^^
.. data:: gltools.DST_COLOR
.. data:: gltools.ONE_MINUS_DST_COLOR
.. data:: gltools.SRC_ALPHA_SATURATE

Boolean values
^^^^^^^^^^^^^^
.. data:: gltools.FALSE
.. data:: gltools.TRUE

Datatypes
^^^^^^^^^
.. data:: gltools.BYTE
.. data:: gltools.UNSIGNED_BYTE
.. data:: gltools.SHORT
.. data:: gltools.UNSIGNED_SHORT
.. data:: gltools.INT
.. data:: gltools.UNSIGNED_INT
.. data:: gltools.FLOAT
.. data:: gltools.DOUBLE
        
DrawBufferMode
^^^^^^^^^^^^^^
.. data:: gltools.NONE
.. data:: gltools.FRONT_LEFT
.. data:: gltools.FRONT_RIGHT
.. data:: gltools.BACK_LEFT
.. data:: gltools.BACK_RIGHT
.. data:: gltools.FRONT
.. data:: gltools.BACK
.. data:: gltools.LEFT
.. data:: gltools.RIGHT
.. data:: gltools.FRONT_AND_BACK
.. data:: gltools.AUX0
.. data:: gltools.AUX1
.. data:: gltools.AUX2
.. data:: gltools.AUX3
.. data:: gltools.CW
.. data:: gltools.CCW

GetTarget
^^^^^^^^^
.. data:: gltools.DEPTH_TEST
.. data:: gltools.BLEND
.. data:: gltools.DITHER
.. data:: gltools.CULL_FACE

MatrixMode
^^^^^^^^^^
.. data:: gltools.MODELVIEW
.. data:: gltools.PROJECTION
.. data:: gltools.TEXTURE

Lines
^^^^^
.. data:: gltools.LINE_SMOOTH

PolygonMode
^^^^^^^^^^^
.. data:: gltools.POINT
.. data:: gltools.LINE
.. data:: gltools.FILL
.. data:: gltools.POLYGON_OFFSET_LINE
.. data:: gltools.POLYGON_OFFSET_FILL

ShadingModel
^^^^^^^^^^^^
.. data:: gltools.FLAT
.. data:: gltools.SMOOTH

Hints
^^^^^
.. data:: gltools.PERSPECTIVE_CORRECTION_HINT
.. data:: gltools.POINT_SMOOTH_HINT
.. data:: gltools.LINE_SMOOTH_HINT
.. data:: gltools.POLYGON_SMOOTH_HINT
.. data:: gltools.FOG_HINT
.. data:: gltools.DONT_CARE
.. data:: gltools.FASTEST
.. data:: gltools.NICEST
        
Lighting
^^^^^^^^
.. data:: gltools.LIGHTING
.. data:: gltools.LIGHT0
.. data:: gltools.LIGHT1
.. data:: gltools.LIGHT2
.. data:: gltools.LIGHT3
.. data:: gltools.LIGHT4
.. data:: gltools.LIGHT5
.. data:: gltools.LIGHT6
.. data:: gltools.LIGHT7
.. data:: gltools.LIGHT_MODEL_TWO_SIDE

Images
^^^^^^
.. data:: gltools.RGB
.. data:: gltools.RGBA

Texture
^^^^^^^
.. data:: gltools.TEXTURE_2D

GLEXT
^^^^^
.. data:: gltools.MULTISAMPLE
.. data:: gltools.STATIC_DRAW
.. data:: gltools.ARRAY_BUFFER
.. data:: gltools.ELEMENT_ARRAY_BUFFER