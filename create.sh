#!/bin/bash

# Check if a project name and package name were provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 project_name package_name"
    exit 1
fi

PROJECT_NAME=$1
PACKAGE_NAME=$2

# Create the directory structure
mkdir -p "$PACKAGE_NAME/src/$PACKAGE_NAME"
mkdir -p "$PACKAGE_NAME/tests"

# Navigate to the project directory
cd "$PACKAGE_NAME" || exit

# Create an empty README file
echo "# $PACKAGE_NAME" > README.md

# Create an empty __init__.py file
touch "src/$PACKAGE_NAME/__init__.py"

# Create a sample test file
cat > "tests/test_$PACKAGE_NAME.py" <<EOL
import $PACKAGE_NAME

def test_placeholder():
    assert True  # Replace with real tests
EOL

# Generate a requirements.txt file
cat > requirements.txt <<EOL
# Add dependencies here
EOL

# Generate a pyproject.toml file for setuptools
cat > pyproject.toml <<EOL
[build-system]
requires = ["setuptools"]
build-backend = "setuptools.build_meta"

[project]
name = "$PACKAGE_NAME"
version = "0.1.0"
dependencies = []

[tool.setuptools]
packages = ["$PACKAGE_NAME"]
package-dir = {"" = "src"}

[tool.pytest.ini_options]
pythonpath = ["src"]
EOL

echo "Python package '$PACKAGE_NAME' created successfully in '$PROJECT_NAME'."
echo "Run 'cd $PACKAGE_NAME && pip install -e .' to install the package."
echo "Run 'pytest' to execute tests."
