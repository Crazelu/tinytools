import 'dart:convert';
import 'dart:typed_data';
import 'package:asn1lib/asn1lib.dart';
import 'package:flutter/material.dart';
import 'package:pointycastle/export.dart' as pointy;

enum EncryptionKeyType { private, public }

class EncryptionHelper {
  /// Encrypts [plainText] with [key].
  String encrypt(
    String plainText,
    String key, {
    EncryptionKeyType encryptionKeyType = EncryptionKeyType.public,
  }) {
    try {
      final cipher = _getCipher(key, encryptionKeyType, true);
      final data = _processInBlocks(cipher, utf8.encode(plainText));
      return base64.encode(data);
    } catch (e) {
      debugPrint('$e');
    }
    return '';
  }

  /// Decrypt [cipherText] with [key]
  String decrypt(
    String cipherText,
    String key, {
    EncryptionKeyType encryptionKeyType = EncryptionKeyType.public,
  }) {
    try {
      final messageData = base64.decode(cipherText);

      final cipher = _getCipher(key, encryptionKeyType, false);
      final data = _processInBlocks(cipher, messageData);
      return utf8.decode(data);
    } catch (e) {
      debugPrint('$e');
    }
    return '';
  }

  pointy.RSAPublicKey _getPublicKey(String publicKeyString) {
    List<int> publicKeyDER = base64Decode(publicKeyString);
    final asn1Parser = ASN1Parser(publicKeyDER as Uint8List);
    final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;
    final publicKeyBitString = topLevelSeq.elements[1];

    final publicKeyAsn = ASN1Parser(publicKeyBitString.contentBytes());
    final publicKeySeq = publicKeyAsn.nextObject() as ASN1Sequence;
    final modulus = publicKeySeq.elements[0] as ASN1Integer;
    final exponent = publicKeySeq.elements[1] as ASN1Integer;

    return pointy.RSAPublicKey(
      modulus.valueAsBigInteger,
      exponent.valueAsBigInteger,
    );
  }

  pointy.RSAPrivateKey _getPrivateKey(String privateKeyString) {
    List<int> privateKeyDER = base64Decode(privateKeyString);
    var asn1Parser = ASN1Parser(privateKeyDER as Uint8List);
    final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;
    final privateKey = topLevelSeq.elements[2];

    asn1Parser = ASN1Parser(privateKey.contentBytes());
    final pkSeq = asn1Parser.nextObject() as ASN1Sequence;

    final modulus = pkSeq.elements[1] as ASN1Integer;
    final privateExponent = pkSeq.elements[3] as ASN1Integer;
    final p = pkSeq.elements[4] as ASN1Integer;
    final q = pkSeq.elements[5] as ASN1Integer;

    return pointy.RSAPrivateKey(
      modulus.valueAsBigInteger,
      privateExponent.valueAsBigInteger,
      p.valueAsBigInteger,
      q.valueAsBigInteger,
    );
  }

  pointy.PKCS1Encoding _getCipher(
    String key,
    EncryptionKeyType encryptionKeyType,
    bool forEncryption,
  ) {
    final cipher = pointy.PKCS1Encoding(pointy.RSAEngine());
    pointy.CipherParameters cipherParameters;

    if (encryptionKeyType == EncryptionKeyType.public) {
      cipherParameters =
          pointy.PublicKeyParameter<pointy.RSAPublicKey>(_getPublicKey(key));
    } else {
      cipherParameters =
          pointy.PrivateKeyParameter<pointy.RSAPrivateKey>(_getPrivateKey(key));
    }

    cipher.init(forEncryption, cipherParameters);
    return cipher;
  }

  Uint8List _processInBlocks(
    pointy.AsymmetricBlockCipher engine,
    Uint8List input,
  ) {
    final numBlocks = input.length ~/ engine.inputBlockSize +
        ((input.length % engine.inputBlockSize != 0) ? 1 : 0);

    final output = Uint8List(numBlocks * engine.outputBlockSize);

    var inputOffset = 0;
    var outputOffset = 0;
    while (inputOffset < input.length) {
      final chunkSize = (inputOffset + engine.inputBlockSize <= input.length)
          ? engine.inputBlockSize
          : input.length - inputOffset;

      outputOffset += engine.processBlock(
        input,
        inputOffset,
        chunkSize,
        output,
        outputOffset,
      );

      inputOffset += chunkSize;
    }

    return (output.length == outputOffset)
        ? output
        : output.sublist(0, outputOffset);
  }
}
