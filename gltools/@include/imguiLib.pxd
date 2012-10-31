cdef extern from "imguiRenderGL.h":
    bint imguiRenderGLInit()
    void imguiRenderGLDraw()

cdef extern from "imgui.h":
    cdef enum imguiMouseButton:
        IMGUI_MBUT_LEFT 
        IMGUI_MBUT_RIGHT
    
    cdef enum imguiTextAlign:
        IMGUI_ALIGN_LEFT
        IMGUI_ALIGN_CENTER
        IMGUI_ALIGN_RIGHT
    
    unsigned int imguiRGBA(unsigned char r, unsigned char g, unsigned char b, unsigned char a)
    
    bint imguiAnyActive()
    void imguiBeginFrame(int mx, int my, unsigned char mbut, int scroll)
    void imguiEndFrame()
    
    bint imguiBeginScrollArea(char* name, int x, int y, int w, int h, int* scroll)
    void imguiEndScrollArea()
    
    bint imguiBeginArea(char* name, int x, int y, int w, int h)
    void imguiEndArea()

    void imguiIndent()
    void imguiUnindent()
    void imguiSeparator()
    void imguiSeparatorLine()
    
    bint imguiButton(char* text, bint enabled, int x, int y, int w, int h)
    bint imguiItem(char* text, bint enabled)
    bint imguiCheck(char* text, bint checked, bint enabled)
    bint imguiCollapse(char* text, char* subtext, bint checked, bint enabled)
    void imguiLabel(char* text)
    void imguiValue(char* text)
    bint imguiSlider(char* text, float* val, float vmin, float vmax, float vinc, bint enabled)

    void imguiDrawText(int x, int y, int align, char* text, unsigned int color)
    void imguiDrawLine(float x0, float y0, float x1, float y1, float r, unsigned int color)
    void imguiDrawRoundedRect(float x, float y, float w, float h, float r, unsigned int color)
    void imguiDrawRect(float x, float y, float w, float h, unsigned int color)
    