#!/bin/sh

#!/bin/sh
set -eux

INI="${TARGET_DIR}/etc/inittab"
TTY="ttyPS0"

if [ -e "${INI}" ]; then
  if grep -qE "^${TTY}::" "${INI}"; then
    sed -ri "s@^${TTY}::.*@${TTY}::respawn:/bin/sh -l@" "${INI}"
  else
    printf "%s::respawn:/bin/sh -l\n" "${TTY}" >> "${INI}"
  fi
else
  echo "inittab not found at ${INI}" >&2
fi

# support/scripts/genimage.sh -c board/zynq/genimage.cfg
