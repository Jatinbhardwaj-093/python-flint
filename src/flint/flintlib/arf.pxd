from flint.flintlib.arb_types cimport mag_t
from flint.flintlib.arf_types cimport arf_rnd_t, arf_srcptr, arf_t
from flint.flintlib.flint cimport flint_rand_t, nn_ptr, nn_srcptr, slong, ulong
from flint.flintlib.fmpq cimport fmpq_t
from flint.flintlib.fmpz_types cimport fmpz_t

# unknown type FILE
# unknown type mpfr_rnd_t
# unknown type mpfr_t
# unknown type mpz_t

# .. macro:: ARF_RND_DOWN
# .. macro:: ARF_RND_UP
# .. macro:: ARF_RND_FLOOR
# .. macro:: ARF_RND_CEIL
# .. macro:: ARF_RND_NEAR
# .. macro:: ARF_PREC_EXACT

cdef extern from "flint/arf.h":
    void arf_init(arf_t x)
    void arf_clear(arf_t x)
    slong arf_allocated_bytes(const arf_t x)
    void arf_zero(arf_t res)
    void arf_one(arf_t res)
    void arf_pos_inf(arf_t res)
    void arf_neg_inf(arf_t res)
    void arf_nan(arf_t res)
    int arf_is_zero(const arf_t x)
    int arf_is_one(const arf_t x)
    int arf_is_pos_inf(const arf_t x)
    int arf_is_neg_inf(const arf_t x)
    int arf_is_nan(const arf_t x)
    int arf_is_inf(const arf_t x)
    int arf_is_normal(const arf_t x)
    int arf_is_special(const arf_t x)
    int arf_is_finite(const arf_t x)
    void arf_set(arf_t res, const arf_t x)
    # void arf_set_mpz(arf_t res, const mpz_t x)
    void arf_set_fmpz(arf_t res, const fmpz_t x)
    void arf_set_ui(arf_t res, ulong x)
    void arf_set_si(arf_t res, slong x)
    # void arf_set_mpfr(arf_t res, const mpfr_t x)
    void arf_set_d(arf_t res, double x)
    void arf_swap(arf_t x, arf_t y)
    void arf_init_set_ui(arf_t res, ulong x)
    void arf_init_set_si(arf_t res, slong x)
    int arf_set_round(arf_t res, const arf_t x, slong prec, arf_rnd_t rnd)
    int arf_set_round_si(arf_t res, slong x, slong prec, arf_rnd_t rnd)
    int arf_set_round_ui(arf_t res, ulong x, slong prec, arf_rnd_t rnd)
    # int arf_set_round_mpz(arf_t res, const mpz_t x, slong prec, arf_rnd_t rnd)
    int arf_set_round_fmpz(arf_t res, const fmpz_t x, slong prec, arf_rnd_t rnd)
    void arf_set_si_2exp_si(arf_t res, slong m, slong e)
    void arf_set_ui_2exp_si(arf_t res, ulong m, slong e)
    void arf_set_fmpz_2exp(arf_t res, const fmpz_t m, const fmpz_t e)
    int arf_set_round_fmpz_2exp(arf_t res, const fmpz_t x, const fmpz_t e, slong prec, arf_rnd_t rnd)
    void arf_get_fmpz_2exp(fmpz_t m, fmpz_t e, const arf_t x)
    void arf_frexp(arf_t m, fmpz_t e, const arf_t x)
    double arf_get_d(const arf_t x, arf_rnd_t rnd)
    # int arf_get_mpfr(mpfr_t res, const arf_t x, mpfr_rnd_t rnd)
    int arf_get_fmpz(fmpz_t res, const arf_t x, arf_rnd_t rnd)
    slong arf_get_si(const arf_t x, arf_rnd_t rnd)
    int arf_get_fmpz_fixed_fmpz(fmpz_t res, const arf_t x, const fmpz_t e)
    int arf_get_fmpz_fixed_si(fmpz_t res, const arf_t x, slong e)
    void arf_floor(arf_t res, const arf_t x)
    void arf_ceil(arf_t res, const arf_t x)
    void arf_get_fmpq(fmpq_t res, const arf_t x)
    int arf_equal(const arf_t x, const arf_t y)
    int arf_equal_si(const arf_t x, slong y)
    int arf_equal_ui(const arf_t x, ulong y)
    int arf_equal_d(const arf_t x, double y)
    int arf_cmp(const arf_t x, const arf_t y)
    int arf_cmp_si(const arf_t x, slong y)
    int arf_cmp_ui(const arf_t x, ulong y)
    int arf_cmp_d(const arf_t x, double y)
    int arf_cmpabs(const arf_t x, const arf_t y)
    int arf_cmpabs_ui(const arf_t x, ulong y)
    int arf_cmpabs_d(const arf_t x, double y)
    int arf_cmpabs_mag(const arf_t x, const mag_t y)
    int arf_cmp_2exp_si(const arf_t x, slong e)
    int arf_cmpabs_2exp_si(const arf_t x, slong e)
    int arf_sgn(const arf_t x)
    void arf_min(arf_t res, const arf_t a, const arf_t b)
    void arf_max(arf_t res, const arf_t a, const arf_t b)
    slong arf_bits(const arf_t x)
    int arf_is_int(const arf_t x)
    int arf_is_int_2exp_si(const arf_t x, slong e)
    void arf_abs_bound_lt_2exp_fmpz(fmpz_t res, const arf_t x)
    void arf_abs_bound_le_2exp_fmpz(fmpz_t res, const arf_t x)
    slong arf_abs_bound_lt_2exp_si(const arf_t x)
    void arf_get_mag(mag_t res, const arf_t x)
    void arf_get_mag_lower(mag_t res, const arf_t x)
    void arf_set_mag(arf_t res, const mag_t x)
    void mag_init_set_arf(mag_t res, const arf_t x)
    void mag_fast_init_set_arf(mag_t res, const arf_t x)
    void arf_mag_set_ulp(mag_t res, const arf_t x, slong prec)
    void arf_mag_add_ulp(mag_t res, const mag_t x, const arf_t y, slong prec)
    void arf_mag_fast_add_ulp(mag_t res, const mag_t x, const arf_t y, slong prec)
    void arf_init_set_shallow(arf_t z, const arf_t x)
    void arf_init_set_mag_shallow(arf_t z, const mag_t x)
    void arf_init_neg_shallow(arf_t z, const arf_t x)
    void arf_init_neg_mag_shallow(arf_t z, const mag_t x)
    void arf_randtest(arf_t res, flint_rand_t state, slong bits, slong mag_bits)
    void arf_randtest_not_zero(arf_t res, flint_rand_t state, slong bits, slong mag_bits)
    void arf_randtest_special(arf_t res, flint_rand_t state, slong bits, slong mag_bits)
    void arf_urandom(arf_t res, flint_rand_t state, slong bits, arf_rnd_t rnd)
    void arf_debug(const arf_t x)
    void arf_print(const arf_t x)
    void arf_printd(const arf_t x, slong d)
    char * arf_get_str(const arf_t x, slong d)
    # void arf_fprint(FILE * file, const arf_t x)
    # void arf_fprintd(FILE * file, const arf_t y, slong d)
    char * arf_dump_str(const arf_t x)
    int arf_load_str(arf_t x, const char * str)
    # int arf_dump_file(FILE * stream, const arf_t x)
    # int arf_load_file(arf_t x, FILE * stream)
    void arf_abs(arf_t res, const arf_t x)
    void arf_neg(arf_t res, const arf_t x)
    int arf_neg_round(arf_t res, const arf_t x, slong prec, arf_rnd_t rnd)
    int arf_add(arf_t res, const arf_t x, const arf_t y, slong prec, arf_rnd_t rnd)
    int arf_add_si(arf_t res, const arf_t x, slong y, slong prec, arf_rnd_t rnd)
    int arf_add_ui(arf_t res, const arf_t x, ulong y, slong prec, arf_rnd_t rnd)
    int arf_add_fmpz(arf_t res, const arf_t x, const fmpz_t y, slong prec, arf_rnd_t rnd)
    int arf_add_fmpz_2exp(arf_t res, const arf_t x, const fmpz_t y, const fmpz_t e, slong prec, arf_rnd_t rnd)
    int arf_sub(arf_t res, const arf_t x, const arf_t y, slong prec, arf_rnd_t rnd)
    int arf_sub_si(arf_t res, const arf_t x, slong y, slong prec, arf_rnd_t rnd)
    int arf_sub_ui(arf_t res, const arf_t x, ulong y, slong prec, arf_rnd_t rnd)
    int arf_sub_fmpz(arf_t res, const arf_t x, const fmpz_t y, slong prec, arf_rnd_t rnd)
    void arf_mul_2exp_si(arf_t res, const arf_t x, slong e)
    void arf_mul_2exp_fmpz(arf_t res, const arf_t x, const fmpz_t e)
    int arf_mul(arf_t res, const arf_t x, const arf_t y, slong prec, arf_rnd_t rnd)
    int arf_mul_ui(arf_t res, const arf_t x, ulong y, slong prec, arf_rnd_t rnd)
    int arf_mul_si(arf_t res, const arf_t x, slong y, slong prec, arf_rnd_t rnd)
    # int arf_mul_mpz(arf_t res, const arf_t x, const mpz_t y, slong prec, arf_rnd_t rnd)
    int arf_mul_fmpz(arf_t res, const arf_t x, const fmpz_t y, slong prec, arf_rnd_t rnd)
    int arf_addmul(arf_t z, const arf_t x, const arf_t y, slong prec, arf_rnd_t rnd)
    int arf_addmul_ui(arf_t z, const arf_t x, ulong y, slong prec, arf_rnd_t rnd)
    int arf_addmul_si(arf_t z, const arf_t x, slong y, slong prec, arf_rnd_t rnd)
    # int arf_addmul_mpz(arf_t z, const arf_t x, const mpz_t y, slong prec, arf_rnd_t rnd)
    int arf_addmul_fmpz(arf_t z, const arf_t x, const fmpz_t y, slong prec, arf_rnd_t rnd)
    int arf_submul(arf_t z, const arf_t x, const arf_t y, slong prec, arf_rnd_t rnd)
    int arf_submul_ui(arf_t z, const arf_t x, ulong y, slong prec, arf_rnd_t rnd)
    int arf_submul_si(arf_t z, const arf_t x, slong y, slong prec, arf_rnd_t rnd)
    # int arf_submul_mpz(arf_t z, const arf_t x, const mpz_t y, slong prec, arf_rnd_t rnd)
    int arf_submul_fmpz(arf_t z, const arf_t x, const fmpz_t y, slong prec, arf_rnd_t rnd)
    int arf_fma(arf_t res, const arf_t x, const arf_t y, const arf_t z, slong prec, arf_rnd_t rnd)
    int arf_sosq(arf_t res, const arf_t x, const arf_t y, slong prec, arf_rnd_t rnd)
    int arf_sum(arf_t res, arf_srcptr terms, slong len, slong prec, arf_rnd_t rnd)
    void arf_approx_dot(arf_t res, const arf_t initial, int subtract, arf_srcptr x, slong xstep, arf_srcptr y, slong ystep, slong len, slong prec, arf_rnd_t rnd)
    int arf_div(arf_t res, const arf_t x, const arf_t y, slong prec, arf_rnd_t rnd)
    int arf_div_ui(arf_t res, const arf_t x, ulong y, slong prec, arf_rnd_t rnd)
    int arf_ui_div(arf_t res, ulong x, const arf_t y, slong prec, arf_rnd_t rnd)
    int arf_div_si(arf_t res, const arf_t x, slong y, slong prec, arf_rnd_t rnd)
    int arf_si_div(arf_t res, slong x, const arf_t y, slong prec, arf_rnd_t rnd)
    int arf_div_fmpz(arf_t res, const arf_t x, const fmpz_t y, slong prec, arf_rnd_t rnd)
    int arf_fmpz_div(arf_t res, const fmpz_t x, const arf_t y, slong prec, arf_rnd_t rnd)
    int arf_fmpz_div_fmpz(arf_t res, const fmpz_t x, const fmpz_t y, slong prec, arf_rnd_t rnd)
    int arf_sqrt(arf_t res, const arf_t x, slong prec, arf_rnd_t rnd)
    int arf_sqrt_ui(arf_t res, ulong x, slong prec, arf_rnd_t rnd)
    int arf_sqrt_fmpz(arf_t res, const fmpz_t x, slong prec, arf_rnd_t rnd)
    int arf_rsqrt(arf_t res, const arf_t x, slong prec, arf_rnd_t rnd)
    int arf_root(arf_t res, const arf_t x, ulong k, slong prec, arf_rnd_t rnd)
    int arf_complex_mul(arf_t e, arf_t f, const arf_t a, const arf_t b, const arf_t c, const arf_t d, slong prec, arf_rnd_t rnd)
    int arf_complex_mul_fallback(arf_t e, arf_t f, const arf_t a, const arf_t b, const arf_t c, const arf_t d, slong prec, arf_rnd_t rnd)
    int arf_complex_sqr(arf_t e, arf_t f, const arf_t a, const arf_t b, slong prec, arf_rnd_t rnd)
    int _arf_get_integer_mpn(nn_ptr y, nn_srcptr xp, slong xn, slong exp)
    int _arf_set_mpn_fixed(arf_t z, nn_srcptr xp, slong xn, slong fixn, int negative, slong prec, arf_rnd_t rnd)
    int _arf_set_round_ui(arf_t z, ulong x, int sgnbit, slong prec, arf_rnd_t rnd)
    int _arf_set_round_uiui(arf_t z, slong * fix, ulong hi, ulong lo, int sgnbit, slong prec, arf_rnd_t rnd)
    int _arf_set_round_mpn(arf_t z, slong * exp_shift, nn_srcptr x, slong xn, int sgnbit, slong prec, arf_rnd_t rnd)
