set -e
set -x

# Define cleanup function to find and move wheel files to /tmp
cleanup() {
    local exit_code=$?
    echo "Searching for wheel files..."
    cd build/python
    python setup.py bdist_wheel
    find ./ -name "*.whl" -exec cp {} /tmp/ \;
    # mv dist/*.whl /tmp/
    echo "Wheel files moved to /tmp"
    exit $exit_code
}

# Trap any error or exit and run the cleanup function
trap cleanup EXIT

python -m pip install cibuildwheel
python -m cibuildwheel build/python --output-dir wheelhouse