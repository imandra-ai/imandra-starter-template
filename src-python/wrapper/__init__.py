"""
An example Ocaml library exposed to Python
"""

import os
from ctypes import PyDLL, RTLD_GLOBAL, c_char_p

curdir = os.path.dirname(os.path.realpath(__file__))
dll = PyDLL(f"{curdir}/main_python.so", RTLD_GLOBAL)
argv_t = c_char_p * 2
argv = argv_t("main_python.so".encode("utf-8"), None)
dll.caml_startup(argv)

# We export the names explicitly otherwise mypy
from python_gauss import *
