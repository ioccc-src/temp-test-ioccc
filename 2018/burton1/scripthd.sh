#!/usr/bin/env bash

hd=${HD:=./prog}

cat "$@" |
$hd |
awk '
BEGIN { nodup=1; group=1 }
nodup {
	# suppress duplicate lines
	if ($0 == prev) {
		if (dots == 0)
			printf "%04x: . . .\n", off
		dots = off += 16
		next
	}
	prev = $0
	dots = 0
}
{
	# determine the number of bytes, rest is ascii
	nb = 16
	if (length($0) < 48 || length($16) != 2) {
		for (nb=1; nb<NF; ++nb)
			if (length($nb) != 2 || $nb !~ /[0-9a-f][0-9a-f]/)
				break
		--nb
	}
}
group {
	sz = 35
	hex = $1 $2 $3 $4 " " $5 $6 $7 $8 " " $9 $10 $11 $12 " " $13 $14 $15 $16
	if (nb < 16) hex = substr(hex, 1, nb*2+nb/4)
}
!group {
	sz = 47
	hex = substr($0, 0, nb*3-1)
}
{
	asc = substr($0, nb*3+1)
	printf "%04x: %-*.*s |%-16s|\n", off, sz, sz, hex, asc
	off += nb
}'
