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
  -DCMAKE_OSX_DEPLOYMENT_TARGET=$OSX_VERSION \
  -DHDF5_ROOT=$CONDA_PREFIX \
  -DCMAKE_OSX_SYSROOT="/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX$OSX_VERSION.sdk" \
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

# Move Mantid
python_site_pkg_path="$(python -c 'from __future__ import print_function; import h5py, os; opd=os.path.dirname; print(opd(opd(h5py.__file__)))')"
echo "$python_site_pkg_path"

mv "$CONDA_PREFIX/lib/mantid/" "$python_site_pkg_path/"
mv "$CONDA_PREFIX/lib/"mantid-*-py*.egg-info "$python_site_pkg_path/"
# ln -s "$CONDA_PREFIX/plugins" "$CONDA_PREFIX/lib/mantid/plugins"
