# Sagittarius VR/ROS Custom Bashrc Functions

Custom shell functions for launching the Kent State VR + Sagittarius arm ROS stack. Copy the block below into your `~/.bashrc` (or a sourced file like `~/.bash_aliases`).

The workspace path is hardcoded as `~/ROS_Files/sagittarius_ws` in every function — if your workspace lives elsewhere, edit the `cd` lines accordingly.

```bash
export DISABLE_ROS1_EOL_WARNINGS=1

# starter script to find and prep a ACM0/1 port for a robot arm
function sgrlaunch() {
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
  cd ~/ROS_Files/sagittarius_ws && source devel/setup.bash
  roslaunch sagittarius_moveit sgr532_moveit_in_spark.launch serialname:="$acm_port" "$@"
}

function endplaunch() {
  echo "Running ROC TCP endpoint to Unity launch file..."
  cd ~/ROS_Files/sagittarius_ws && source devel/setup.bash
  roslaunch ros_tcp_endpoint endpoint.launch
}

# WSL2 mirrored networking blackholes TCP connects to never-bound localhost
# ports (~130s stuck in SYN-SENT) instead of refusing them instantly, and
# BOTH roscore AND roslaunch probe 127.0.0.1:11311 at startup to detect an
# existing master. Briefly binding and releasing the port first "warms" it in
# the mirrored stack so the probe gets an instant RST (verified to persist >30s).
# Must run before roscore, and before any roslaunch started without a master.
function ros_port_warmup() {
  python3 - <<'WARMUP'
import socket
for fam, addr in ((socket.AF_INET, '127.0.0.1'), (socket.AF_INET6, '::1')):
    try:
        s = socket.socket(fam)
        s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        s.bind((addr, 11311)); s.listen(1); s.close()
    except OSError:
        pass  # already bound => a master is running; the probe will connect fine
WARMUP
}

function rosclaunch() {
  echo "Initializing ROS environment..."
  cd ~/ROS_Files/sagittarius_ws && source ~/../../opt/ros/noetic/setup.bash
  ros_port_warmup
  roscore
}

function liklaunch() {
  echo "Running light IK solver Python program..."
  cd ~/ROS_Files/sagittarius_ws && source devel/setup.bash
  rosrun unity_vr_control light_ik_solver.py
}

function cliklaunch() {
  echo "Running clean IK solver Python program..."
  cd ~/ROS_Files/sagittarius_ws && source devel/setup.bash
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
    cd ~/ROS_Files/sagittarius_ws && source devel/setup.bash
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
  cd ~/ROS_Files/sagittarius_ws && source devel/setup.bash
  roslaunch sagittarius_object_color_detector usb_cam.launch video_dev1:="$cam1_port" video_dev2:="$cam2_port"
}

function fullsyslaunch() {
  # find sagittarius and change mode
  local acm_port=$(ls ~/../../dev/ttyACM* 2>/dev/null | head -n 1)
  if [ -z "$acm_port" ]; then
    echo "ERROR: Could not find port for ttyACM* in dev/. Make sure it is shared through PowerShell."
    return 1
  fi

  echo "Found sagittarius on port $acm_port"
  sudo chmod 666 "$acm_port"
  echo "Changed permissions for port $acm_port"

  # launch everything but the webcams
  cd ~/ROS_Files/sagittarius_ws
  source devel/setup.bash
  echo "Changed dir and sourced. Running full_system.launch..."

  # roslaunch probes 127.0.0.1:11311 for an existing master just like roscore
  # does — without the warm-up, running fullsyslaunch with no master already
  # up hangs ~130s in the mirrored-networking blackhole (see ros_port_warmup).
  ros_port_warmup
  roslaunch unity_vr_control full_system.launch serialname:="$acm_port"
}

# Same as fullsyslaunch, but launches full_system_ee.launch (EE playback mode).
function fullsyseelaunch() {
  # find sagittarius and change mode
  local acm_port=$(ls ~/../../dev/ttyACM* 2>/dev/null | head -n 1)
  if [ -z "$acm_port" ]; then
    echo "ERROR: Could not find port for ttyACM* in dev/. Make sure it is shared through PowerShell."
    return 1
  fi

  echo "Found sagittarius on port $acm_port"
  sudo chmod 666 "$acm_port"
  echo "Changed permissions for port $acm_port"

  # launch everything but the webcams
  cd ~/ROS_Files/sagittarius_ws
  source devel/setup.bash
  echo "Changed dir and sourced. Running full_system.launch..."

  # roslaunch probes 127.0.0.1:11311 for an existing master just like roscore
  # does — without the warm-up, running fullsyslaunch with no master already
  # up hangs ~130s in the mirrored-networking blackhole (see ros_port_warmup).
  ros_port_warmup
  roslaunch unity_vr_control full_system_ee.launch serialname:="$acm_port"
}

# WSL2 mirrored networking exposes a live campus DNS/mDNS path (eth1) alongside
# the direct robot Ethernet link (eth0). glibc's getaddrinfo prefers IPv6 and can
# resolve this machine's own hostname to a link-local fe80:: address via mDNS,
# which stalls ROS's IPv4 XML-RPC/TCPROS registration at roslaunch/roscore startup.
# Force ROS to advertise/bind loopback instead, sidestepping that lookup entirely.
# Unity is unaffected: it connects via ros_tcp_endpoint's own socket (0.0.0.0:10000),
# not the ROS master URI.
export ROS_HOSTNAME=localhost

export PATH="$HOME/.local/bin:$PATH"
```

