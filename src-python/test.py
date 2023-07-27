import sys

sys.path.insert(0, "./src-python/wrapper")

from wrapper import *

if __name__ == "__main__":
    print(gauss(n=100))
