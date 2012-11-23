# -*- coding: utf-8 -*-
#
# This file is part of gltools - See LICENSE.txt
#

# general imports
IF UNAME_SYSNAME == "Windows":
    ctypedef unsigned int uintptr_t
ELSE:
    from libc.stdint cimport uintptr_t

cdef extern from *:
    ctypedef char const_char "const char"
    
from libc.stdlib cimport malloc, free

from libc.math cimport fabs, copysign
from libc.math cimport M_PI, sqrt, sin, cos, tan
    
cimport cpython.array

cdef inline double fmax(double a, double b):
    if a < b:
        return b
    return a

cdef inline double fmin(double a, double b):
    if a > b:
        return b
    return a
    
# utility to get pointer from memoryview
cdef void *getVoidPtr(arr):
    cdef double [::1] d_view
    cdef float [::1] f_view
    cdef long [::1] l_view
    cdef int [::1] i_view
    cdef unsigned int [::1] I_view
    cdef char [::1] b_view
    cdef unsigned char [::1] B_view
    cdef void *ptr
    
    try:
        d_view = arr
    except ValueError:
        pass
    else:
        ptr = <void *>(&d_view[0])
        return ptr
    
    try:
        f_view = arr
    except ValueError:
        pass
    else:
        ptr = <void *>(&f_view[0])
        return ptr
    
    try:
        l_view = arr
    except ValueError:
        pass
    else:
        ptr = <void *>(&l_view[0])
        return ptr
    
    try:
        i_view = arr
    except ValueError:
        pass
    else:
        ptr = <void *>(&i_view[0])
        return ptr
    
    try:
        I_view = arr
    except ValueError:
        pass
    else:
        ptr = <void *>(&I_view[0])
        return ptr
        
    try:
        b_view = arr
    except ValueError:
        pass
    else:
        ptr = <void *>(&b_view[0])
        return ptr
    
    try:
        B_view = arr
    except ValueError:
        pass
    else:
        ptr = <void *>(&B_view[0])
        return ptr
        
    raise TypeError('no valid array type found')