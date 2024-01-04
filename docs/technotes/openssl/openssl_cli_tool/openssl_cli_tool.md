# OpenSSL CLI Tool
__Last updated: 04-JAN-2024__

## Introduction
This document contains a number of samples to show,
how to use the OpenSSL CLI tool _openssl_ on a 
Linux system.

The samples are executed on a Debian 12.4 system with
the __OpenSSL 3.0.11__ software.


## Hashing
Sample file to hash:
```
$ cat text.txt
Don't Panic!
```

```
$ openssl dgst -sha256 <file>
  or
$ openssl dgst -sha256 -out <file>.sha256 <file> 
```

__Samples__
```
$ openssl dgst -sha256 text.txt
SHA2-256(text.txt)= 9538e1742668b3ab26f7b5c77a817b74089c0a1cb38c73ec1ab4550f43f4312e

or

$ openssl dgst -r -sha256 text.txt
9538e1742668b3ab26f7b5c77a817b74089c0a1cb38c73ec1ab4550f43f4312e *text.txt
```

```
$ openssl dgst -sha256 -out text.txt.sha256 text.txt
$ cat text.txt.sha256
SHA2-256(text.txt)= 9538e1742668b3ab26f7b5c77a817b74089c0a1cb38c73ec1ab4550f43f4312e

or

$ openssl dgst -r -sha256 -out text.txt.sha256 text.txt
maro@zwijger:~/develop/OpenSSL$ cat text.txt.sha256
9538e1742668b3ab26f7b5c77a817b74089c0a1cb38c73ec1ab4550f43f4312e *text.txt
```

Usually the following digests (hash algorithms) are used

* -md5
* -sha1
* -sha224
* -sha256
* -sha384
* -sha512
* -sha3-224
* -sha3-256
* -sha3-384
* -sha3-512


### HMAC Hashing
```
$ openssl dgst -sha256 -hmac <password> <file>
  or
$ openssl dgst -sha256 -hmac <password> -out <file>.hmac-sha256 <file> 
```

__Sample__
```
$ openssl dgst -sha256 -hmac secret text.txt
HMAC-SHA2-256(text.txt)= fb6edba3a69cadb92c9cb754953f8ac424ff7e08d59a0d525e38af8e976679ae
```

### Available Hash (Digest) Algorithms
```
$ openssl dgst -list
Supported digests:
-blake2b512                -blake2s256                -md4
-md5                       -md5-sha1                  -ripemd
-ripemd160                 -rmd160                    -sha1
-sha224                    -sha256                    -sha3-224
-sha3-256                  -sha3-384                  -sha3-512
-sha384                    -sha512                    -sha512-224
-sha512-256                -shake128                  -shake256
-sm3                       -ssl3-md5                  -ssl3-sha1
-whirlpool
```

## BASE64 Encoding/Decoding
Sample file:
```
$ cat text.txt
Don't Panic!
```

### Encoding
```
$ openssl enc -e -base64 -in text.txt
RG9uJ3QgUGFuaWMhCg==
#
$ openssl enc -e -base64 -in text.txt -out text.txt.base64
$ cat text.txt.base64
RG9uJ3QgUGFuaWMhCg==
```

Longer BASE64 output is wrapped into lines with 
64 characters:

```
IyEvYmluL2Jhc2gKIwojIDIwLU9DVC0yMDIyCiMKc2V0IC14CmNkIG9wZW5zc2wg
...
dGVNaW5pbWFsUnVudGltZUVudmlyb25tZW50IC1mCmZpCiMKZXhpdCAwCgo=
```

### Decoding
```
$ openssl enc -d -base64 -in text.txt.base64
Don't Panic!
```

## Symmetric Encryption/Decryption
### Encryption
```
$ openssl enc -aes256 -e -a -in <file> -pbkdf2 -pass pass:<passphrase> -out <file>.enc
```

__Sample__
```
$ openssl enc -aes256 -e -a -in text.txt -pbkdf2 -pass pass:secret -out text.txt.enc
$ cat text.txt.enc
U2FsdGVkX19VrTiWm0ydFabNrTp7MS9kjg4gKsQo5O8=
```

### Decryption
```
$ openssl enc -aes256 -d -a -in <file>.enc -pbkdf2 -pass pass:secret -out <file>
```

__Sample__
```
$ openssl enc -aes256 -d -a -in text.txt.enc -pbkdf2 -pass pass:secret -out text2.txt
$ cat text2.txt
Don't Panic!
```

