#!/bin/bash

set -e
set +x

python -c"import mantid.kernel"
python -c"import mantid.geometry"
python -c"import mantid.api"

conda install -c conda-forge -c scipp scipp psutil pytest git --yes

python -c"import mantid;print('Compat testing using mantid', mantid.__version__)"
python -c"import scipp;print('Compat testing using scipp', scipp.__version__)"

git clone https://github.com/scipp/scipp.git
cd scipp
git fetch --all --tags
latest_tag=$(git tag --sort=-creatordate | head -1)
echo using scipp tests from tag $latest_tag
git checkout $latest_tag
python -m pytest python/tests/compat/test_mantid.py 
