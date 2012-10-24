# -*- coding: utf-8 -*-
# -*- coding: utf-8 -*-
cdef extern from "stb_image_write.h":
    int stbi_write_png(char *filename, int w, int h, int comp, void *data, int stride_in_bytes)