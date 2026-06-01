// Auto-generated. Do not edit!

// (in-package sagittarius_joy.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class arm_joy {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.ee_x_cmd = null;
      this.ee_y_cmd = null;
      this.ee_z_cmd = null;
      this.ee_roll_cmd = null;
      this.ee_pitch_cmd = null;
      this.ee_yaw_cmd = null;
      this.pose_cmd = null;
      this.reset_cmd = null;
      this.speed_cmd = null;
      this.gripper_spacing_cmd = null;
      this.torque_cmd = null;
      this.torque_lev_cmd = null;
      this.super_cmd = null;
    }
    else {
      if (initObj.hasOwnProperty('ee_x_cmd')) {
        this.ee_x_cmd = initObj.ee_x_cmd
      }
      else {
        this.ee_x_cmd = 0;
      }
      if (initObj.hasOwnProperty('ee_y_cmd')) {
        this.ee_y_cmd = initObj.ee_y_cmd
      }
      else {
        this.ee_y_cmd = 0;
      }
      if (initObj.hasOwnProperty('ee_z_cmd')) {
        this.ee_z_cmd = initObj.ee_z_cmd
      }
      else {
        this.ee_z_cmd = 0;
      }
      if (initObj.hasOwnProperty('ee_roll_cmd')) {
        this.ee_roll_cmd = initObj.ee_roll_cmd
      }
      else {
        this.ee_roll_cmd = 0;
      }
      if (initObj.hasOwnProperty('ee_pitch_cmd')) {
        this.ee_pitch_cmd = initObj.ee_pitch_cmd
      }
      else {
        this.ee_pitch_cmd = 0;
      }
      if (initObj.hasOwnProperty('ee_yaw_cmd')) {
        this.ee_yaw_cmd = initObj.ee_yaw_cmd
      }
      else {
        this.ee_yaw_cmd = 0;
      }
      if (initObj.hasOwnProperty('pose_cmd')) {
        this.pose_cmd = initObj.pose_cmd
      }
      else {
        this.pose_cmd = 0;
      }
      if (initObj.hasOwnProperty('reset_cmd')) {
        this.reset_cmd = initObj.reset_cmd
      }
      else {
        this.reset_cmd = 0;
      }
      if (initObj.hasOwnProperty('speed_cmd')) {
        this.speed_cmd = initObj.speed_cmd
      }
      else {
        this.speed_cmd = 0;
      }
      if (initObj.hasOwnProperty('gripper_spacing_cmd')) {
        this.gripper_spacing_cmd = initObj.gripper_spacing_cmd
      }
      else {
        this.gripper_spacing_cmd = 0;
      }
      if (initObj.hasOwnProperty('torque_cmd')) {
        this.torque_cmd = initObj.torque_cmd
      }
      else {
        this.torque_cmd = 0;
      }
      if (initObj.hasOwnProperty('torque_lev_cmd')) {
        this.torque_lev_cmd = initObj.torque_lev_cmd
      }
      else {
        this.torque_lev_cmd = 0;
      }
      if (initObj.hasOwnProperty('super_cmd')) {
        this.super_cmd = initObj.super_cmd
      }
      else {
        this.super_cmd = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type arm_joy
    // Serialize message field [ee_x_cmd]
    bufferOffset = _serializer.int8(obj.ee_x_cmd, buffer, bufferOffset);
    // Serialize message field [ee_y_cmd]
    bufferOffset = _serializer.int8(obj.ee_y_cmd, buffer, bufferOffset);
    // Serialize message field [ee_z_cmd]
    bufferOffset = _serializer.int8(obj.ee_z_cmd, buffer, bufferOffset);
    // Serialize message field [ee_roll_cmd]
    bufferOffset = _serializer.int8(obj.ee_roll_cmd, buffer, bufferOffset);
    // Serialize message field [ee_pitch_cmd]
    bufferOffset = _serializer.int8(obj.ee_pitch_cmd, buffer, bufferOffset);
    // Serialize message field [ee_yaw_cmd]
    bufferOffset = _serializer.int8(obj.ee_yaw_cmd, buffer, bufferOffset);
    // Serialize message field [pose_cmd]
    bufferOffset = _serializer.int8(obj.pose_cmd, buffer, bufferOffset);
    // Serialize message field [reset_cmd]
    bufferOffset = _serializer.int8(obj.reset_cmd, buffer, bufferOffset);
    // Serialize message field [speed_cmd]
    bufferOffset = _serializer.int8(obj.speed_cmd, buffer, bufferOffset);
    // Serialize message field [gripper_spacing_cmd]
    bufferOffset = _serializer.int8(obj.gripper_spacing_cmd, buffer, bufferOffset);
    // Serialize message field [torque_cmd]
    bufferOffset = _serializer.int8(obj.torque_cmd, buffer, bufferOffset);
    // Serialize message field [torque_lev_cmd]
    bufferOffset = _serializer.int8(obj.torque_lev_cmd, buffer, bufferOffset);
    // Serialize message field [super_cmd]
    bufferOffset = _serializer.int8(obj.super_cmd, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type arm_joy
    let len;
    let data = new arm_joy(null);
    // Deserialize message field [ee_x_cmd]
    data.ee_x_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [ee_y_cmd]
    data.ee_y_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [ee_z_cmd]
    data.ee_z_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [ee_roll_cmd]
    data.ee_roll_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [ee_pitch_cmd]
    data.ee_pitch_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [ee_yaw_cmd]
    data.ee_yaw_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [pose_cmd]
    data.pose_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [reset_cmd]
    data.reset_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [speed_cmd]
    data.speed_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [gripper_spacing_cmd]
    data.gripper_spacing_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [torque_cmd]
    data.torque_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [torque_lev_cmd]
    data.torque_lev_cmd = _deserializer.int8(buffer, bufferOffset);
    // Deserialize message field [super_cmd]
    data.super_cmd = _deserializer.int8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 13;
  }

  static datatype() {
    // Returns string type for a message object
    return 'sagittarius_joy/arm_joy';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'aee021bfef1da6cac98533007e49228c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    # This message is used specifically in the sagittarius_joy package
    #
    # Maps raw 'joy' commands to more specific ones to control an sagittarius
    
    # enum values that define the joystick controls for the robot
    
    #########################################################################################################
    
    # Control the motion of the virtual 'ee_gripper_link' or end effector using the modern_robotics_ik engine
    # Position Control
    int8 EE_X_INC = 1
    int8 EE_X_DEC = 2
    int8 EE_Y_INC = 3
    int8 EE_Y_DEC = 4
    int8 EE_Z_INC = 5
    int8 EE_Z_DEC = 6
    
    # Orientation Control
    int8 EE_ROLL_CCW = 7
    int8 EE_ROLL_CW = 8
    int8 EE_PITCH_UP = 9
    int8 EE_PITCH_DOWN = 10
    int8 EE_YAW_LEFT = 11
    int8 EE_YAW_RIGHT = 12
    
    #########################################################################################################
    
    # Control the motion of independent joints on the Arm or send predefined robot poses
    # Pose Control
    int8 UP_POSE = 13
    int8 HOME_POSE = 14
    int8 SLEEP_POSE = 15
    
    # Position and Orientation reset
    int8 POSITION_RESET = 16
    int8 ORIENTATION_RESET = 17
    
    #########################################################################################################
    
    # Customize configurations for the Sagittarius Arm
    # Inc/Dec Joint speed
    int8 SPEED_INC = 18
    int8 SPEED_DEC = 19
    
    # Inc/Dec Gripper spacing
    int8 GRIPPER_SPACING_INC = 20
    int8 GRIPPER_SPACING_DEC = 21
    
    # Torque On/Off all servos
    int8 TORQUE_ON = 22
    int8 TORQUE_OFF = 23
    
    # Torque Inc/Dec all servos
    int8 TORQUE_INC = 24
    int8 TORQUE_DEC = 25
    
    #########################################################################################################
    
    # Other function for the Sagittarius Arm
    # Super Key
    int8 SUPER_KEY = 26
    
    #########################################################################################################
    
    # Control the motion of the Sagittarius Arm
    int8 ee_x_cmd
    int8 ee_y_cmd
    int8 ee_z_cmd
    int8 ee_roll_cmd
    int8 ee_pitch_cmd
    int8 ee_yaw_cmd
    
    # Independent Joint/Pose Control
    int8 pose_cmd
    int8 reset_cmd
    
    # Misc. Configs
    int8 speed_cmd
    int8 gripper_spacing_cmd
    int8 torque_cmd
    int8 torque_lev_cmd
    
    # Super key
    int8 super_cmd
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new arm_joy(null);
    if (msg.ee_x_cmd !== undefined) {
      resolved.ee_x_cmd = msg.ee_x_cmd;
    }
    else {
      resolved.ee_x_cmd = 0
    }

    if (msg.ee_y_cmd !== undefined) {
      resolved.ee_y_cmd = msg.ee_y_cmd;
    }
    else {
      resolved.ee_y_cmd = 0
    }

    if (msg.ee_z_cmd !== undefined) {
      resolved.ee_z_cmd = msg.ee_z_cmd;
    }
    else {
      resolved.ee_z_cmd = 0
    }

    if (msg.ee_roll_cmd !== undefined) {
      resolved.ee_roll_cmd = msg.ee_roll_cmd;
    }
    else {
      resolved.ee_roll_cmd = 0
    }

    if (msg.ee_pitch_cmd !== undefined) {
      resolved.ee_pitch_cmd = msg.ee_pitch_cmd;
    }
    else {
      resolved.ee_pitch_cmd = 0
    }

    if (msg.ee_yaw_cmd !== undefined) {
      resolved.ee_yaw_cmd = msg.ee_yaw_cmd;
    }
    else {
      resolved.ee_yaw_cmd = 0
    }

    if (msg.pose_cmd !== undefined) {
      resolved.pose_cmd = msg.pose_cmd;
    }
    else {
      resolved.pose_cmd = 0
    }

    if (msg.reset_cmd !== undefined) {
      resolved.reset_cmd = msg.reset_cmd;
    }
    else {
      resolved.reset_cmd = 0
    }

    if (msg.speed_cmd !== undefined) {
      resolved.speed_cmd = msg.speed_cmd;
    }
    else {
      resolved.speed_cmd = 0
    }

    if (msg.gripper_spacing_cmd !== undefined) {
      resolved.gripper_spacing_cmd = msg.gripper_spacing_cmd;
    }
    else {
      resolved.gripper_spacing_cmd = 0
    }

    if (msg.torque_cmd !== undefined) {
      resolved.torque_cmd = msg.torque_cmd;
    }
    else {
      resolved.torque_cmd = 0
    }

    if (msg.torque_lev_cmd !== undefined) {
      resolved.torque_lev_cmd = msg.torque_lev_cmd;
    }
    else {
      resolved.torque_lev_cmd = 0
    }

    if (msg.super_cmd !== undefined) {
      resolved.super_cmd = msg.super_cmd;
    }
    else {
      resolved.super_cmd = 0
    }

    return resolved;
    }
};

// Constants for message
arm_joy.Constants = {
  EE_X_INC: 1,
  EE_X_DEC: 2,
  EE_Y_INC: 3,
  EE_Y_DEC: 4,
  EE_Z_INC: 5,
  EE_Z_DEC: 6,
  EE_ROLL_CCW: 7,
  EE_ROLL_CW: 8,
  EE_PITCH_UP: 9,
  EE_PITCH_DOWN: 10,
  EE_YAW_LEFT: 11,
  EE_YAW_RIGHT: 12,
  UP_POSE: 13,
  HOME_POSE: 14,
  SLEEP_POSE: 15,
  POSITION_RESET: 16,
  ORIENTATION_RESET: 17,
  SPEED_INC: 18,
  SPEED_DEC: 19,
  GRIPPER_SPACING_INC: 20,
  GRIPPER_SPACING_DEC: 21,
  TORQUE_ON: 22,
  TORQUE_OFF: 23,
  TORQUE_INC: 24,
  TORQUE_DEC: 25,
  SUPER_KEY: 26,
}

module.exports = arm_joy;