### Available Symmetric Encryption (Cipher) Algorithms
```
$ openssl enc -list
Supported ciphers:
-aes-128-cbc               -aes-128-cfb               -aes-128-cfb1
-aes-128-cfb8              -aes-128-ctr               -aes-128-ecb
-aes-128-ofb               -aes-192-cbc               -aes-192-cfb
-aes-192-cfb1              -aes-192-cfb8              -aes-192-ctr
-aes-192-ecb               -aes-192-ofb               -aes-256-cbc
-aes-256-cfb               -aes-256-cfb1              -aes-256-cfb8
-aes-256-ctr               -aes-256-ecb               -aes-256-ofb
-aes128                    -aes128-wrap               -aes192
-aes192-wrap               -aes256                    -aes256-wrap
-aria-128-cbc              -aria-128-cfb              -aria-128-cfb1
-aria-128-cfb8             -aria-128-ctr              -aria-128-ecb
-aria-128-ofb              -aria-192-cbc              -aria-192-cfb
-aria-192-cfb1             -aria-192-cfb8             -aria-192-ctr
-aria-192-ecb              -aria-192-ofb              -aria-256-cbc
-aria-256-cfb              -aria-256-cfb1             -aria-256-cfb8
-aria-256-ctr              -aria-256-ecb              -aria-256-ofb
-aria128                   -aria192                   -aria256
-bf                        -bf-cbc                    -bf-cfb
-bf-ecb                    -bf-ofb                    -blowfish
-camellia-128-cbc          -camellia-128-cfb          -camellia-128-cfb1
-camellia-128-cfb8         -camellia-128-ctr          -camellia-128-ecb
-camellia-128-ofb          -camellia-192-cbc          -camellia-192-cfb
-camellia-192-cfb1         -camellia-192-cfb8         -camellia-192-ctr
-camellia-192-ecb          -camellia-192-ofb          -camellia-256-cbc
-camellia-256-cfb          -camellia-256-cfb1         -camellia-256-cfb8
-camellia-256-ctr          -camellia-256-ecb          -camellia-256-ofb
-camellia128               -camellia192               -camellia256
-cast                      -cast-cbc                  -cast5-cbc
-cast5-cfb                 -cast5-ecb                 -cast5-ofb
-chacha20                  -des                       -des-cbc
-des-cfb                   -des-cfb1                  -des-cfb8
-des-ecb                   -des-ede                   -des-ede-cbc
-des-ede-cfb               -des-ede-ecb               -des-ede-ofb
-des-ede3                  -des-ede3-cbc              -des-ede3-cfb
-des-ede3-cfb1             -des-ede3-cfb8             -des-ede3-ecb
-des-ede3-ofb              -des-ofb                   -des3
-des3-wrap                 -desx                      -desx-cbc
-id-aes128-wrap            -id-aes128-wrap-pad        -id-aes192-wrap
-id-aes192-wrap-pad        -id-aes256-wrap            -id-aes256-wrap-pad
-id-smime-alg-CMS3DESwrap  -rc2                       -rc2-128
-rc2-40                    -rc2-40-cbc                -rc2-64
-rc2-64-cbc                -rc2-cbc                   -rc2-cfb
-rc2-ecb                   -rc2-ofb                   -rc4
-rc4-40                    -seed                      -seed-cbc
-seed-cfb                  -seed-ecb                  -seed-ofb
-sm4                       -sm4-cbc                   -sm4-cfb
-sm4-ctr                   -sm4-ecb                   -sm4-ofb
```

## Public/Private Key Handling
### Private Key Creation
#### RSA Key
```
$ openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 \
    -aes128 -out private_rsa.key -pass pass:changeit
$ chmod 600 private_rsa.key
$ file private_rsa.key
private_rsa.key: ASCII text
$ cat private_rsa.key
-----BEGIN ENCRYPTED PRIVATE KEY-----
MII...
...
...3uo
-----END ENCRYPTED PRIVATE KEY-----
```

#### RSA-PSS Key
```
$ openssl genpkey -algorithm RSA-PSS -pkeyopt rsa_keygen_bits:4096 -aes128 -out private_rsapss.key -pass pass:changeit
$ chmod 600 private_rsapss.key
$ cat private_rsapss.key
-----BEGIN ENCRYPTED PRIVATE KEY-----
MII...
...
...Kvy
-----END ENCRYPTED PRIVATE KEY-----
```

