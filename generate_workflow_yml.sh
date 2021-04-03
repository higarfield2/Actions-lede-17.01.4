#!/bin/bash

generate_device_yml() {
	local device_name="$1"
	sed "s/template_device_please_replace/${device_name}/" \
		".github/build-lede-template.yml" \
		>".github/workflows/build-lede-${device_name}.yml"
}

rm -rf ".github/workflows/"
mkdir -p ".github/workflows/"


for file in conf/.config.*; do
	cat /dev/null >"$file"
	dev_name="$(basename "$file" | sed 's/^\.config\.//')"
	generate_device_yml "$dev_name"
done

cp ".github/lede-dl.yml" ".github/workflows/lede-dl.yml"
cp ".github/update-checker.yml" ".github/workflows/update-checker.yml"
