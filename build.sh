#!/usr/bin/env bash

set -ex

mkdir build
cd build

cmake \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DUSE_JEMALLOC=OFF \
  -DUSE_CCACHE=OFF \
  -DPython_EXECUTABLE="$CONDA_PREFIX/bin/python" \
  -DCMAKE_PREFIX_PATH=$CONDA_PREFIX \
  -DCMAKE_INSTALL_PREFIX=$CONDA_PREFIX \
  -DHDF5_ROOT=$CONDA_PREFIX \
  -DCMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk" \
  -DOpenSSL_ROOT=$CONDA_PREFIX \
  -DUSE_SYSTEM_EIGEN=OFF \
  -DENABLE_MANTIDPLOT=OFF \
  -DENABLE_WORKBENCH=OFF \
  -DENABLE_OPENGL=OFF \
  -DENABLE_DOCS=OFF \
  -DENABLE_OPENCASCADE=OFF \
  -DUSE_PYTHON_DYNAMIC_LIB=OFF \
  ..

cmake --build .
cmake --build . --target install

mv ${CONDA_PREFIX}/lib/mantid ${SP_DIR}
