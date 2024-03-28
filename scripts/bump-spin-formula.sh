#!/bin/bash

VERSION=$1
FORMULA=${2:-Formula/Spin.rb}

usage() {
    echo "Usage: $0 <VERSION> [<FORMULA_PATH>]"
    echo "Updates the Spin Formula for the specified release version"
    echo "Example: $0 3.0.0"
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

# Get the checksum file for the release
wget -qO checksums.txt "https://github.com/fermyon/spin/releases/download/$VERSION/checksums-$VERSION.txt"

# Update the formula version
ERSION="${VERSION:1}"
sed -i '' -e "s/version \"[^\"]*\"/version \"$ERSION\"/" $FORMULA

# Update the sha256 checksums for each OS/Arch
while read -r line; do
    filename=$(echo "$line" | awk '{print $2}')
    sha256=$(echo "$line" | awk '{print $1}')
    os_arch="${filename:12}"
    if grep -q "$os_arch" $FORMULA; then
    sed -i '' -E "/url \".*$os_arch\"/ { n; s/sha256 \"[^\"]*\"/sha256 \"$sha256\"/; }" $FORMULA
    fi

done < checksums.txt

rm checksums.txt

echo "Formula updated to version $VERSION with new checksums."
