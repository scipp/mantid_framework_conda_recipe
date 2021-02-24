#!/bin/bash

set -e
set +x

python -c"import mantid.kernel"
python -c"import mantid.geometry"
python -c"import mantid.api"

conda install -c scipp -c conda-forge scipp psutil pytest git --yes

python -c"import mantid;print('Compat testing using mantid', mantid.__version__)"
python -c"import scipp;print('Compat testing using scipp', scipp.__version__)"

git clone https://github.com/scippneutron/scipp.git
cd scipp
git fetch --all --tags
git checkout cross-dr-testing
python -m pytest python/tests/ 
