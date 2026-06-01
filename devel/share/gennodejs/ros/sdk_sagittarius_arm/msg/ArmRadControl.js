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

class ArmRadControl {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.rad = null;
    }
    else {
      if (initObj.hasOwnProperty('rad')) {
        this.rad = initObj.rad
      }
      else {
        this.rad = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ArmRadControl
    // Serialize message field [rad]
    bufferOffset = _arraySerializer.float64(obj.rad, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ArmRadControl
    let len;
    let data = new ArmRadControl(null);
    // Deserialize message field [rad]
    data.rad = _arrayDeserializer.float64(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 8 * object.rad.length;
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'sdk_sagittarius_arm/ArmRadControl';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '11133516b4bf16d55157ff6eccb0ffe0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 目标位置的数组
    
    float64[] rad
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ArmRadControl(null);
    if (msg.rad !== undefined) {
      resolved.rad = msg.rad;
    }
    else {
      resolved.rad = []
    }

    return resolved;
    }
};

module.exports = ArmRadControl;
