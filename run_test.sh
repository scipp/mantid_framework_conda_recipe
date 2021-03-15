#!/bin/bash

set -ex

python -c"import mantid.kernel"
python -c"import mantid.geometry"
python -c"import mantid.api"

conda install -c scipp/label/dev -c conda-forge scippneutron psutil pytest git matplotlib-base=3.2.2 pythreejs --yes

python -c"import mantid;print('Compat testing using mantid', mantid.__version__)"
python -c"import mantid;print('Compat testing using scippneutron', scippneutron.__version__)"
python -c"import scipp;print('Compat testing using scipp', scipp.__version__)"

git clone https://github.com/scipp/scippneutron.git scippneutron
cd scippneutron
git fetch --all --tags
git checkout main 
python -m pytest python/tests/ 