## The mirrored-networking roscore hang (and why `ignoredPorts` is NOT the fix)

`ROS_HOSTNAME=localhost` alone is **not** enough to make `roscore` start cleanly under
WSL2 mirrored networking. In mirrored mode, a TCP connect to a **never-bound** localhost
port is blackholed (stuck in `SYN-SENT` for ~130s until the kernel's 6 SYN retries give
up) instead of being refused instantly. `roscore`/`roslaunch` probe `127.0.0.1:11311`
at startup to check whether a master is already running, so every `roscore` launch hung
silently for ~2 minutes. Pressing Ctrl+C "fixed" it because the KeyboardInterrupt aborts
the probe (roslaunch swallows it and treats it as "no master"), letting boot continue.

**Do NOT use `ignoredPorts=11311` in `.wslconfig` for this.** Tested empirically on
WSL 2.7.3: `ignoredPorts` only resolves *bind conflicts* with Windows processes — it
does not restore instant-RST behavior for unbound ports (they still blackhole), and
worse, a port listed there becomes unreachable over WSL loopback **even while bound**.
With it set, roscore still hung at the probe, and once rosmaster finally bound 11311
no node could connect to it, so ROS was broken even after startup. `.wslconfig` should
contain only `networkingMode=mirrored` (plus a warning comment).

The working fix is the `ros_port_warmup` helper above: binding and
immediately releasing port 11311 (IPv4 + IPv6 loopback) "warms" the port in the
mirrored network stack, so the subsequent unbound-port probe is refused instantly
instead of blackholed. Note that `roslaunch` performs the **same** master probe
as `roscore` (and auto-spawns a master if none answers), so any launch wrapper
that might run without a master already up needs the warm-up too — this is why
both `rosclaunch` and `fullsyslaunch` call it. (Diagnosed 2026-07-14 when
`fullsyslaunch` run on its own exhibited the same ~2-minute silent pause.) The warmed state was measured to persist well over 30 seconds —
far longer than the gap before roscore's probe. If the port is already bound (a master
is running), the warm-up bind fails silently and the probe connects normally.

Quick check of the raw blackhole behavior (a never-bound port should print `TIMEOUT`;
run it again right after a `rosclaunch` warm-up and it prints `refused` instantly):

```bash
python3 -c "import socket;s=socket.socket();s.settimeout(3);
import time;t=time.time()
try: s.connect(('127.0.0.1',11311)); print('connected (master already up)')
except socket.timeout: print(f'TIMEOUT after {time.time()-t:.1f}s — blackholed (expected when cold)')
except OSError as e: print(f'refused in {time.time()-t:.2f}s — port is warmed')"
```