#### Elliptic Curve Key
```
$ openssl genpkey -algorithm ec -pkeyopt ec_paramgen_curve:prime256v1 -aes128 -out private_ecprime256v1.key -pass pass:changeit
$ chmod 600 private_ecprime256v1.key
$ cat  private_ecprime256v1.key
-----BEGIN ENCRYPTED PRIVATE KEY-----
MIH...
...
...XU=
-----END ENCRYPTED PRIVATE KEY-----
```

List of all available elliptic curves:
```
$ openssl ecparam -list_curves
  secp112r1 : SECG/WTLS curve over a 112 bit prime field
  secp112r2 : SECG curve over a 112 bit prime field
  secp128r1 : SECG curve over a 128 bit prime field
  secp128r2 : SECG curve over a 128 bit prime field
  secp160k1 : SECG curve over a 160 bit prime field
  secp160r1 : SECG curve over a 160 bit prime field
  secp160r2 : SECG/WTLS curve over a 160 bit prime field
  secp192k1 : SECG curve over a 192 bit prime field
  secp224k1 : SECG curve over a 224 bit prime field
  secp224r1 : NIST/SECG curve over a 224 bit prime field
  secp256k1 : SECG curve over a 256 bit prime field
  secp384r1 : NIST/SECG curve over a 384 bit prime field
  secp521r1 : NIST/SECG curve over a 521 bit prime field
  prime192v1: NIST/X9.62/SECG curve over a 192 bit prime field
  prime192v2: X9.62 curve over a 192 bit prime field
  prime192v3: X9.62 curve over a 192 bit prime field
  prime239v1: X9.62 curve over a 239 bit prime field
  prime239v2: X9.62 curve over a 239 bit prime field
  prime239v3: X9.62 curve over a 239 bit prime field
  prime256v1: X9.62/SECG curve over a 256 bit prime field
  sect113r1 : SECG curve over a 113 bit binary field
  sect113r2 : SECG curve over a 113 bit binary field
  sect131r1 : SECG/WTLS curve over a 131 bit binary field
  sect131r2 : SECG curve over a 131 bit binary field
  sect163k1 : NIST/SECG/WTLS curve over a 163 bit binary field
  sect163r1 : SECG curve over a 163 bit binary field
  sect163r2 : NIST/SECG curve over a 163 bit binary field
  sect193r1 : SECG curve over a 193 bit binary field
  sect193r2 : SECG curve over a 193 bit binary field
  sect233k1 : NIST/SECG/WTLS curve over a 233 bit binary field
  sect233r1 : NIST/SECG/WTLS curve over a 233 bit binary field
  sect239k1 : SECG curve over a 239 bit binary field
  sect283k1 : NIST/SECG curve over a 283 bit binary field
  sect283r1 : NIST/SECG curve over a 283 bit binary field
  sect409k1 : NIST/SECG curve over a 409 bit binary field
  sect409r1 : NIST/SECG curve over a 409 bit binary field
  sect571k1 : NIST/SECG curve over a 571 bit binary field
  sect571r1 : NIST/SECG curve over a 571 bit binary field
  c2pnb163v1: X9.62 curve over a 163 bit binary field
  c2pnb163v2: X9.62 curve over a 163 bit binary field
  c2pnb163v3: X9.62 curve over a 163 bit binary field
  c2pnb176v1: X9.62 curve over a 176 bit binary field
  c2tnb191v1: X9.62 curve over a 191 bit binary field
  c2tnb191v2: X9.62 curve over a 191 bit binary field
  c2tnb191v3: X9.62 curve over a 191 bit binary field
  c2pnb208w1: X9.62 curve over a 208 bit binary field
  c2tnb239v1: X9.62 curve over a 239 bit binary field
  c2tnb239v2: X9.62 curve over a 239 bit binary field
  c2tnb239v3: X9.62 curve over a 239 bit binary field
  c2pnb272w1: X9.62 curve over a 272 bit binary field
  c2pnb304w1: X9.62 curve over a 304 bit binary field
  c2tnb359v1: X9.62 curve over a 359 bit binary field
  c2pnb368w1: X9.62 curve over a 368 bit binary field
  c2tnb431r1: X9.62 curve over a 431 bit binary field
  wap-wsg-idm-ecid-wtls1: WTLS curve over a 113 bit binary field
  wap-wsg-idm-ecid-wtls3: NIST/SECG/WTLS curve over a 163 bit binary field
  wap-wsg-idm-ecid-wtls4: SECG curve over a 113 bit binary field
  wap-wsg-idm-ecid-wtls5: X9.62 curve over a 163 bit binary field
  wap-wsg-idm-ecid-wtls6: SECG/WTLS curve over a 112 bit prime field
  wap-wsg-idm-ecid-wtls7: SECG/WTLS curve over a 160 bit prime field
  wap-wsg-idm-ecid-wtls8: WTLS curve over a 112 bit prime field
  wap-wsg-idm-ecid-wtls9: WTLS curve over a 160 bit prime field
  wap-wsg-idm-ecid-wtls10: NIST/SECG/WTLS curve over a 233 bit binary field
  wap-wsg-idm-ecid-wtls11: NIST/SECG/WTLS curve over a 233 bit binary field
  wap-wsg-idm-ecid-wtls12: WTLS curve over a 224 bit prime field
  Oakley-EC2N-3:
        IPSec/IKE/Oakley curve #3 over a 155 bit binary field.
        Not suitable for ECDSA.
        Questionable extension field!
  Oakley-EC2N-4:
        IPSec/IKE/Oakley curve #4 over a 185 bit binary field.
        Not suitable for ECDSA.
        Questionable extension field!
  brainpoolP160r1: RFC 5639 curve over a 160 bit prime field
  brainpoolP160t1: RFC 5639 curve over a 160 bit prime field
  brainpoolP192r1: RFC 5639 curve over a 192 bit prime field
  brainpoolP192t1: RFC 5639 curve over a 192 bit prime field
  brainpoolP224r1: RFC 5639 curve over a 224 bit prime field
  brainpoolP224t1: RFC 5639 curve over a 224 bit prime field
  brainpoolP256r1: RFC 5639 curve over a 256 bit prime field
  brainpoolP256t1: RFC 5639 curve over a 256 bit prime field
  brainpoolP320r1: RFC 5639 curve over a 320 bit prime field
  brainpoolP320t1: RFC 5639 curve over a 320 bit prime field
  brainpoolP384r1: RFC 5639 curve over a 384 bit prime field
  brainpoolP384t1: RFC 5639 curve over a 384 bit prime field
  brainpoolP512r1: RFC 5639 curve over a 512 bit prime field
  brainpoolP512t1: RFC 5639 curve over a 512 bit prime field
  SM2       : SM2 curve over a 256 bit prime field
```

