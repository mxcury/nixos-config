#!/bin/sh
case "$1" in
  pre)
    USER_ID=$(@id_bin@ -u dev)
    export XDG_RUNTIME_DIR="/run/user/$USER_ID"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
    export WAYLAND_DISPLAY="wayland-1"
    @timeout_bin@ 5 @noctalia_bin@ ipc call lockScreen lock
    sleep 1
    @timeout_bin@ 5 @niri_bin@ msg action power-off-monitors
    ;;
  post)
    USER_ID=$(@id_bin@ -u dev)
    export XDG_RUNTIME_DIR="/run/user/$USER_ID"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
    export WAYLAND_DISPLAY="wayland-1"
    @timeout_bin@ 5 @noctalia_bin@ ipc call lockScreen lock
    ;;
esac
