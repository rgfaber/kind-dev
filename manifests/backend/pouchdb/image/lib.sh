#!/bin/sh

# no sha256sum on mac
function _sha256sum() {
	if [ -x "$(command -v sha256sum)" ]; then
		sha256sum "$@"
	fi
	if [ -x "$(command -v shasum)" ]; then
		shasum -a 256 "$@"
	fi
}

function random_pass() {
	date +%s | _sha256sum | base64 | head -c ${1:-16}
}

function json_value() {
	KEY=$1
	NUM=$2
	awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' |
		tr -d '"' |
		sed -n ${NUM}p

}
