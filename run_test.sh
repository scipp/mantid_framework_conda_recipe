#!/bin/bash
if [[ $(uname -s) == Darwin ]];then
    echo 'import mantid.kernel' 
    python -c 'import mantid.kernel' 
    echo 'import mantid.geometry' 
    python -c 'import mantid.geometry' 
    echo 'import mantid.simpleapi' 
    python -c 'import mantid.simpleapi' 
else 
    echo 'skipping import testing' 
fi
