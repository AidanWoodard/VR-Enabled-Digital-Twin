========================READ\_ME======================

This is a simple guide to the Kent State VR robotics project because there were no docs for much of this. I got this project from Sam, whoever he is, and I'm assuming Kent will just redo the same project next year. This is for me really, but if it helps you at all, I take Zelle or Venmo.



=====HARDWARE=====
Robot: Sagittarius Robot (sgr532) by NXROBO
Robot Repo: https://github.com/NXROBO/sagittarius\_ws (not in English, sorry)
VR Headset: Vive with Vive adapter port
VR Controllers: Valve Index controllers



=====HARDWARE\_SETUP=====
Pairing controllers to headset

* Do this through steam client
* Should give you an option when opening or configuring SteamVR
* Hard to find a brand that won't pair
Plugging in Sagittarius Robot Arm
* I used a USB-C to the base and then a power cord plugged into the wall
* USB-C into the computer, find the port in PowerShell, bind it to WSL
* Read more in ROS\_Setup.txt file in docs (and use AI!)



=====SOFTWARE\_STACK=====
SteamVR 			Connection to Vive headset and controllers
Unity 6000.0.51f1 		Rendering robot arm and creating VR scene
WSL with Ubuntu 20.04 		Running ROS and making bridge (Unity -> ROS/WSL -> sgr532)
ROS Noetic			Really old, sorry, inherited from project

