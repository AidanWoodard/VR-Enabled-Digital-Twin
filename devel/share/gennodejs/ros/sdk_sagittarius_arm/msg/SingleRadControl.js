// Auto-generated. Do not edit!

// (in-package sdk_sagittarius_arm.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class SingleRadControl {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.joint_name = null;
      this.rad = null;
    }
    else {
      if (initObj.hasOwnProperty('joint_name')) {
        this.joint_name = initObj.joint_name
      }
      else {
        this.joint_name = '';
      }
      if (initObj.hasOwnProperty('rad')) {
        this.rad = initObj.rad
      }
      else {
        this.rad = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SingleRadControl
    // Serialize message field [joint_name]
    bufferOffset = _serializer.string(obj.joint_name, buffer, bufferOffset);
    // Serialize message field [rad]
    bufferOffset = _serializer.float64(obj.rad, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SingleRadControl
    let len;
    let data = new SingleRadControl(null);
    // Deserialize message field [joint_name]
    data.joint_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [rad]
    data.rad = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.joint_name);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'sdk_sagittarius_arm/SingleRadControl';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '22b26ccad5f2f7c78e2804a1f134b947';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 单个舵机控制
    
    string joint_name
    float64 rad
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SingleRadControl(null);
    if (msg.joint_name !== undefined) {
      resolved.joint_name = msg.joint_name;
    }
    else {
      resolved.joint_name = ''
    }

    if (msg.rad !== undefined) {
      resolved.rad = msg.rad;
    }
    else {
      resolved.rad = 0.0
    }

    return resolved;
    }
};

module.exports = SingleRadControl;
