from flint.flintlib.flint cimport ulong, slong, flint_rand_t
from flint.flintlib.fmpz cimport fmpz_t, fmpz_struct
from flint.flintlib.fmpz_mat cimport fmpz_mat_t, fmpz_mat_struct
from flint.flintlib.fmpz_poly cimport fmpz_poly_t, fmpz_poly_struct
from flint.flintlib.fmpz_mod cimport fmpz_mod_ctx_t, fmpz_mod_ctx_struct
from flint.flintlib.nmod_poly cimport nmod_poly_t

cdef extern from "flint/fmpz_mod_poly.h":
    #  Type definitions *********************************************************/
    ctypedef struct fmpz_mod_poly_struct:
        fmpz_struct * coeffs
        slong alloc
        slong length
    ctypedef fmpz_mod_poly_struct fmpz_mod_poly_t[1]

    ctypedef struct fmpz_mod_poly_res_struct:
        fmpz_t res
        fmpz_t lc
        slong len0
        slong len1
        slong off
    ctypedef fmpz_mod_poly_res_struct fmpz_mod_poly_res_t[1]

    ctypedef struct fmpz_mod_poly_frobenius_powers_2exp_struct:
        fmpz_mod_poly_struct * pow
        slong len
    ctypedef fmpz_mod_poly_frobenius_powers_2exp_struct fmpz_mod_poly_frobenius_powers_2exp_t[1]

    ctypedef struct fmpz_mod_poly_frobenius_powers_struct:
        fmpz_mod_poly_struct * pow
        slong len
    ctypedef fmpz_mod_poly_frobenius_powers_struct fmpz_mod_poly_frobenius_powers_t[1]

    ctypedef struct fmpz_mod_poly_matrix_precompute_arg_t:
        fmpz_mat_struct * A
        fmpz_mod_poly_struct * poly1
        fmpz_mod_poly_struct * poly2
        fmpz_mod_poly_struct * poly2inv
        const fmpz_mod_ctx_struct * ctx

    ctypedef struct fmpz_mod_poly_compose_mod_precomp_preinv_arg_t:
        fmpz_mat_struct * A
        fmpz_mod_poly_struct * res
        fmpz_mod_poly_struct * poly1
        fmpz_mod_poly_struct * poly3
        fmpz_mod_poly_struct * poly3inv
        const fmpz_mod_ctx_struct * ctx

    # Radix conversion *********************************************************/
    ctypedef struct fmpz_mod_poly_radix_struct:
        fmpz_struct *V
        fmpz_struct *W
        fmpz_struct **Rpow
        fmpz_struct **Rinv
        slong degR
        slong k
        fmpz_struct invL
    ctypedef fmpz_mod_poly_radix_struct fmpz_mod_poly_radix_t[1]

    # Berlekamp-Massey Algorithm - see fmpz_mod_poly/berlekamp_massey.c for more info ********/
    ctypedef struct fmpz_mod_berlekamp_massey_struct:
        slong npoints
        fmpz_mod_poly_t R0, R1
        fmpz_mod_poly_t V0, V1
        fmpz_mod_poly_t qt, rt
        fmpz_mod_poly_t points
    ctypedef fmpz_mod_berlekamp_massey_struct fmpz_mod_berlekamp_massey_t[1]

    # Parsed from here
    # Memory Management
    void fmpz_mod_poly_init(fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_init2(fmpz_mod_poly_t poly, slong alloc, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_clear(fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_realloc(fmpz_mod_poly_t poly, slong alloc, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_fit_length(fmpz_mod_poly_t poly, slong len, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_normalise(fmpz_mod_poly_t poly)
    void _fmpz_mod_poly_set_length(fmpz_mod_poly_t poly, slong len)
    void fmpz_mod_poly_truncate(fmpz_mod_poly_t poly, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_set_trunc(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, slong n, const fmpz_mod_ctx_t ctx)
    
    # Randomisation
    void fmpz_mod_poly_randtest(fmpz_mod_poly_t f, flint_rand_t state, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_randtest_irreducible(fmpz_mod_poly_t f, flint_rand_t state, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_randtest_not_zero(fmpz_mod_poly_t f, flint_rand_t state, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_randtest_monic(fmpz_mod_poly_t poly, flint_rand_t state, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_randtest_monic_irreducible(fmpz_mod_poly_t poly, flint_rand_t state, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_randtest_monic_primitive(fmpz_mod_poly_t poly, flint_rand_t state, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_randtest_trinomial(fmpz_mod_poly_t poly, flint_rand_t state, slong len, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_randtest_trinomial_irreducible(fmpz_mod_poly_t poly, flint_rand_t state, slong len, slong max_attempts, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_randtest_pentomial(fmpz_mod_poly_t poly, flint_rand_t state, slong len, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_randtest_pentomial_irreducible(fmpz_mod_poly_t poly, flint_rand_t state, slong len, slong max_attempts, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_randtest_sparse_irreducible(fmpz_mod_poly_t poly, flint_rand_t state, slong len, const fmpz_mod_ctx_t ctx)
    
    # Attributes
    slong fmpz_mod_poly_degree(const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    slong fmpz_mod_poly_length(const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    fmpz_struct * fmpz_mod_poly_lead(const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    
    # Assignment and Basic Manipulation
    void fmpz_mod_poly_set(fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_swap(fmpz_mod_poly_t poly1, fmpz_mod_poly_t poly2, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_zero(fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_one(fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_zero_coeffs(fmpz_mod_poly_t poly, slong i, slong j, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_reverse(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, slong n, const fmpz_mod_ctx_t ctx)
    
    # Conversion
    void fmpz_mod_poly_set_ui(fmpz_mod_poly_t f, ulong c, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_set_fmpz(fmpz_mod_poly_t f, const fmpz_t c, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_set_fmpz_poly(fmpz_mod_poly_t f, const fmpz_poly_t g, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_get_fmpz_poly(fmpz_poly_t f, const fmpz_mod_poly_t g, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_get_nmod_poly(nmod_poly_t f, const fmpz_mod_poly_t g)
    void fmpz_mod_poly_set_nmod_poly(fmpz_mod_poly_t f, const nmod_poly_t g)
    
    # Comparison
    int fmpz_mod_poly_equal(const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_equal_trunc(const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, slong n, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_is_zero(const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_is_one(const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_is_gen(const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    
    # Getting and Setting coefficients
    void fmpz_mod_poly_set_coeff_fmpz(fmpz_mod_poly_t poly, slong n, const fmpz_t x, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_set_coeff_ui(fmpz_mod_poly_t poly, slong n, ulong x, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_get_coeff_fmpz(fmpz_t x, const fmpz_mod_poly_t poly, slong n, const fmpz_mod_ctx_t ctx)
    # void fmpz_mod_poly_set_coeff_mpz(fmpz_mod_poly_t poly, slong n, const mpz_t x, const fmpz_mod_ctx_t ctx)
    # void fmpz_mod_poly_get_coeff_mpz(mpz_t x, const fmpz_mod_poly_t poly, slong n, const fmpz_mod_ctx_t ctx)
    
    # Shifiting
    void _fmpz_mod_poly_shift_left(fmpz_struct * res, const fmpz_struct * poly, slong len, slong n, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_shift_left(fmpz_mod_poly_t f, const fmpz_mod_poly_t g, slong n, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_shift_right(fmpz_struct * res, const fmpz_struct * poly, slong len, slong n, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_shift_right(fmpz_mod_poly_t f, const fmpz_mod_poly_t g, slong n, const fmpz_mod_ctx_t ctx)
    
    # Addition and Subtraction
    void _fmpz_mod_poly_add(fmpz_struct *res, const fmpz_struct *poly1, slong len1, const fmpz_struct *poly2, slong len2, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_add(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_add_series(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, slong n, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_sub(fmpz_struct *res, const fmpz_struct *poly1, slong len1, const fmpz_struct *poly2, slong len2, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_sub(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_sub_series(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, slong n, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_neg(fmpz_struct *res, const fmpz_struct *poly, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_neg(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    
    # Scalar Multiplication and division
    void _fmpz_mod_poly_scalar_mul_fmpz(fmpz_struct *res, const fmpz_struct *poly, slong len, const fmpz_t x, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_scalar_mul_fmpz(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, const fmpz_t x, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_scalar_addmul_fmpz(fmpz_mod_poly_t rop, const fmpz_mod_poly_t op, const fmpz_t x, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_scalar_div_fmpz(fmpz_struct *res, const fmpz_struct *poly, slong len, const fmpz_t x, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_scalar_div_fmpz(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, const fmpz_t x, const fmpz_mod_ctx_t ctx)
    
    # Multiplication
    void _fmpz_mod_poly_mul(fmpz_struct *res, const fmpz_struct *poly1, slong len1, const fmpz_struct *poly2, slong len2, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_mul(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_mullow(fmpz_struct *res, const fmpz_struct *poly1, slong len1, const fmpz_struct *poly2, slong len2, const fmpz_t p, slong n)
    void fmpz_mod_poly_mullow(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, slong n, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_sqr(fmpz_struct *res, const fmpz_struct *poly, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_sqr(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_mulhigh(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, slong start, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_mulmod(fmpz_struct * res, const fmpz_struct * poly1, slong len1, const fmpz_struct * poly2, slong len2, const fmpz_struct * f, slong lenf, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_mulmod(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, const fmpz_mod_poly_t f, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_mulmod_preinv(fmpz_struct * res, const fmpz_struct * poly1, slong len1, const fmpz_struct * poly2, slong len2, const fmpz_struct * f, slong lenf, const fmpz_struct* finv, slong lenfinv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_mulmod_preinv(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, const fmpz_mod_poly_t f, const fmpz_mod_poly_t finv, const fmpz_mod_ctx_t ctx)
    
    # Products
    void _fmpz_mod_poly_product_roots_fmpz_vec(fmpz_struct * poly, const fmpz_struct * xs, slong n, fmpz_t f)
    void fmpz_mod_poly_product_roots_fmpz_vec(fmpz_mod_poly_t poly, const fmpz_struct * xs, slong n, fmpz_t f, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_find_distinct_nonzero_roots(fmpz_struct * roots, const fmpz_mod_poly_t A, const fmpz_mod_ctx_t ctx)
    
    # Powering
    void _fmpz_mod_poly_pow(fmpz_struct *rop, const fmpz_struct *op, slong len, ulong e, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_pow(fmpz_mod_poly_t rop, const fmpz_mod_poly_t op, ulong e, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_pow_trunc(fmpz_struct * res, const fmpz_struct * poly, ulong e, slong trunc, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_pow_trunc(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, ulong e, slong trunc, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_pow_trunc_binexp(fmpz_struct * res, const fmpz_struct * poly, ulong e, slong trunc, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_pow_trunc_binexp(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, ulong e, slong trunc, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_powmod_ui_binexp(fmpz_struct * res, const fmpz_struct * poly, ulong e, const fmpz_struct * f, slong lenf, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_powmod_ui_binexp(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, ulong e, const fmpz_mod_poly_t f, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_powmod_ui_binexp_preinv(fmpz_struct * res, const fmpz_struct * poly, ulong e, const fmpz_struct * f, slong lenf, const fmpz_struct * finv, slong lenfinv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_powmod_ui_binexp_preinv(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, ulong e, const fmpz_mod_poly_t f, const fmpz_mod_poly_t finv, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_powmod_fmpz_binexp(fmpz_struct * res, const fmpz_struct * poly, const fmpz_t e, const fmpz_struct * f, slong lenf, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_powmod_fmpz_binexp(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, const fmpz_t e, const fmpz_mod_poly_t f, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_powmod_fmpz_binexp_preinv(fmpz_struct * res, const fmpz_struct * poly, const fmpz_t e, const fmpz_struct * f, slong lenf, const fmpz_struct* finv, slong lenfinv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_powmod_fmpz_binexp_preinv(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, const fmpz_t e, const fmpz_mod_poly_t f, const fmpz_mod_poly_t finv, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_powmod_x_fmpz_preinv(fmpz_struct * res, const fmpz_t e, const fmpz_struct * f, slong lenf, const fmpz_struct* finv, slong lenfinv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_powmod_x_fmpz_preinv(fmpz_mod_poly_t res, const fmpz_t e, const fmpz_mod_poly_t f, const fmpz_mod_poly_t finv, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_powers_mod_preinv_naive(fmpz_struct ** res, const fmpz_struct * f, slong flen, slong n, const fmpz_struct * g, slong glen, const fmpz_struct * ginv, slong ginvlen, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_powers_mod_naive(fmpz_mod_poly_struct * res, const fmpz_mod_poly_t f, slong n, const fmpz_mod_poly_t g, const fmpz_mod_ctx_t ctx)
    # void _fmpz_mod_poly_powers_mod_preinv_threaded_pool(fmpz_struct ** res, const fmpz_struct * f, slong flen, slong n, const fmpz_struct * g, slong glen, const fmpz_struct * ginv, slong ginvlen, const fmpz_t p, thread_pool_handle * threads, slong num_threads)
    void fmpz_mod_poly_powers_mod_bsgs(fmpz_mod_poly_struct * res, const fmpz_mod_poly_t f, slong n, const fmpz_mod_poly_t g, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_frobenius_powers_2exp_precomp( fmpz_mod_poly_frobenius_powers_2exp_t pow, const fmpz_mod_poly_t f, const fmpz_mod_poly_t finv, ulong m, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_frobenius_powers_2exp_clear(fmpz_mod_poly_frobenius_powers_2exp_t pow, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_frobenius_power(fmpz_mod_poly_t res, fmpz_mod_poly_frobenius_powers_2exp_t pow, const fmpz_mod_poly_t f, ulong m, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_frobenius_powers_precomp(fmpz_mod_poly_frobenius_powers_t pow, const fmpz_mod_poly_t f, const fmpz_mod_poly_t finv, ulong m, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_frobenius_powers_clear(fmpz_mod_poly_frobenius_powers_t pow, const fmpz_mod_ctx_t ctx)
    
    # Division
    void _fmpz_mod_poly_divrem_basecase(fmpz_struct * Q, fmpz_struct * R, const fmpz_struct * A, slong lenA, const fmpz_struct * B, slong lenB, const fmpz_t invB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_divrem_basecase(fmpz_mod_poly_t Q, fmpz_mod_poly_t R, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_divrem_newton_n_preinv (fmpz_struct* Q, fmpz_struct* R, const fmpz_struct* A, slong lenA, const fmpz_struct* B, slong lenB, const fmpz_struct* Binv, slong lenBinv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_divrem_newton_n_preinv(fmpz_mod_poly_t Q, fmpz_mod_poly_t R, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_poly_t Binv, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_div_newton_n_preinv (fmpz_struct* Q, const fmpz_struct* A, slong lenA, const fmpz_struct* B, slong lenB, const fmpz_struct* Binv, slong lenBinv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_div_newton_n_preinv(fmpz_mod_poly_t Q, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_poly_t Binv, const fmpz_mod_ctx_t ctx)
    ulong fmpz_mod_poly_remove(fmpz_mod_poly_t f, const fmpz_mod_poly_t g, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_rem_basecase(fmpz_struct * R, const fmpz_struct * A, slong lenA, const fmpz_struct * B, slong lenB, const fmpz_t invB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_rem_basecase(fmpz_mod_poly_t R, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_div(fmpz_struct * Q, const fmpz_struct * A, slong lenA, const fmpz_struct * B, slong lenB, const fmpz_t invB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_div(fmpz_mod_poly_t Q, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_divrem(fmpz_struct * Q, fmpz_struct * R, const fmpz_struct * A, slong lenA, const fmpz_struct * B, slong lenB, const fmpz_t invB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_divrem(fmpz_mod_poly_t Q, fmpz_mod_poly_t R, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_divrem_f(fmpz_t f, fmpz_mod_poly_t Q, fmpz_mod_poly_t R, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_rem(fmpz_struct *R, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_t invB, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_rem_f(fmpz_t f, fmpz_struct *R, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_t invB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_rem_f(fmpz_t f, fmpz_mod_poly_t R, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_rem(fmpz_mod_poly_t R, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    
    # Divisibility testing
    int _fmpz_mod_poly_divides_classical(fmpz_struct * Q, const fmpz_struct * A, slong lenA, const fmpz_struct * B, slong lenB, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_divides_classical(fmpz_mod_poly_t Q, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, fmpz_mod_ctx_t ctx)
    int _fmpz_mod_poly_divides(fmpz_struct * Q, const fmpz_struct * A, slong lenA, const fmpz_struct * B, slong lenB, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_divides(fmpz_mod_poly_t Q, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, fmpz_mod_ctx_t ctx)
    
    # Power series division
    void _fmpz_mod_poly_inv_series(fmpz_struct * Qinv, const fmpz_struct * Q, slong n, const fmpz_t cinv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_inv_series(fmpz_mod_poly_t Qinv, const fmpz_mod_poly_t Q, slong n, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_inv_series_f(fmpz_t f, fmpz_mod_poly_t Qinv, const fmpz_mod_poly_t Q, slong n, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_div_series(fmpz_struct * Q, const fmpz_struct * A, slong Alen, const fmpz_struct * B, slong Blen, const fmpz_t p, slong n)
    void fmpz_mod_poly_div_series(fmpz_mod_poly_t Q, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, slong n, const fmpz_mod_ctx_t ctx)
    
    # Greatest common divisor
    void fmpz_mod_poly_make_monic(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_make_monic_f(fmpz_t f, fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_gcd(fmpz_struct *G, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_t invB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_gcd(fmpz_mod_poly_t G, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_gcd_euclidean_f(fmpz_t f, fmpz_struct *G, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_gcd_euclidean_f(fmpz_t f, fmpz_mod_poly_t G, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_gcd_f(fmpz_t f, fmpz_struct *G, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_gcd_f(fmpz_t f, fmpz_mod_poly_t G, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_hgcd(fmpz_struct **M, slong *lenM, fmpz_struct *A, slong *lenA, fmpz_struct *B, slong *lenB, const fmpz_struct *a, slong lena, const fmpz_struct *b, slong lenb, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_xgcd_euclidean_f(fmpz_t f, fmpz_struct *G, fmpz_struct *S, fmpz_struct *T, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_t invB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_xgcd_euclidean_f(fmpz_t f, fmpz_mod_poly_t G, fmpz_mod_poly_t S, fmpz_mod_poly_t T, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_xgcd(fmpz_struct *G, fmpz_struct *S, fmpz_struct *T, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_t invB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_xgcd(fmpz_mod_poly_t G, fmpz_mod_poly_t S, fmpz_mod_poly_t T, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_xgcd_f(fmpz_t f, fmpz_mod_poly_t G, fmpz_mod_poly_t S, fmpz_mod_poly_t T, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_gcdinv_euclidean(fmpz_struct *G, fmpz_struct *S, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_gcdinv_euclidean(fmpz_mod_poly_t G, fmpz_mod_poly_t S, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_gcdinv_euclidean_f(fmpz_t f, fmpz_struct *G, fmpz_struct *S, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_gcdinv_euclidean_f(fmpz_t f, fmpz_mod_poly_t G, fmpz_mod_poly_t S, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_gcdinv(fmpz_struct *G, fmpz_struct *S, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_gcdinv_f(fmpz_t f, fmpz_struct *G, fmpz_struct *S, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_gcdinv(fmpz_mod_poly_t G, fmpz_mod_poly_t S, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_gcdinv_f(fmpz_t f, fmpz_mod_poly_t G, fmpz_mod_poly_t S, const fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_ctx_t ctx)
    int _fmpz_mod_poly_invmod(fmpz_struct *A, const fmpz_struct *B, slong lenB, const fmpz_struct *P, slong lenP, const fmpz_mod_ctx_t ctx)
    int _fmpz_mod_poly_invmod_f(fmpz_t f, fmpz_struct *A, const fmpz_struct *B, slong lenB, const fmpz_struct *P, slong lenP, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_invmod(fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_poly_t P, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_invmod_f(fmpz_t f, fmpz_mod_poly_t A, const fmpz_mod_poly_t B, const fmpz_mod_poly_t P, const fmpz_mod_ctx_t ctx)
    
    # Minpoly
    slong _fmpz_mod_poly_minpoly_bm(fmpz_struct* poly, const fmpz_struct* seq, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_minpoly_bm(fmpz_mod_poly_t poly, const fmpz_struct* seq, slong len, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_minpoly_hgcd(fmpz_struct* poly, const fmpz_struct* seq, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_minpoly_hgcd(fmpz_mod_poly_t poly, const fmpz_struct* seq, slong len, const fmpz_mod_ctx_t ctx)
    slong _fmpz_mod_poly_minpoly(fmpz_struct* poly, const fmpz_struct* seq, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_minpoly(fmpz_mod_poly_t poly, const fmpz_struct* seq, slong len, const fmpz_mod_ctx_t ctx)
    
    # Resultant
    void _fmpz_mod_poly_resultant_euclidean(fmpz_t res, const fmpz_struct *poly1, slong len1, const fmpz_struct *poly2, slong len2, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_resultant_euclidean(fmpz_t r, const fmpz_mod_poly_t f, const fmpz_mod_poly_t g, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_resultant_hgcd(fmpz_t res, const fmpz_struct *A, slong lenA, const fmpz_struct *B, slong lenB, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_resultant_hgcd(fmpz_t res, const fmpz_mod_poly_t f, const fmpz_mod_poly_t g, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_resultant(fmpz_t res, const fmpz_struct *poly1, slong len1, const fmpz_struct *poly2, slong len2, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_resultant(fmpz_t res, const fmpz_mod_poly_t f, const fmpz_mod_poly_t g, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_discriminant(fmpz_t d, const fmpz_struct *poly, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_discriminant(fmpz_t d, const fmpz_mod_poly_t f, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_derivative(fmpz_struct *res, const fmpz_struct *poly, slong len, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_derivative(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_evaluate_fmpz(fmpz_t res, const fmpz_struct *poly, slong len, const fmpz_t a, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_evaluate_fmpz(fmpz_t res, const fmpz_mod_poly_t poly, const fmpz_t a, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_evaluate_fmpz_vec_iter(fmpz_struct * ys, const fmpz_struct * coeffs, slong len, const fmpz_struct * xs, slong n, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_evaluate_fmpz_vec_iter(fmpz_struct * ys, const fmpz_mod_poly_t poly, const fmpz_struct * xs, slong n, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_evaluate_fmpz_vec_fast_precomp(fmpz_struct * vs, const fmpz_struct * poly, slong plen, fmpz_poly_struct * const * tree, slong len, const fmpz_mod_ctx_t ctx)    
    void _fmpz_mod_poly_evaluate_fmpz_vec_fast(fmpz_struct * ys, const fmpz_struct * poly, slong plen, const fmpz_struct * xs, slong n, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_evaluate_fmpz_vec_fast(fmpz_struct * ys, const fmpz_mod_poly_t poly, const fmpz_struct * xs, slong n, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_evaluate_fmpz_vec(fmpz_struct * ys, const fmpz_struct * coeffs, slong len, const fmpz_struct * xs, slong n, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_evaluate_fmpz_vec(fmpz_struct * ys, const fmpz_mod_poly_t poly, const fmpz_struct * xs, slong n, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_compose(fmpz_struct *res, const fmpz_struct *poly1, slong len1, const fmpz_struct *poly2, slong len2, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_compose(fmpz_mod_poly_t res, const fmpz_mod_poly_t poly1, const fmpz_mod_poly_t poly2, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_invsqrt_series(fmpz_struct * g, const fmpz_struct * h, slong hlen, slong n, fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_invsqrt_series(fmpz_mod_poly_t g, const fmpz_mod_poly_t h, slong n, fmpz_mod_ctx_t ctx) # TODO: Typo: fmpz_ctx_t should be fmpz_mod_ctx_t
    void _fmpz_mod_poly_sqrt_series(fmpz_struct * g, const fmpz_struct * h, slong hlen, slong n, fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_sqrt_series(fmpz_mod_poly_t g, const fmpz_mod_poly_t h, slong n, fmpz_mod_ctx_t ctx)
    int _fmpz_mod_poly_sqrt(fmpz_struct * s, const fmpz_struct * p, slong n, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_sqrt(fmpz_mod_poly_t s, const fmpz_mod_poly_t p, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_compose_mod(fmpz_struct * res, const fmpz_struct * f, slong lenf, const fmpz_struct * g, const fmpz_struct * h, slong lenh, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_compose_mod(fmpz_mod_poly_t res, const fmpz_mod_poly_t f, const fmpz_mod_poly_t g, const fmpz_mod_poly_t h, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_compose_mod_horner(fmpz_struct * res, const fmpz_struct * f, slong lenf, const fmpz_struct * g, const fmpz_struct * h, slong lenh, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_compose_mod_horner(fmpz_mod_poly_t res, const fmpz_mod_poly_t f, const fmpz_mod_poly_t g, const fmpz_mod_poly_t h, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_compose_mod_brent_kung(fmpz_struct * res, const fmpz_struct * f, slong len1, const fmpz_struct * g, const fmpz_struct * h, slong len3, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_compose_mod_brent_kung(fmpz_mod_poly_t res, const fmpz_mod_poly_t f, const fmpz_mod_poly_t g, const fmpz_mod_poly_t h, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_reduce_matrix_mod_poly (fmpz_mat_t A, const fmpz_mat_t B, const fmpz_mod_poly_t f, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_precompute_matrix_worker(void * arg_ptr)
    void _fmpz_mod_poly_precompute_matrix (fmpz_mat_t A, const fmpz_struct * f, const fmpz_struct * g, slong leng, const fmpz_struct * ginv, slong lenginv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_precompute_matrix(fmpz_mat_t A, const fmpz_mod_poly_t f, const fmpz_mod_poly_t g, const fmpz_mod_poly_t ginv, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_compose_mod_brent_kung_precomp_preinv_worker(void * arg_ptr)
    void _fmpz_mod_poly_compose_mod_brent_kung_precomp_preinv(fmpz_struct * res, const fmpz_struct * f, slong lenf, const fmpz_mat_t A, const fmpz_struct * h, slong lenh, const fmpz_struct * hinv, slong lenhinv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_compose_mod_brent_kung_precomp_preinv(fmpz_mod_poly_t res, const fmpz_mod_poly_t f, const fmpz_mat_t A, const fmpz_mod_poly_t h, const fmpz_mod_poly_t hinv, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_compose_mod_brent_kung_preinv(fmpz_struct * res, const fmpz_struct * f, slong lenf, const fmpz_struct * g, const fmpz_struct * h, slong lenh, const fmpz_struct * hinv, slong lenhinv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_compose_mod_brent_kung_preinv(fmpz_mod_poly_t res, const fmpz_mod_poly_t f, const fmpz_mod_poly_t g, const fmpz_mod_poly_t h, const fmpz_mod_poly_t hinv, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_compose_mod_brent_kung_vec_preinv(fmpz_mod_poly_struct * res, const fmpz_mod_poly_struct * polys, slong len1, slong l, const fmpz_struct * g, slong glen, const fmpz_struct * h, slong lenh, const fmpz_struct * hinv, slong lenhinv, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_compose_mod_brent_kung_vec_preinv(fmpz_mod_poly_struct * res, const fmpz_mod_poly_struct * polys, slong len1, slong n, const fmpz_mod_poly_t g, const fmpz_mod_poly_t h, const fmpz_mod_poly_t hinv, const fmpz_mod_ctx_t ctx)
    # void _fmpz_mod_poly_compose_mod_brent_kung_vec_preinv_threaded_pool(fmpz_mod_poly_struct * res, const fmpz_mod_poly_struct * polys, slong lenpolys, slong l, const fmpz_struct * g, slong glen, const fmpz_struct * poly, slong len, const fmpz_struct * polyinv, slong leninv, const fmpz_t p, thread_pool_handle * threads, slong num_threads)
    # void fmpz_mod_poly_compose_mod_brent_kung_vec_preinv_threaded_pool(fmpz_mod_poly_struct * res,const fmpz_mod_poly_struct * polys, slong len1, slong n, const fmpz_mod_poly_t g, const fmpz_mod_poly_t poly, const fmpz_mod_poly_t polyinv, const fmpz_mod_ctx_t ctx, thread_pool_handle * threads, slong num_threads)
    void fmpz_mod_poly_compose_mod_brent_kung_vec_preinv_threaded(fmpz_mod_poly_struct * res, const fmpz_mod_poly_struct * polys, slong len1, slong n, const fmpz_mod_poly_t g, const fmpz_mod_poly_t poly, const fmpz_mod_poly_t polyinv, const fmpz_mod_ctx_t ctx)
    fmpz_poly_struct ** _fmpz_mod_poly_tree_alloc(slong len)
    void _fmpz_mod_poly_tree_free(fmpz_poly_struct ** tree, slong len)
    void _fmpz_mod_poly_tree_build(fmpz_poly_struct ** tree, const fmpz_struct * roots, slong len, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_radix_init(fmpz_struct **Rpow, fmpz_struct **Rinv, const fmpz_struct *R, slong lenR, slong k, const fmpz_t invL, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_radix_init(fmpz_mod_poly_radix_t D, const fmpz_mod_poly_t R, slong degF, const fmpz_mod_ctx_t ctx)
    void _fmpz_mod_poly_radix(fmpz_struct **B, const fmpz_struct *F, fmpz_struct **Rpow, fmpz_struct **Rinv, slong degR, slong k, slong i, fmpz_struct *W, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_radix(fmpz_mod_poly_struct **B, const fmpz_mod_poly_t F, const fmpz_mod_poly_radix_t D, const fmpz_mod_ctx_t ctx)
    # int _fmpz_mod_poly_fprint(FILE * file, const fmpz_struct *poly, slong len, const fmpz_mod_ctx_t ctx)
    # int fmpz_mod_poly_fprint(FILE * file, const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    # int fmpz_mod_poly_fprint_pretty(FILE * file, const fmpz_mod_poly_t poly, const char * x, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_print(const fmpz_mod_poly_t poly, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_poly_print_pretty(const fmpz_mod_poly_t poly, const char * x, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_inflate(fmpz_mod_poly_t result, const fmpz_mod_poly_t input, ulong inflation, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_poly_deflate(fmpz_mod_poly_t result, const fmpz_mod_poly_t input, ulong deflation, const fmpz_mod_ctx_t ctx)
    ulong fmpz_mod_poly_deflation(const fmpz_mod_poly_t input, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_berlekamp_massey_init(fmpz_mod_berlekamp_massey_t B, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_berlekamp_massey_clear(fmpz_mod_berlekamp_massey_t B, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_berlekamp_massey_start_over(fmpz_mod_berlekamp_massey_t B, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_berlekamp_massey_add_points(fmpz_mod_berlekamp_massey_t B, const fmpz_struct * a, slong count, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_berlekamp_massey_add_zeros(fmpz_mod_berlekamp_massey_t B, slong count, const fmpz_mod_ctx_t ctx)
    void fmpz_mod_berlekamp_massey_add_point(fmpz_mod_berlekamp_massey_t B, const fmpz_t a, const fmpz_mod_ctx_t ctx)
    int fmpz_mod_berlekamp_massey_reduce(fmpz_mod_berlekamp_massey_t B, const fmpz_mod_ctx_t ctx)
    slong fmpz_mod_berlekamp_massey_point_count(const fmpz_mod_berlekamp_massey_t B)
    const fmpz_struct * fmpz_mod_berlekamp_massey_points(const fmpz_mod_berlekamp_massey_t B)
    const fmpz_mod_poly_struct * fmpz_mod_berlekamp_massey_V_poly(const fmpz_mod_berlekamp_massey_t B)
    const fmpz_mod_poly_struct * fmpz_mod_berlekamp_massey_R_poly(const fmpz_mod_berlekamp_massey_t B)
