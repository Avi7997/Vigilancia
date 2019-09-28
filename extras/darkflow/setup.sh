#!/bin/bash

# Find Python 3.
PYTHON_CMD=python
version=$(echo $($PYTHON_CMD -V 2>&1) | sed -e 's/Python //g' | sed -e 's/.[0-9].*//g')
if [ ! $version -eq 3 ]; then
    PYTHON_CMD=python3
    version=$(echo $($PYTHON_CMD -V 2>&1) | sed -e 's/Python //g' | sed -e 's/.[0-9].*//g')
    if [ ! $version -eq 3 ]; then
        echo "Unknown python command. Please install Python 3."
    fi;
fi;

echo "Compiling darkflow inplace..."
$PYTHON_CMD setup.py build_ext --inplace

echo "Fixing file names..."
mv $(dirname $0)/darkflow/cython_utils/cy_yolo_findboxes.cpython-36m-x86_64-linux-gnu.so $(dirname $0)/darkflow/cython_utils/cy_yolo_findboxes.so
mv $(dirname $0)/darkflow/cython_utils/cy_yolo2_findboxes.cpython-36m-x86_64-linux-gnu.so $(dirname $0)/darkflow/cython_utils/cy_yolo2_findboxes.so
mv $(dirname $0)/darkflow/cython_utils/nms.cpython-36m-x86_64-linux-gnu.so $(dirname $0)/darkflow/cython_utils/nms.so
echo "Finished"
