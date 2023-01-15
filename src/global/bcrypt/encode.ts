import * as fs from 'fs';
import * as CryptoJS from 'crypto-js';
import * as bcrypt from 'bcrypt';
import * as jwt from 'jsonwebtoken';
const privateKey = fs.readFileSync(
  `src/global/secretKey/PrivateKey.key`,
  'utf8',
);
const privateRefreshTokenKey = fs.readFileSync(
  `src/global/secretKey/PrivateRefreshKey.key`,
  'utf-8'
)

export class BcryptUtils {
  endCode = (text: string) => {
    return new Promise(async (resolve) => {
      let cipher_text = CryptoJS.AES.encrypt(text, privateKey).toString();
      resolve(cipher_text);
    });
  };

  deCode = (token: string) => {
    return new Promise(async (resolve, reject) => {
      await jwt.verify(token, privateKey, (err, decoded) => {
        if(err !== null) {
          reject(err)
        }
        resolve(decoded);
      });
    });
  };

  deCrypt = async (text: string) => {
    let bytes = await CryptoJS.AES.decrypt(text, privateKey);
    let originalText = await bytes.toString(CryptoJS.enc.Utf8);
    return originalText;
  };

  hashData = (text: string) => {
    return new Promise(async (resolve) => {
      bcrypt.hash(text, 10, async (err, hash) => {
        resolve(hash);
      });
    });
  };

  compareData = (text: string, hash: string) => {
    return new Promise(async (resolve) => {
      bcrypt.compare(text, hash, async (err, match) => {
        resolve(match);
      });
    });
  };

  jwtEncode = async (user_profile) => {
    return new Promise(async (resolve) => {
      const accessToken = await jwt.sign(user_profile, privateKey, {
        expiresIn: '15m',
      });
      resolve(accessToken);
    });
  };

  refreshJwtEndcode = async (user_profile) => {
    return  new Promise(async (resolve) => {
      const refreshToken = await jwt.sign(user_profile, privateRefreshTokenKey, {
        expiresIn: '24hr',
      });
      resolve(refreshToken);
    });
  }

  refreshTokenSign = async (refresh_token) => {
    return new Promise(async (resolve, reject) => {
      await jwt.verify(refresh_token, privateRefreshTokenKey, (err, decoded) => {
        if(err !== null) {
          reject(err)
        }
        resolve(decoded);
      });
    });
  }
}