Get the related ASN1 OID and/or NIST CURVE names:
```
$ openssl ecparam -list_curves | grep ':' | awk -F: '{print $1;}' | sed -e 's/^[t ]*//g;s/[t ]*$//g' | sort | awk '
        BEGIN {
            print "List all available elliptic curves";
            print "----------";
        }
        {
            print $1;
            system("openssl ecparam -name "$1" -noout -text");
            print "----------";
        }
    '
List all available elliptic curves
----------
brainpoolP160r1
EC-Parameters: (160 bit)
ASN1 OID: brainpoolP160r1
----------
brainpoolP160t1
EC-Parameters: (160 bit)
ASN1 OID: brainpoolP160t1
----------
brainpoolP192r1
EC-Parameters: (192 bit)
ASN1 OID: brainpoolP192r1
----------
brainpoolP192t1
EC-Parameters: (192 bit)
ASN1 OID: brainpoolP192t1
----------
brainpoolP224r1
EC-Parameters: (224 bit)
ASN1 OID: brainpoolP224r1
----------
brainpoolP224t1
EC-Parameters: (224 bit)
ASN1 OID: brainpoolP224t1
----------
brainpoolP256r1
EC-Parameters: (256 bit)
ASN1 OID: brainpoolP256r1
----------
brainpoolP256t1
EC-Parameters: (256 bit)
ASN1 OID: brainpoolP256t1
----------
brainpoolP320r1
EC-Parameters: (320 bit)
ASN1 OID: brainpoolP320r1
----------
brainpoolP320t1
EC-Parameters: (320 bit)
ASN1 OID: brainpoolP320t1
----------
brainpoolP384r1
EC-Parameters: (384 bit)
ASN1 OID: brainpoolP384r1
----------
brainpoolP384t1
EC-Parameters: (384 bit)
ASN1 OID: brainpoolP384t1
----------
brainpoolP512r1
EC-Parameters: (512 bit)
ASN1 OID: brainpoolP512r1
----------
brainpoolP512t1
EC-Parameters: (512 bit)
ASN1 OID: brainpoolP512t1
----------
c2pnb163v1
EC-Parameters: (163 bit)
ASN1 OID: c2pnb163v1
----------
c2pnb163v2
EC-Parameters: (162 bit)
ASN1 OID: c2pnb163v2
----------
c2pnb163v3
EC-Parameters: (162 bit)
ASN1 OID: c2pnb163v3
----------
c2pnb176v1
EC-Parameters: (161 bit)
ASN1 OID: c2pnb176v1
----------
c2pnb208w1
EC-Parameters: (193 bit)
ASN1 OID: c2pnb208w1
----------
c2pnb272w1
EC-Parameters: (257 bit)
ASN1 OID: c2pnb272w1
----------
c2pnb304w1
EC-Parameters: (289 bit)
ASN1 OID: c2pnb304w1
----------
c2pnb368w1
EC-Parameters: (353 bit)
ASN1 OID: c2pnb368w1
----------
c2tnb191v1
EC-Parameters: (191 bit)
ASN1 OID: c2tnb191v1
----------
c2tnb191v2
EC-Parameters: (190 bit)
ASN1 OID: c2tnb191v2
----------
c2tnb191v3
EC-Parameters: (189 bit)
ASN1 OID: c2tnb191v3
----------
c2tnb239v1
EC-Parameters: (238 bit)
ASN1 OID: c2tnb239v1
----------
c2tnb239v2
EC-Parameters: (237 bit)
ASN1 OID: c2tnb239v2
----------
c2tnb239v3
EC-Parameters: (236 bit)
ASN1 OID: c2tnb239v3
----------
c2tnb359v1
EC-Parameters: (353 bit)
ASN1 OID: c2tnb359v1
----------
c2tnb431r1
EC-Parameters: (418 bit)
ASN1 OID: c2tnb431r1
----------
Oakley-EC2N-3
EC-Parameters: (154 bit)
Field Type: characteristic-two-field
Basis Type: tpBasis
Polynomial:
    08:00:00:00:00:00:00:00:00:00:00:00:40:00:00:
    00:00:00:00:01
A:    0
B:    471951 (0x7338f)
Generator (uncompressed):
    04:00:00:00:00:00:00:00:00:00:00:00:00:00:00:
    00:00:00:00:00:7b:00:00:00:00:00:00:00:00:00:
    00:00:00:00:00:00:00:00:00:01:c8
Order:
    02:aa:aa:aa:aa:aa:aa:aa:aa:aa:c7:f3:c7:88:1b:
    d0:86:8f:a8:6c
Cofactor:  3 (0x3)
----------
Oakley-EC2N-4
EC-Parameters: (184 bit)
Field Type: characteristic-two-field
Basis Type: tpBasis
Polynomial:
    02:00:00:00:00:00:00:00:00:00:00:00:00:00:00:
    20:00:00:00:00:00:00:00:01
A:    0
B:    7913 (0x1ee9)
Generator (uncompressed):
    04:00:00:00:00:00:00:00:00:00:00:00:00:00:00:
    00:00:00:00:00:00:00:00:00:18:00:00:00:00:00:
    00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:
    00:00:00:0d
Order:
    00:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ff:ed:f9:7c:
    44:db:9f:24:20:ba:fc:a7:5e
Cofactor:  2 (0x2)
----------
prime192v1
EC-Parameters: (192 bit)
ASN1 OID: prime192v1
NIST CURVE: P-192
----------
prime192v2
EC-Parameters: (192 bit)
ASN1 OID: prime192v2
----------
prime192v3
EC-Parameters: (192 bit)
ASN1 OID: prime192v3
----------
prime239v1
EC-Parameters: (239 bit)
ASN1 OID: prime239v1
----------
prime239v2
EC-Parameters: (239 bit)
ASN1 OID: prime239v2
----------
prime239v3
EC-Parameters: (239 bit)
ASN1 OID: prime239v3
----------
prime256v1
EC-Parameters: (256 bit)
ASN1 OID: prime256v1
NIST CURVE: P-256
----------
secp112r1
EC-Parameters: (112 bit)
ASN1 OID: secp112r1
----------
secp112r2
EC-Parameters: (110 bit)
ASN1 OID: secp112r2
----------
secp128r1
EC-Parameters: (128 bit)
ASN1 OID: secp128r1
----------
secp128r2
EC-Parameters: (126 bit)
ASN1 OID: secp128r2
----------
secp160k1
EC-Parameters: (161 bit)
ASN1 OID: secp160k1
----------
secp160r1
EC-Parameters: (161 bit)
ASN1 OID: secp160r1
----------
secp160r2
EC-Parameters: (161 bit)
ASN1 OID: secp160r2
----------
secp192k1
EC-Parameters: (192 bit)
ASN1 OID: secp192k1
----------
secp224k1
EC-Parameters: (225 bit)
ASN1 OID: secp224k1
----------
secp224r1
EC-Parameters: (224 bit)
ASN1 OID: secp224r1
NIST CURVE: P-224
----------
secp256k1
EC-Parameters: (256 bit)
ASN1 OID: secp256k1
----------
secp384r1
EC-Parameters: (384 bit)
ASN1 OID: secp384r1
NIST CURVE: P-384
----------
secp521r1
EC-Parameters: (521 bit)
ASN1 OID: secp521r1
NIST CURVE: P-521
----------
sect113r1
EC-Parameters: (113 bit)
ASN1 OID: sect113r1
----------
sect113r2
EC-Parameters: (113 bit)
ASN1 OID: sect113r2
----------
sect131r1
EC-Parameters: (131 bit)
ASN1 OID: sect131r1
----------
sect131r2
EC-Parameters: (131 bit)
ASN1 OID: sect131r2
----------
sect163k1
EC-Parameters: (163 bit)
ASN1 OID: sect163k1
NIST CURVE: K-163
----------
sect163r1
EC-Parameters: (162 bit)
ASN1 OID: sect163r1
----------
sect163r2
EC-Parameters: (163 bit)
ASN1 OID: sect163r2
NIST CURVE: B-163
----------
sect193r1
EC-Parameters: (193 bit)
ASN1 OID: sect193r1
----------
sect193r2
EC-Parameters: (193 bit)
ASN1 OID: sect193r2
----------
sect233k1
EC-Parameters: (232 bit)
ASN1 OID: sect233k1
NIST CURVE: K-233
----------
sect233r1
EC-Parameters: (233 bit)
ASN1 OID: sect233r1
NIST CURVE: B-233
----------
sect239k1
EC-Parameters: (238 bit)
ASN1 OID: sect239k1
----------
sect283k1
EC-Parameters: (281 bit)
ASN1 OID: sect283k1
NIST CURVE: K-283
----------
sect283r1
EC-Parameters: (282 bit)
ASN1 OID: sect283r1
NIST CURVE: B-283
----------
sect409k1
EC-Parameters: (407 bit)
ASN1 OID: sect409k1
NIST CURVE: K-409
----------
sect409r1
EC-Parameters: (409 bit)
ASN1 OID: sect409r1
NIST CURVE: B-409
----------
sect571k1
EC-Parameters: (570 bit)
ASN1 OID: sect571k1
NIST CURVE: K-571
----------
sect571r1
EC-Parameters: (570 bit)
ASN1 OID: sect571r1
NIST CURVE: B-571
----------
SM2
EC-Parameters: (256 bit)
ASN1 OID: SM2
----------
wap-wsg-idm-ecid-wtls1
EC-Parameters: (112 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls1
----------
wap-wsg-idm-ecid-wtls10
EC-Parameters: (232 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls10
----------
wap-wsg-idm-ecid-wtls11
EC-Parameters: (233 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls11
----------
wap-wsg-idm-ecid-wtls12
EC-Parameters: (224 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls12
----------
wap-wsg-idm-ecid-wtls3
EC-Parameters: (163 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls3
----------
wap-wsg-idm-ecid-wtls4
EC-Parameters: (113 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls4
----------
wap-wsg-idm-ecid-wtls5
EC-Parameters: (163 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls5
----------
wap-wsg-idm-ecid-wtls6
EC-Parameters: (112 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls6
----------
wap-wsg-idm-ecid-wtls7
EC-Parameters: (161 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls7
----------
wap-wsg-idm-ecid-wtls8
EC-Parameters: (113 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls8
----------
wap-wsg-idm-ecid-wtls9
EC-Parameters: (161 bit)
ASN1 OID: wap-wsg-idm-ecid-wtls9
----------
```

