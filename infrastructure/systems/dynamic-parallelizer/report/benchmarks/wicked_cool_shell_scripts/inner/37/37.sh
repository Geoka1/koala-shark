#!/bin/sh
# newdf--A friendlier version of df
awkscript="/tmp/newdf.$$"
trap "rm -f $awkscript" EXIT
cat << 'EOF' > $awkscript
function showunit(size)
{ mb = size / 1024; prettymb=(int(mb * 100)) / 100;
  gb = mb / 1024; prettygb=(int(gb * 100)) / 100;

  if ( substr(size,1,1) !~ "[0-9]" ||
       substr(size,2,1) !~ "[0-9]" ) { return size }
  else if ( mb < 1) { return size "K" }
  else if ( gb < 1) { return prettymb "M" }
  else { return prettygb "G" }
}

BEGIN {
  printf "%-37s %10s %7s %7s %8s %-s\n",
        "Filesystem", "Size", "Used", "Avail", "Capacity", "Mounted"
}

!/Filesystem/ {

  size=showunit($2);
  used=showunit($3);
  avail=showunit($4);

  printf "%-37s %10s %7s %7s %8s %-s\n",
        $1, size, used, avail, $5, $6
}
EOF
df -k | awk -f $awkscript
exit 0
