from flint.flint_base.flint_base cimport flint_scalar
from flint.flintlib.fmpz cimport fmpz_t
from flint.flintlib.fmpz_mod cimport (
    fmpz_mod_ctx_t,
    fmpz_mod_discrete_log_pohlig_hellman_t
)


cdef class fmpz_mod_ctx:
    cdef fmpz_mod_ctx_t val
    cdef fmpz_mod_discrete_log_pohlig_hellman_t *L
    cdef any_as_fmpz_mod(self, obj)
    cdef _precompute_dlog_prime(self)
    
cdef class fmpz_mod(flint_scalar):
    cdef fmpz_mod_ctx ctx
    cdef fmpz_t val
    cdef fmpz_t *x_g
