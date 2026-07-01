# Sagittarius VR/ROS Custom Bashrc Functions

Custom shell functions for launching the Kent State VR + Sagittarius arm ROS stack. Copy the block below into your `~/.bashrc` (or a sourced file like `~/.bash_aliases`).

The workspace path is auto-detected at shell startup (searches under `$HOME` for a `sagittarius_ws` directory containing `devel/setup.bash`) and cached in `$SGR_WS` — no manual path editing needed. If auto-detect picks the wrong one, or your workspace lives outside `$HOME`, set `export SGR_WS=/path/to/your/sagittarius_ws` yourself before this block runs.

```bash
export DISABLE_ROS1_EOL_WARNINGS=1

# Auto-detect the sagittarius_ws catkin workspace: searches under $HOME (a
# few levels deep) for a directory named "sagittarius_ws" that contains
# devel/setup.bash. Override manually (export SGR_WS=/path/to/sagittarius_ws
# before this block) if you keep it somewhere find won't reach, or if you
# have more than one candidate workspace.
if [ -z "$SGR_WS" ]; then
  export SGR_WS="$(find "$HOME" -maxdepth 4 -type d -name sagittarius_ws 2>/dev/null \
    | while read -r d; do [ -f "$d/devel/setup.bash" ] && echo "$d" && break; done)"
fi

if [ -z "$SGR_WS" ]; then
  echo "[sagittarius bashrc] WARNING: could not auto-detect the sagittarius_ws workspace under \$HOME. Run 'catkin_make' once, or set SGR_WS manually." >&2
fi

# starter script to find and prep a ACM0/1 port for a robot arm
function sgrlaunch() {
  [ -z "$SGR_WS" ] && { echo "ERROR: SGR_WS is not set — sagittarius_ws not found."; return 1; }
  local acm_port=$(ls ~/../../dev/ttyACM* 2>/dev/null | head -n 1)

  # if not found or not yet shared with usbipd commands in powershell
  if [ -z "$acm_port" ]; then
    echo "ERROR: No /dev/ttyACM* devices could be found. Make sure that the port is shared through Windows PowerShell"
    return 1
  fi

  echo "Detected Sagittarius sgr532 on port: $acm_port"
  echo "Running MoveIt launch file..."

  # allow permissions
  sudo chmod 666 "$acm_port"

  # run moveit after sourcing and moving to root dir
  cd "$SGR_WS" && source devel/setup.bash
  roslaunch sagittarius_moveit sgr532_moveit_in_spark.launch serialname:="$acm_port" "$@"
}

function endplaunch() {
  [ -z "$SGR_WS" ] && { echo "ERROR: SGR_WS is not set — sagittarius_ws not found."; return 1; }
  echo "Running ROC TCP endpoint to Unity launch file..."
  cd "$SGR_WS" && source devel/setup.bash
  roslaunch ros_tcp_endpoint endpoint.launch
}

function rosclaunch() {
  [ -z "$SGR_WS" ] && { echo "ERROR: SGR_WS is not set — sagittarius_ws not found."; return 1; }
  echo "Initializing ROS environment..."
  cd "$SGR_WS" && source ~/../../opt/ros/noetic/setup.bash
  roscore
}

function liklaunch() {
  [ -z "$SGR_WS" ] && { echo "ERROR: SGR_WS is not set — sagittarius_ws not found."; return 1; }
  echo "Running light IK solver Python program..."
  cd "$SGR_WS" && source devel/setup.bash
  rosrun unity_vr_control light_ik_solver.py
}

function cliklaunch() {
  [ -z "$SGR_WS" ] && { echo "ERROR: SGR_WS is not set — sagittarius_ws not found."; return 1; }
  echo "Running clean IK solver Python program..."
  cd "$SGR_WS" && source devel/setup.bash
  rosrun unity_vr_control clean_ik_solver.py
}

function setCamSettings() {
  echo "[INFO] Setting camera settings on $1..."
  sudo chmod 666 "$1"
  # Force 640x480 MJPEG at 30fps before the ROS node opens the device.
  # Without this, usb_cam_node negotiates framerate with V4L2 after the
  # controller already has another stream running, and can silently get
  # back 15fps instead of 30fps.
  v4l2-ctl -d "$1" --set-fmt-video=width=640,height=480,pixelformat=MJPG --set-parm=30
  v4l2-ctl -d "$1" -c auto_exposure=1
  v4l2-ctl -d "$1" -c exposure_time_absolute=30
  v4l2-ctl -d "$1" -c exposure_dynamic_framerate=0
  v4l2-ctl -d "$1" -c brightness=35
}

function camlaunch() {
  [ -z "$SGR_WS" ] && { echo "ERROR: SGR_WS is not set — sagittarius_ws not found."; return 1; }
  # Enumerate only video-index0 entries: these are the actual capture interfaces.
  # video-index1 entries are V4L2 metadata nodes — enumerating by-path directly
  # avoids the fragile skip-every-other-index pattern needed with /dev/video*.
  local by_paths=($(ls /dev/v4l/by-path/*video-index0 2>/dev/null | sort -V))
  local cam1_port="${by_paths[0]}"
  local cam2_port="${by_paths[1]}"

  if [[ ${#by_paths[@]} -eq 0 ]]; then
    echo "[camlaunch] No cameras found via usbipd — starting bridge mode."
    echo ""
    echo "  ACTION REQUIRED on the Windows host (run in PowerShell or CMD):"
    echo "    python '<sagittarius_ws>\\src\\sagittarius_perception\\sagittarius_object_color_detector\\scripts\\cam_bridge.py'"
    echo ""
    echo "  Launching WSL bridge receiver (connects to Windows on ports 8484/8485)..."
    cd "$SGR_WS" && source devel/setup.bash
    roslaunch sagittarius_object_color_detector cam_bridge_receiver.launch
    return
  elif [ -z "$cam1_port" ]; then
    echo "ERROR: Primary camera not found. Check usbipd attachment."
    setCamSettings "$cam2_port"
  elif [ -z "$cam2_port" ]; then
    echo "ERROR: Secondary camera not found. Check usbipd attachment."
    setCamSettings "$cam1_port"
  else
    echo "Camera ports found: Camera_1 on $cam1_port, Camera_2 on $cam2_port"
    setCamSettings "$cam1_port"
    setCamSettings "$cam2_port"
  fi

  echo "Initializing connection to webcams..."
  cd "$SGR_WS" && source devel/setup.bash
  roslaunch sagittarius_object_color_detector usb_cam.launch video_dev1:="$cam1_port" video_dev2:="$cam2_port"
}

function fullsyslaunch() {
  [ -z "$SGR_WS" ] && { echo "ERROR: SGR_WS is not set — sagittarius_ws not found."; return 1; }
  # find sagittarius and change mode
  local acm_port=$(ls ~/../../dev/ttyACM* 2>/dev/null | head -n 1)
  if [ -z "$acm_port" ]; then
    echo "ERROR: Could not find port for ttyACM* in dev/. Make sure it is shared through PowerShell."
    return 1
  fi

  echo "Found sagittarius on port $acm_port"
  sudo chmod 666 "$acm_port"

  # launch everything but the webcams
  cd "$SGR_WS"
  source devel/setup.bash
  roslaunch unity_vr_control full_system.launch serialname:="$acm_port"
}
```
