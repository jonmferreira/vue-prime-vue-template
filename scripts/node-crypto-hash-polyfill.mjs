import nodeCrypto from 'node:crypto';

const { webcrypto, createHash } = nodeCrypto;

const cryptoTarget = globalThis.crypto ?? webcrypto ?? {};

if (!globalThis.crypto) {
  globalThis.crypto = cryptoTarget;
}

if (webcrypto && globalThis.crypto !== webcrypto) {
  for (const key of Reflect.ownKeys(webcrypto)) {
    if (!(key in globalThis.crypto)) {
      const descriptor = Object.getOwnPropertyDescriptor(webcrypto, key);
      if (descriptor) {
        Object.defineProperty(globalThis.crypto, key, descriptor);
      }
    }
  }
}

if (typeof globalThis.crypto.hash !== 'function') {
  globalThis.crypto.hash = function hash(algorithm, data, outputEncoding = 'hex') {
    const hash = createHash(algorithm);
    if (typeof data === 'string' || ArrayBuffer.isView(data) || data instanceof ArrayBuffer) {
      hash.update(data);
    } else {
      hash.update(Buffer.from(data));
    }
    return outputEncoding ? hash.digest(outputEncoding) : hash.digest();
  };
}
