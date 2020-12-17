#!/usr/bin/env bash
git clone https://github.com/scipp/scipp.git scipp
python -m pytest scipp/python/tests/compat/test_mantid.py 
