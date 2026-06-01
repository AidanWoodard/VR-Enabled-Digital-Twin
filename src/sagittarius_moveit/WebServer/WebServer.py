import json
from flask import Flask, request, jsonify, render_template
# from flask_cors import CORS, cross_origin

import math

# import queue # for safely passing data between threads
from collections import deque
# from threading import Lock

# Create a queue to pass data between threads
# cmdQue = queue.Queue()
cmdQue = deque()
loopType = 0 # Start with a loop type of 0, not running
# mutex = Lock()


app = Flask(__name__)
# CORS(app)



@app.route('/goToPosition<int:position>', methods=['POST'])
def goToPosition(position):
	print("Go to position: ", position)
	if(position == 1):
		print("Go to position 1")
	elif(position == 2):	
		print("Go to position 2")
	elif(position == 3):
		print("Go to position 3")
	
	return "Go to position: " + str(position)



@app.route('/gripperPosition<int:position>', methods=['POST'])
def gripperPosition(position):
	print("Gripper position: ", position)
	if(position == 1):
		print("Gripper position 1")
	elif(position == 2):
		print("Gripper position 2")
	elif(position == 3):
		print("Gripper position 3")
	return "Gripper position: " + str(position)



# Handeling for sending joints to positions
@app.route('/joint<int:jointNumber>', methods=['POST'])
def moveJoint(jointNumber):
	# position = request.args.get('position')
	position = eval(request.form.get('position'))
	print("Joint: ", jointNumber, " Moving to position: ", position)
	if jointNumber != 7: # If the joint is not the gripper
		position = math.radians(position)
	cmdDict = {"jointNumber": jointNumber, "position": position}
	cmdQue.append(cmdDict)
	return json.dumps(cmdDict)



# Change the Loop Type
@app.route('/changeMode<int:mode>')
# @app.route('/changeMode<int:mode>', methods=['POST'])
def changeMode(mode):
	print("Recieved Command - Change Mode: ", mode)
	cmdDict = {"mode": mode}
	cmdQue.append(cmdDict)
	return json.dumps(cmdDict)


@app.route("/")
def home():
	return render_template("WebUI.html")



def startFlask():
	app.run(host='127.0.0.1', debug=False, port=8888, use_reloader=False)

if(__name__ == "__main__"):
	startFlask()
