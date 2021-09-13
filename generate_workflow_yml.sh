#!/bin/bash

generate_device_yml() {
	local device_name="$1"
	local total_keep_num="$2"
	sed -e "s/template_device_please_replace/$device_name/g" \
		-e "s/template_total_keep_number_please_replace/$total_keep_num/g" \
		".github/build-lede-template.yml" \
		>".github/workflows/build-lede-${device_name}.yml"
}

rm -rf ".github/workflows/"
mkdir -p ".github/workflows/"

total_dev=$(find conf -mindepth 1 -type f -name ".config.*" -printf x | wc -c)
total_keep_num=$((total_dev + 1))

for file in conf/.config.*; do
	: >"$file"
	dev_name="$(basename "$file" | sed 's/^\.config\.//')"
	generate_device_yml "$dev_name" "$total_keep_num"
done

sed "s/template_total_keep_number_please_replace/$total_keep_num/g" \
	".github/lede-dl.yml" \
	>".github/workflows/lede-dl.yml"
cp ".github/update-checker.yml" ".github/workflows/update-checker.yml"
