cdef class flint_elem:
    pass

cdef class flint_scalar(flint_elem):
    pass

cdef class flint_poly(flint_elem):
    pass

cdef class flint_mpoly_context(flint_elem):
    cdef public object py_names
    cdef const char ** c_names

cdef class flint_mpoly(flint_elem):
    pass

cdef class flint_mat(flint_elem):
    pass

cdef class flint_series(flint_elem):
    pass

cdef class flint_rational_function(flint_elem):
    pass
