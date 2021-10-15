#!/bin/bash

# delete everything after __name__ == __main__ in measurement methods
cat ./inst/python/The-Daphnia-ruler/measurement_methods.py | sed '/^if __name__ ==/q' | head -n -1 > ./inst/python/The-Daphnia-ruler/measurement_methods_r.py

# delete everything after __name__ == __main__ in daphnia_ruler
cat ./inst/python/The-Daphnia-ruler/daphnia_ruler.py | sed '/^if __name__ ==/q' | head -n -1 > ./inst/python/The-Daphnia-ruler/daphnia_ruler_r.py
