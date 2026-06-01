// Auto-generated. Do not edit!

// (in-package sdk_sagittarius_arm.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class ServoRtInfoRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.servo_id = null;
    }
    else {
      if (initObj.hasOwnProperty('servo_id')) {
        this.servo_id = initObj.servo_id
      }
      else {
        this.servo_id = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ServoRtInfoRequest
    // Serialize message field [servo_id]
    bufferOffset = _serializer.uint8(obj.servo_id, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ServoRtInfoRequest
    let len;
    let data = new ServoRtInfoRequest(null);
    // Deserialize message field [servo_id]
    data.servo_id = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sdk_sagittarius_arm/ServoRtInfoRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'acb16072ea21cd71e884ac51239c2a0c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Get servo realtime state
    # servo_id : 1~7
    
    uint8 servo_id
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ServoRtInfoRequest(null);
    if (msg.servo_id !== undefined) {
      resolved.servo_id = msg.servo_id;
    }
    else {
      resolved.servo_id = 0
    }

    return resolved;
    }
};

class ServoRtInfoResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.speed = null;
      this.payload = null;
      this.voltage = null;
      this.current = null;
    }
    else {
      if (initObj.hasOwnProperty('speed')) {
        this.speed = initObj.speed
      }
      else {
        this.speed = 0;
      }
      if (initObj.hasOwnProperty('payload')) {
        this.payload = initObj.payload
      }
      else {
        this.payload = 0;
      }
      if (initObj.hasOwnProperty('voltage')) {
        this.voltage = initObj.voltage
      }
      else {
        this.voltage = 0;
      }
      if (initObj.hasOwnProperty('current')) {
        this.current = initObj.current
      }
      else {
        this.current = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ServoRtInfoResponse
    // Serialize message field [speed]
    bufferOffset = _serializer.int16(obj.speed, buffer, bufferOffset);
    // Serialize message field [payload]
    bufferOffset = _serializer.int16(obj.payload, buffer, bufferOffset);
    // Serialize message field [voltage]
    bufferOffset = _serializer.uint8(obj.voltage, buffer, bufferOffset);
    // Serialize message field [current]
    bufferOffset = _serializer.uint16(obj.current, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ServoRtInfoResponse
    let len;
    let data = new ServoRtInfoResponse(null);
    // Deserialize message field [speed]
    data.speed = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [payload]
    data.payload = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [voltage]
    data.voltage = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [current]
    data.current = _deserializer.uint16(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 7;
  }

  static datatype() {
    // Returns string type for a service object
    return 'sdk_sagittarius_arm/ServoRtInfoResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '15d6e070ac72abaf596d9dae7ca80e56';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    # return the realtime state
    # speed(50step/s)
    # payload(0.1%)
    # voltage(0.1V)
    # current(1mA)
    int16 speed
    int16 payload
    uint8 voltage
    uint16 current
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ServoRtInfoResponse(null);
    if (msg.speed !== undefined) {
      resolved.speed = msg.speed;
    }
    else {
      resolved.speed = 0
    }

    if (msg.payload !== undefined) {
      resolved.payload = msg.payload;
    }
    else {
      resolved.payload = 0
    }

    if (msg.voltage !== undefined) {
      resolved.voltage = msg.voltage;
    }
    else {
      resolved.voltage = 0
    }

    if (msg.current !== undefined) {
      resolved.current = msg.current;
    }
    else {
      resolved.current = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: ServoRtInfoRequest,
  Response: ServoRtInfoResponse,
  md5sum() { return 'd3106e0c44e7c7adcad01214d53da198'; },
  datatype() { return 'sdk_sagittarius_arm/ServoRtInfo'; }
};
