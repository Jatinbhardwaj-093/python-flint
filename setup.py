import sys
import os
from subprocess import check_call

from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize
from numpy.distutils.system_info import default_include_dirs, default_lib_dirs

from distutils.sysconfig import get_config_vars


if sys.platform == 'win32':
    #
    # This is used in CI to build wheels with mingw64
    #
    if os.getenv('PYTHON_FLINT_MINGW64'):
        libraries = ["arb", "flint", "mpfr", "gmp"]
        includedir = os.path.join(os.path.dirname(__file__), '.local', 'include')
        librarydir1 = os.path.join(os.path.dirname(__file__), '.local', 'bin')
        librarydir2 = os.path.join(os.path.dirname(__file__), '.local', 'lib')
        librarydirs = [librarydir1, librarydir2]
        default_include_dirs += [includedir]
        default_lib_dirs += librarydirs
        # Add gcc to the PATH in GitHub Actions when this setup.py is called by
        # cibuildwheel.
        os.environ['PATH'] += r';C:\msys64\mingw64\bin'
    elif os.getenv('PYTHON_FLINT_MINGW64_TMP'):
        # This would be used to build under Windows against these libraries if
        # they have been installed somewhere other than .local
        libraries = ["arb", "flint", "mpfr", "gmp"]
    else:
        # For the MSVC toolchain link with mpir instead of gmp
        libraries = ["arb", "flint", "mpir", "mpfr", "pthreads"]
else:
    # On Ubuntu libarb.so is called libflint-arb.so
    if os.getenv('PYTHON_FLINT_LIBFLINT_ARB'):
        arb = 'flint-arb'
    else:
        arb = 'arb'

    libraries = [arb, "flint"]
    (opt,) = get_config_vars('OPT')
    os.environ['OPT'] = " ".join(flag for flag in opt.split() if flag != '-Wstrict-prototypes')


default_include_dirs += [
    os.path.join(d, "flint") for d in default_include_dirs
]


define_macros = []
compiler_directives = {
    'language_level': 3,
    'binding': False,
}


# Enable coverage tracing
if os.getenv('PYTHON_FLINT_COVERAGE'):
    define_macros.append(('CYTHON_TRACE', 1))
    compiler_directives['linetrace'] = True


ext_files = [
    # ("flint._flint", ["src/flint/_flint.pxd"]), # Main Module
    ("flint.pyflint", ["src/flint/pyflint.pyx"]), # Main Module
    # Submodules
    ("flint._fmpz", ["src/flint/_fmpz.pyx"]),
    ("flint._fmpz_poly", ["src/flint/_fmpz_poly.pyx"]),
    ("flint._fmpz_mat", ["src/flint/_fmpz_mat.pyx"]),
    ("flint._fmpz_series", ["src/flint/_fmpz_series.pyx"]),
    ("flint._fmpq", ["src/flint/_fmpq.pyx"]),
    ("flint._fmpq_poly", ["src/flint/_fmpq_poly.pyx"]),
    ("flint._fmpq_mat", ["src/flint/_fmpq_mat.pyx"]),
    ("flint._fmpq_series", ["src/flint/_fmpq_series.pyx"]),
    ("flint._nmod", ["src/flint/_nmod.pyx"]),
    ("flint._nmod_poly", ["src/flint/_nmod_poly.pyx"]),
    ("flint._nmod_mat", ["src/flint/_nmod_mat.pyx"]),
    ("flint._nmod_series", ["src/flint/_nmod_series.pyx"]),
    ("flint._arf", ["src/flint/_arf.pyx"]),
    ("flint._arb", ["src/flint/_arb.pyx"]),
    ("flint._arb_poly", ["src/flint/_arb_poly.pyx"]),
    ("flint._arb_mat", ["src/flint/_arb_mat.pyx"]),
    ("flint._arb_series", ["src/flint/_arb_series.pyx"]),
    ("flint._acb", ["src/flint/_acb.pyx"]),
    ("flint._acb_poly", ["src/flint/_acb_poly.pyx"]),
    ("flint._acb_mat", ["src/flint/_acb_mat.pyx"]),
    ("flint._acb_series", ["src/flint/_acb_series.pyx"]),
    ("flint._fmpz_mpoly", ["src/flint/_fmpz_mpoly.pyx"]),
    ("flint.flint_base.flint_base", ["src/flint/flint_base/flint_base.pyx"]),
    ("flint.flint_base.flint_context", ["src/flint/flint_base/flint_context.pyx"]),

]

ext_options = {
    "libraries" : libraries,
    "library_dirs" : default_lib_dirs,
    "include_dirs" : default_include_dirs,
    "define_macros" : define_macros,
}

ext_modules = []
for mod_name, src_files in ext_files:
    ext = Extension(mod_name, src_files, **ext_options)
    ext_modules.append(ext)

for e in ext_modules:
    e.cython_directives = {"embedsignature": True}

setup(
    name='python-flint',
    cmdclass={'build_ext': build_ext},
    ext_modules=cythonize(ext_modules, compiler_directives=compiler_directives),
    #ext_modules=cythonize(ext_modules, compiler_directives=compiler_directives, annotate=True),
    packages=['flint', 'flint.test'],
    package_dir={'': 'src'},
    description='Bindings for FLINT and Arb',
    long_description=open('README.md').read(),
    long_description_content_type='text/markdown',
    version='0.4.2',
    url='https://github.com/flintlib/python-flint',
    author='Fredrik Johansson',
    author_email='fredrik.johansson@gmail.com',
    license='MIT',
    classifiers=['Topic :: Scientific/Engineering :: Mathematics'])