#### X25519 Key
```
$ chmod 600 private_x25519.key
$ cat private_x25519.key
-----BEGIN ENCRYPTED PRIVATE KEY-----
MIG...
...
...kw=
-----END ENCRYPTED PRIVATE KEY-----
```

#### X448 Key
```
$ openssl genpkey -algorithm x448 -aes128 -out private_x448.key -pass pass:changeit
$ chmod 600 private_x448.key
$ cat private_x448.key
-----BEGIN ENCRYPTED PRIVATE KEY-----
MIG...
...
...Rwg
-----END ENCRYPTED PRIVATE KEY-----
```

#### ED25519 Key
```
$ openssl genpkey -algorithm ed25519 -aes128 -out private_ed25519.key -pass pass:changeit
$ chmod 600 private_ed25519.key
$ cat private_ed25519.key
-----BEGIN ENCRYPTED PRIVATE KEY-----
MIG...
...
...is=
-----END ENCRYPTED PRIVATE KEY-----
```

#### ED448 Key
```
$ openssl genpkey -algorithm ed448 -aes128 -out private_ed448.key -pass pass:changeit
$ chmod 600 private_ed448.key
$ cat private_ed448.key
-----BEGIN ENCRYPTED PRIVATE KEY-----
MIG...
...
...l/Y
---s--END ENCRYPTED PRIVATE KEY-----
```

