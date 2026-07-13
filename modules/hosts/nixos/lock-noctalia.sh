#!/bin/sh
if [ "$1" = "pre" ]; then
  USER_ID=$(id -u dev)
  export XDG_RUNTIME_DIR="/run/user/$USER_ID"
  export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
  su dev -c "@noctalia_bin@ ipc call lockScreen lock"
fi
