#!/bin/sh
case "$1" in
  pre|post)
    USER_ID=$(@id_bin@ -u dev)
    export XDG_RUNTIME_DIR="/run/user/$USER_ID"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
    /run/wrappers/bin/su dev -c "@noctalia_bin@ ipc call lockScreen lock"
    ;;
esac