### Private Key File Without Passphrase
```
$ openssl pkey -in private_ed448.key -passin pass:changeit -out private_ed448_noenc.key
cat private_ed448_noenc.key
-----BEGIN PRIVATE KEY-----
MEc...
...w==
-----END PRIVATE KEY-----
```

### Check Private Key Consistency
```
$ openssl pkey -check -noout -in private_ed448.key -passin pass:changeit
Key is valid
```

### Extract Public Key from Private Key
```
$ openssl pkey -pubout -in private_rsa.key -passin pass:changeit -out public_rsa.pem
$ chmod 644 public_rsa.pem
$ file public_rsa.pem
public_rsa.pem: ASCII text
$ cat public_rsa.pem
-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA19RDMSbWbVtC59BWtPHJ
emoyZgKIVEuJ8YlamWhhTnf87Tqq2YefJlQ1pLTx+drUnn3yU0M6a5duZqULdS9c
NqMB+6ybFZZ13qD2GU7yTqAqPiyhIAP5fmaoTNp8KBH0gTo/KeBYxbbiQqiO/kTk
mW/aCXf0oeSWbYX176qMz0eBRMJ4a6MXu/eJVgdFX7oHGBvR+8bhn+JLnlwCmPMp
8OrClHHq+loUXM+O8j0hwsoQDFLyL/t2bhkuCH91UFkQsUdDZIfxSgSX7tbUxKZb
LqxRBsTEl3nSKcIX6tJSKavOFkPdLG4ZLzS/D0uAqabAhVQZKysI/NuNg66Mwkm0
3wVgkDanM8CvBiXq5y8tQZTB1yVZoL2hcNc2w6bAhZjeVST2m3CgnhnMbJP5bELT
AWrPyZuHjcNeYVxXv34goOTgOsp+T3GAVn22DwStALdXQrycQRVkyiWR0T4NEn70
CedKrRRRcrxz2OwXxurQMkvQXgZl+QfmWj8VN56v8KLSNn5LfoPprP0TOCm5D+f8
Vs5Sh/pwfcpQ3khMPl8FnU4DKABXto1uX+4Vsh8phtEIs4oP2UpQ1krQql3Bmd5W
bndvZS8G5O2ne3e3kSwchSY8vAzeazQtA2D6dNhzgYokzX0wBS9reFJWLIXGbuul
v28F34GnmZ7MUmXHms3Vq/MCAwEAAQ==
-----END PUBLIC KEY-----
```

### Check Public Key  Consistency
```
$ openssl pkey -pubcheck -noout -in private_rsa.key -passin pass:changeit
Key is valid
```

#### RSA and RSA-PSS Keys
```
[source]
$ openssl rsa -noout -modulus -in private_rsa.key -passin pass:changeit | openssl dgst -md5
MD5(stdin)= 12b7a3255a94eba1cb6427622c303ead
#
$ openssl rsa -noout -pubin -modulus -in public_rsa.pem | openssl dgst -md5
MD5(stdin)= 12b7a3255a94eba1cb6427622c303ead
----
```

### Convert Public Key from PEM to DER Format
```
$ openssl pkey -pubin -in public_rsa.pem  -outform der -out public_rsa.der
$ chmod 644 public_rsa.der
$ file public_rsa.der
public_rsa.der: data
```

