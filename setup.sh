#! /usr/bin/env bash
# (c) Konstantin Riege
shopt -s extglob
trap 'die' INT TERM
trap 'kill -PIPE $(pstree -p $$ | grep -Eo "\([0-9]+\)" | grep -Eo "[0-9]+") &> /dev/null' EXIT

die() {
	echo -ne "\e[0;31m"
	echo ":ERROR: $*" >&2
	echo -ne "\e[m"
	exit 1
}

export SRC=$(readlink -e $(dirname $0))
[[ $# -eq 0 ]] && {
	$SRC/bashbone/setup.sh -h
} || {
	$SRC/bashbone/setup.sh -s $SRC/lib/compile.sh "$@"
}
exit 0