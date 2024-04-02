#!/bin/bash
set -euo pipefail

VERSION=$1
FORMULA=${2:-Formula/spin.rb}

# -i syntax differs between GNU and Mac sed; this usage is supported by both
SED_INPLACE='sed -i.bak'

# cleanup
trap 'rm checksums.txt **/*.bak &>/dev/null' EXIT

usage() {
    echo "Usage: $0 <VERSION> [<FORMULA_PATH>]"
    echo "Updates the Spin Formula for the specified release version"
    echo "Example: $0 v3.0.0"
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

# Ensure version is prefixed with 'v' and an 'official' release
if [[ ! "${VERSION}" =~ ^v[0-9]+.[0-9]+.[0-9]+$ ]]; then
    echo "VERSION doesn't match v[0-9]+.[0-9]+.[0-9]+ and may be a prerelease; skipping."
    exit 1
fi

# Get the checksum file for the release
wget -qO checksums.txt "https://github.com/fermyon/spin/releases/download/$VERSION/checksums-$VERSION.txt" || \
    (echo "Checksum file not found for version $VERSION" && exit 1)

# Remove the 'v' prefix from the version
ERSION="${VERSION:1}"
$SED_INPLACE -e "s/version \"[^\"]*\"/version \"$ERSION\"/" $FORMULA
# Update the sha256 checksums for each OS/Arch
while read -r line; do
    filename=$(echo "$line" | awk '{print $2}')
    sha256=$(echo "$line" | awk '{print $1}')
    os_arch=$(echo ${filename} | sed "s/spin-v${ERSION}-//g")
    if grep -q "$os_arch" $FORMULA; then
        $SED_INPLACE -E "/url \".*$os_arch\"/ { n; s/sha256 \"[^\"]*\"/sha256 \"$sha256\"/; }" $FORMULA
    fi
done < checksums.txt

echo "Formula updated to version $VERSION with new checksums."
