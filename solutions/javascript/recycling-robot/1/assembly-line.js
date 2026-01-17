// @ts-check

import { ElectronicDevice } from './lib.js';

export function isBoolean(value) {
  return typeof value === 'boolean';
}

export function isNumber(value) {
  if (typeof value === 'bigint') return true;
  if (typeof value !== 'number') return false;
  return Number.isFinite(value);
}

export function isObject(value) {
  return value !== null && typeof value === 'object';
}

export function isNumericString(value) {
  if (typeof value !== 'string') return false;
  if (value === '') return false;
  
  const str = value[0] === '-' ? value.slice(1) : value;
  if (str === '') return false;
  
  for (let i = 0; i < str.length; i++) {
    const char = str[i];
    if (char < '0' || char > '9') return false;
  }
  return true;
}

export function isElectronic(object) {
  return object instanceof ElectronicDevice;
}

export function isNonEmptyArray(value) {
  return Array.isArray(value) && value.length > 0;
}

export function isEmptyArray(value) {
  return Array.isArray(value) && value.length === 0;
}

export function hasType(object) {
  return 'type' in object;
}

export function assertHasId(object) {
  if (!('id' in object)) {
    throw new Error("Object is missing the 'id' property");
  }
}

export function hasIdProperty(object) {
  return Object.hasOwn(object, 'id');
}

export function hasDefinedType(object) {
  // Check if object has its own 'type' property and it's not undefined
  return Object.hasOwn(object, 'type') && object.type !== undefined;
}