# GnuPG
![GnuPG Logo](logo-gnupg-light-purple-bg.png)  
Logo: <https://www.gnupg.org/share/logo-gnupg-light-purple-bg.png>

## Introduction
This document contains a number of samples to show,
how to use the GnuPG (GNU Privacy Guard) software
on a Linux system.

The samples are executed on a Debian 12.4 system with
the GNU Privacy Guard 2.2.40 software.
 
### GnuPG Site and Documentation
- [GnuPG Site](https://www.gnupg.org/)
- Manual [Using the GNU Privacy Guard (HTML)](https://www.gnupg.org/documentation/manuals/gnupg/)
- Manual [Using the GNU Privacy Guard (PDF)](https://www.gnupg.org/documentation/manuals/gnupg.pdf)

### Installation
```
$ sudo apt install gpg

$ dpkg --list gpg
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version      Architecture Description
+++-==============-============-============-============================================>
ii  gpg            2.2.40-1.1   amd64        GNU Privacy Guard -- minimalist public key o>
```

### User Specific Initialization
#### Create the GnuPG Files
Use the following command to create the directory 
_~/.gnupg_ and the needed GnuPG files

```
$ gpg --list-keys
gpg: keybox '/home/user/.gnupg/pubring.kbx' created
gpg: /home/user/.gnupg/trustdb.gpg: trustdb created

$ ls -Al ~/.gnupg
total 8
-rw------- 1 user users   32 Dec 21 16:04 pubring.kbx
-rw------- 1 user users 1200 Dec 21 16:04 trustdb.gpg
```

#### Set the Default Keyserver
I use the keyserver [keys.openpgp.org](https://keys.openpgp.org/) as the
default keyserver.

Add the following line to the file _~/.gnupg/gpg.conf_
```
keyserver hkps://keys.openpgp.org
```

If the file doesn't exist yet, use the following
commands
```
$ touch ~/.gnupg/gpg.conf
$ chmod 600 ~/.gnupg/gpg.conf
$ echo "keyserver hkps://keys.openpgp.org" >>~/.gnupg/gpg.conf
```

#### GnuPG: Supported Algorithms
```
$ gpg --version
gpg (GnuPG) 2.2.40
libgcrypt 1.10.1
Copyright (C) 2022 g10 Code GmbH
License GNU GPL-3.0-or-later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: /home/user/.gnupg
Supported algorithms:
Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed, ZIP, ZLIB, BZIP2
```

## Key Handling
### Generate a Keypair and Store it in the Keyring
```
$ gpg --full-generate-key
```

__Sample__
```
$ gpg --full-generate-key
gpg (GnuPG) 2.2.40; Copyright (C) 2022 g10 Code GmbH
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
  (14) Existing key from card
Your selection? 1
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096
Requested keysize is 4096 bits
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 2y

GnuPG needs to construct a user ID to identify your key.

Real name: Zaphod Beeblebrox
Email address: Zaphod.Beeblebrox@universe.gov
Comment:
You selected this USER-ID:
    "Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>"

Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O

ZWISCHENSCHRITT: PASSWORT EINGEBEN 

We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.
gpg: directory '/home/user/.gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as '/home/user/.gnupg/openpgp-revocs.d/2875BB940BD74DE62D4CA3F274E7BD8C534542DF.rev'
public and secret key created and signed.

pub   rsa4096 2023-12-22 [SC] [expires: 2025-12-21]
      2875BB940BD74DE62D4CA3F274E7BD8C534542DF
uid                      Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>
sub   rsa4096 2023-12-22 [E] [expires: 2025-12-21]
```

__Keydata__
```
Mailaddress : Zaphod.Beeblebrox@universe.gov
              Attention: several keys may be
              attached to one mail address!
Key Id      : 74E7BD8C534542DF
Fingerprint : 2875BB940BD74DE62D4CA3F274E7BD8C534542DF
```

### Print Keydata
```
$ gpg --list-keys <mailaddress|keyid|fingerprint>
```

__Sample__
```
$ gpg --list-keys
      List all keys in the keyring
  or
$ gpg --list-keys Zaphod.Beeblebrox@universe.gov
  or
$ gpg --list-keys 74E7BD8C534542DF
  or
$ gpg --list-keys 2875BB940BD74DE62D4CA3F274E7BD8C534542DF

pub   rsa4096 2023-12-22 [SC] [expires: 2025-12-21]
      2875BB940BD74DE62D4CA3F274E7BD8C534542DF
uid           [ultimate] Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>
sub   rsa4096 2023-12-22 [E] [expires: 2025-12-21]
```

### Print Key Fingerprint
```
$ gpg --fingerprint <mailaddress|keyid|fingerprint>
```

__Sample__
```
$ gpg --fingerprint
      Print all key fingerprints in the keyring
  or
$ gpg --fingerprint Zaphod.Beeblebrox@universe.gov
  or
$ gpg --fingerprint 74E7BD8C534542DF
  or
$ gpg --fingerprint 2875BB940BD74DE62D4CA3F274E7BD8C534542DF

pub   rsa4096 2023-12-22 [SC] [expires: 2025-12-21]
      2875 BB94 0BD7 4DE6 2D4C  A3F2 74E7 BD8C 5345 42DF
uid           [ultimate] Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>
sub   rsa4096 2023-12-22 [E] [expires: 2025-12-21]
```

### Print Public Key
```
$ gpg --armor --export <mailaddress|keyid|fingerprint>
```

__Sample__
```
$ gpg --armor --export Zaphod.Beeblebrox@universe.gov
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
CzmFHTlQIAULGAAc+MltNIeT+WeDvImSoys=
=bBQE
-----END PGP PUBLIC KEY BLOCK-----
```

### Store Public Key in File
```
$ gpg --output public.asc --armor --export <mailaddress|keyid|fingerprint>
```

__Sample__
```
$ gpg --output pub_Zaphod.Beeblebrox_at_universe.gov_20251221.asc --armor --export Zaphod.Beeblebrox@universe.gov
```

### Store Secret Key in File
```
$ gpg --output secret_key.asc --armor --export-secret-keys <mailaddress|keyid|fingerprint>
```

__Sample__
```
$ gpg --output sec_Zaphod.Beeblebrox_at_universe.gov_20251221.asc --armor --export-secret-keys Zaphod.Beeblebrox@universe.gov
```

### Create a Revocation Certificate File
```
$ gpg --output revoke.asc --generate-revocation <mailaddress|keyid|fingerprint>
```

__Sample__
```
$ gpg --output rev_Zaphod.Beeblebrox_at_universe.gov_20251221.asc --generate-revocation Zaphod.Beeblebrox@universe.gov

sec  rsa4096/74E7BD8C534542DF 2023-12-22 Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>

Create a revocation certificate for this key? (y/N) y
Please select the reason for the revocation:
  0 = No reason specified
  1 = Key has been compromised
  2 = Key is superseded
  3 = Key is no longer used
  Q = Cancel
(Probably you want to select 1 here)
Your decision? 0
Your decision? 0
Enter an optional description; end it with an empty line:
>
Reason for revocation: No reason specified
(No description given)
Is this okay? (y/N) y
ASCII armored output forced.
Revocation certificate created.

Please move it to a medium which you can hide away; if Mallory gets
access to this certificate he can use it to make your key unusable.
It is smart to print this certificate and store it away, just in case
your media become unreadable.  But have some caution:  The print system of
your machine might store the data and make it available to others!
```

#### Revoke a Key
Import the revocation certificate into the keyring. 
```
$ gpg --import revoke.asc
```

Send the revoked key data to the keyring.
```
$ gpg --send-keys <keyid|fingerprint>
```

### Delete a Secret Key from Keyring
```
$ gpg --delete-secret-keys <mailaddress|keyid|fingerprint>
```

__Sample__
```
$ gpg --delete-secret-keys Zaphod.Beeblebrox@universe.gov
gpg (GnuPG) 2.2.40; Copyright (C) 2022 g10 Code GmbH
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.


sec  rsa4096/74E7BD8C534542DF 2023-12-22 Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>

Delete this key from the keyring? (y/N) y
This is a secret key! - really delete? (y/N) y
```

### Delete a Public Key from Keyring
```
$ gpg --delete-keys <mailaddress|keyid|fingerprint>
```

__Sample__
```
$ gpg --delete-keys Zaphod.Beeblebrox@universe.gov
gpg (GnuPG) 2.2.40; Copyright (C) 2022 g10 Code GmbH
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.


pub  rsa4096/74E7BD8C534542DF 2023-12-22 Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>

Delete this key from the keyring? (y/N) y
```

### Print Key Data from a Key File
```
$ gpg --show-keys <keyfile>
```

__Sample__
```
$ gpg --show-keys pub_Zaphod.Beeblebrox_at_universe.gov_20251221.asc
pub   rsa4096 2023-12-22 [SC] [expires: 2025-12-21]
      2875BB940BD74DE62D4CA3F274E7BD8C534542DF
uid                      Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>
sub   rsa4096 2023-12-22 [E] [expires: 2025-12-21]

$ gpg --show-keys sec_Zaphod.Beeblebrox_at_universe.gov_20251221.asc
sec#  rsa4096 2023-12-22 [SC] [expires: 2025-12-21]
      2875BB940BD74DE62D4CA3F274E7BD8C534542DF
uid                      Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>
ssb#  rsa4096 2023-12-22 [E] [expires: 2025-12-21]

$ gpg --show-keys rev_Zaphod.Beeblebrox_at_universe.gov_20251221.asc
rvs?         74E7BD8C534542DF 2023-12-22  [User ID not found]
      reason for revocation: No reason specified
```

### Import Public/Secret Keyfile into Keyring
```
$ gpg --import <pub/sec keyfile>
```

__Sample__
```
$ gpg --import sec_Zaphod.Beeblebrox_at_universe.gov_20251221.asc
gpg: key 74E7BD8C534542DF: public key "Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>" imported
gpg: key 74E7BD8C534542DF: secret key imported
gpg: Total number processed: 1
gpg:               imported: 1
gpg:       secret keys read: 1
gpg:   secret keys imported: 1
```

### Import Public Key from Keyring into the Keyserver
```
$ gpg --export <mailaddress|keyid|fingerprint> | curl -T - https://keys.openpgp.org
```

__Sample__
```
$ gpg --export Zaphod.Beeblebrox@universe.gov | curl -T - https://keys.openpgp.org
Key successfully uploaded. Proceed with verification here:
https://keys.openpgp.org/upload/31T...pLZ
```

Call the given URL and a mail will be send to the
mail address given in the key data. After calling the
URL, given in the mail, the key will be stored in the
Keyserver.

### Search Key on the Keyserver
```
$ gpg --search-keys <mailaddress|keyid|fingerprint>
```

__Sample__
```
$ gpg --search-keys Zaphod.Beeblebrox@universe.gov
gpg: data source: https://keys.openpgp.org:443
(1)     Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>
          4096 bit RSA key 74E7BD8C534542DF, created: 2023-12-22
Keys 1-1 of 1 for "Zaphod.Beeblebrox@universe.gov".  Enter number(s), N)ext, or Q)uit > Q
```

### Import Public Key from Keyserver into Keyring
```
$ gpg --auto-key-locate keyserver --locate-keys  <mailaddress|keyid|fingerprint>
```

__Sample__
```
$ gpg --auto-key-locate keyserver --locate-keys Zaphod.Beeblebrox@universe.gov
gpg: key 74E7BD8C534542DF: public key "Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>" imported
gpg: Total number processed: 1
gpg:               imported: 1
pub   rsa4096 2023-12-19 [SC] [expires: 2025-12-21]
      2875BB940BD74DE62D4CA3F274E7BD8C534542DF
uid           [ unknown] Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>
sub   rsa4096 2023-12-19 [E] [expires: 2025-12-21]
```


### Refresh Keyring Data from the Keyserver
```
$ gpg --refresh-keys
```

__Sample__
```
$ gpg --refresh-keys
gpg: refreshing 2 keys from hkps://keys.openpgp.org
gpg: key 74E7BD8C534542DF: "Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1
```

## Sign a File
Sample file to sign:

```
$ cat text.txt
Don't Panic!
```

The SHA512 algorithm is used by default to hash the
file data.

The following hash algorithms can be used

- SHA1
- RIPEMD160
- SHA256
- SHA384
- SHA512
- SHA224

You can name the desired algorithm with the option

```
--digest-algo <algorithm name>
```

### Clear Text Signature

#### Sign a File
```
$ gpg --output text.txt.sig.asc --clearsign text.txt
  or
$ gpg --output text.txt.sig.asc --local-user <mailaddress|keyid|fingerprint> --clearsign text.txt
```

__Sample__
```
$ gpg --output text.txt.sig.asc --clearsign text.txt
  or
$ gpg --output text.txt.sig.asc --local-user Zaphod.Beeblebrox@universe.gov --clearsign text.txt

$ cat text.txt.sig.asc
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Don't Panic!
-----BEGIN PGP SIGNATURE-----

iQJTBAEBCgA9FiEEKHW7lAvXTeYtTKPydOe9jFNFQt8FAmWFb8MfHHphcGhvZC5i
ZWVibGVicm94QHVuaXZlcnNlLmdvdgAKCRB0572MU0VC368WEACnSnqS6DNHDdrn
KBHzj96wHKds2OIZAADL8a0V6ylRI/w/sW722mYqHQnWjwGGaIOLAGP+Eitdsv8t
Y/Y9qutXLvVYCtNeXdem/BPAUQoUxfJ4znOyBKHzMxF+IRIiod2Nz5jgrt++2/+9
2cEteDuzu7KGqgbx4JbqQWLU4j9vtXaCMJp9JG0pNQn2rjP6aPK922K9Mp4HtKts
BLol4zWuMmpZfHgXXrrle0ekG/GRAFJuH0KXaQhTLIAIR9dKU0+QwZRo7OjY6K1l
l/zc0dJAqpiTrNMT/nydA/bPVivlp/8amftG1SwonyatOGbQXhAxdEeBAwh2KCa/
rh+5zldKKurEx+AFLAHxVhs2A4vwTUOXZDMKOXEfw7Sbl7R8aCi8iGPDncH1Kcvc
tToPgDEcKFS/pxxj1SndMZUU+cEi0mXTjHnP+Zu+fxEWXjRxUG/KExO43T6A7KP3
JODPk5dGxtvMrb6jkXjop30ierD6zfqMTAUUD97YPoc3FFu8al9nfn0pO1dhedt5
srVW/sOmpDP+y1Iy31T7xoHaLvQ01Wvmn3xz21QKdrUbBphj2EcProyL6qnTVGnh
Y07/SBG1ZiWWd24HA6O4Uf1r4RJisdbwu6owE1vLdf9GVrmf+6VnhmjU/M5jLGrI
Hxcz6xwBvqxrqeJPaAKZWccZgLxlZA==
=vqKK
-----END PGP SIGNATURE-----
```

#### Verify Signature
```
$ gpg --verify text.txt.sig.asc
```

__Sample__
```
$ gpg --verify text.txt.sig.asc
gpg: Signature made Fri 22 Dec 2023 12:15:15 PM CET
gpg:                using RSA key 2875BB940BD74DE62D4CA3F274E7BD8C534542DF
gpg:                issuer "zaphod.beeblebrox@universe.gov"
gpg: Good signature from "Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>" [ultimate]
```

### Signature
#### Sign a File
```
$ gpg --output text.txt.sig --sign text.txt
 or 
$ gpg --output text.txt.sig --local-user <mailaddress|keyid|fingerprint> --sign text.txt
```

__Sample__
```
$ gpg --output text.txt.sig --local-user Zaphod.Beeblebrox@universe.gov --sign text.txt

$ file text.txt.sig
text.txt.sig: data
```

#### Verify Signature
```
$ gpg  --verify text.txt.sig
```

__Sample__
```
$ gpg  --verify text.txt.sig
gpg: Signature made Fri 22 Dec 2023 12:17:56 PM CET
gpg:                using RSA key 2875BB940BD74DE62D4CA3F274E7BD8C534542DF
gpg:                issuer "zaphod.beeblebrox@universe.gov"
gpg: Good signature from "Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>" [ultimate]
gpg: WARNING: not a detached signature; file 'text.txt' was NOT verified!
```

#### Extract Data from Signature File
```
$ gpg --output text2.txt --decrypt text.txt.sig
```

__Sample__
```
$ gpg --output text2.txt --decrypt text.txt.sig
gpg: Signature made Fri 22 Dec 2023 12:17:56 PM CET
gpg:                using RSA key 2875BB940BD74DE62D4CA3F274E7BD8C534542DF
gpg:                issuer "zaphod.beeblebrox@universe.gov"
gpg: Good signature from "Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>" [ultimate]

$ cat text2.txt
Don't Panic!

$ cmp text.txt text2.txt
$ echo $?
0
```

### Detached Signature
##### Sign a File
```
$ gpg --output text.txt.detached.sig --detach-sig text.txt
  or 
$ gpg --output text.txt.detached.sig --local-user
<mailaddress|keyid|fingerprint> --detach-sig text.txt
```

__Sample__
```
$ gpg --output text.txt.detached.sig --detach-sig text.txt
  or 
$ gpg --output text.txt.detached.sig --local-user Zaphod.Beeblebrox@universe.gov --detach-sig text.txt

$ file text.txt.detached.sig
text.txt.detached.sig: data
```

#### Verify Signature
```
$ gpg --verify text.txt.detached.sig text.txt
```

__Sample__
```
$ gpg --verify text.txt.detached.sig text.txt
gpg: Signature made Fri 22 Dec 2023 12:21:18 PM CET
gpg:                using RSA key 2875BB940BD74DE62D4CA3F274E7BD8C534542DF
gpg: Good signature from "Zaphod Beeblebrox <Zaphod.Beeblebrox@universe.gov>" [ultimate]
```

## Encrypt/Decrypt
Sample file to encrypt:

```
$ cat text.txt
Don't Panic!
```

### File Encryption
```
$ gpg --output text.txt.gpg --encrypt --recipient <mailaddress_rec|keyid_rec|fingerprint_rec> text.txt
  or
$ gpg --output text.txt.gpg --local-user <mailaddress|keyid|fingerprint> --encrypt --recipient <mailaddress_rec|keyid_rec|fingerprint_rec> text.txt
```

__Sample__
```
$ gpg --output text.txt.gpg --local-user Zaphod.Beeblebrox@universe.gov --encrypt --recipient Ford.Prefect@universe.gov text.txt
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   2  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 2u
gpg: next trustdb check due at 2025-12-21

$ file text.txt.gpg
text.txt.gpg: PGP RSA encrypted session key - keyid: 4DF20652 175C57AD RSA (Encrypt or Sign) 4096b .
```

### File Decryption
```
$ gpg --output text2.txt --decrypt text.txt.gpg
```

__Sample__
```
$ gpg --output text2.txt --decrypt text.txt.gpg
gpg: encrypted with 4096-bit RSA key, ID 4DF20652175C57AD, created 2023-12-22
      "Ford Prefect <Ford.Prefect@universe.gov>"

$ cat text2.txt
Don't Panic!

$ cmp text.txt text2.txt
$ echo $?
0
```

## Symmetric Enrypt/Decrypt
### File Encryption
```
$ gpg --output text.txt.sym.gpg --symmetric text.txt
```

__Sample__
```
$ gpg --output text.txt.sym.gpg --symmetric text.txt
$ file text.txt.sym.gpg
text.txt.sym.gpg: GPG symmetrically encrypted data (AES256 cipher)
```

The AES256 algorithm is used by default to encrypt
the file data.

The following encryption algorithms can be used

- IDEA
- 3DES
- CAST5
- BLOWFISH
- AES
- AES192
- AES256
- TWOFISH
- CAMELLIA128
- CAMELLIA192
- CAMELLIA256

You can name the desired algorithm with the option

```
--cipher-algo <algorithm name>
```

### File Decryption
```
$ gpg --output text2.txt --decrypt text.txt.sym.gpg
```

__Sample__
```
$ gpg --output text2.txt --decrypt text.txt.sym.gpg
gpg: AES256.CFB encrypted data
gpg: encrypted with 1 passphrase

$ cat text2.txt
Don't Panic!

$ cmp text.txt text2.txt
$ echo $?
0
```

## Available GnuPG Options
```
$ gpg --dump-options
--sign
--clear-sign
--clearsign
--detach-sign
--encrypt
--encrypt-files
--symmetric
--store
--decrypt
--decrypt-files
--verify
--verify-files
--list-keys
--list-public-keys
--list-signatures
--list-sigs
--check-signatures
--check-sigs
--fingerprint
--list-secret-keys
--generate-key
--gen-key
--quick-generate-key
--quick-gen-key
--quick-add-uid
--quick-adduid
--quick-add-key
--quick-addkey
--quick-revoke-uid
--quick-revuid
--quick-set-expire
--quick-set-primary-uid
--full-generate-key
--full-gen-key
--generate-revocation
--gen-revoke
--delete-keys
--delete-secret-keys
--quick-sign-key
--quick-lsign-key
--quick-revoke-sig
--sign-key
--lsign-key
--edit-key
--key-edit
--change-passphrase
--passwd
--generate-designated-revocation
--desig-revoke
--export
--send-keys
--receive-keys
--recv-keys
--search-keys
--refresh-keys
--locate-keys
--locate-external-keys
--fetch-keys
--show-keys
--export-secret-keys
--export-secret-subkeys
--export-ssh-key
--import
--fast-import
--card-status
--edit-card
--card-edit
--change-pin
--list-config
--list-gcrypt-config
--gpgconf-list
--gpgconf-test
--list-packets
--export-ownertrust
--import-ownertrust
--update-trustdb
--check-trustdb
--fix-trustdb
--list-trustdb
--dearmor
--dearmour
--enarmor
--enarmour
--print-md
--print-mds
--gen-prime
--gen-random
--server
--tofu-policy
--delete-secret-and-public-keys
--rebuild-keydb-caches
--list-key
--list-sig
--check-sig
--show-key
--Monitor
--verbose
--no-verbose
--quiet
--no-tty
--no-greeting
--debug
--debug-level
--debug-all
--debug-iolbf
--display-charset
--charset
--options
--no-options
--logger-fd
--log-file
--logger-file
--debug-quick-random
--Configuration
--homedir
--faked-system-time
--default-key
--encrypt-to
--no-encrypt-to
--hidden-encrypt-to
--encrypt-to-default-key
--default-recipient
--default-recipient-self
--no-default-recipient
--group
--ungroup
--no-groups
--compliance
--gnupg
--no-pgp2
--no-pgp6
--no-pgp7
--no-pgp8
--rfc2440
--rfc4880
--rfc4880bis
--openpgp
--pgp6
--pgp7
--pgp8
--default-new-key-algo
--min-rsa-length
--always-trust
--trust-model
--photo-viewer
--known-notation
--agent-program
--dirmngr-program
--exit-on-status-write-error
--limit-card-insert-tries
--enable-progress-filter
--temp-directory
--exec-path
--expert
--no-expert
--no-secmem-warning
--require-secmem
--no-require-secmem
--no-permission-warning
--dry-run
--interactive
--default-sig-expire
--ask-sig-expire
--no-ask-sig-expire
--default-cert-expire
--ask-cert-expire
--no-ask-cert-expire
--default-cert-level
--min-cert-level
--ask-cert-level
--no-ask-cert-level
--only-sign-text-ids
--enable-large-rsa
--disable-large-rsa
--enable-dsa2
--disable-dsa2
--personal-cipher-preferences
--personal-digest-preferences
--personal-compress-preferences
--default-preference-list
--default-keyserver-url
--no-expensive-trust-checks
--allow-non-selfsigned-uid
--no-allow-non-selfsigned-uid
--allow-freeform-uid
--no-allow-freeform-uid
--preserve-permissions
--default-cert-check-level
--tofu-default-policy
--lock-once
--lock-multiple
--lock-never
--compress-algo
--compression-algo
--bzip2-decompress-lowmem
--completes-needed
--marginals-needed
--max-cert-depth
--trustdb-name
--auto-check-trustdb
--no-auto-check-trustdb
--force-ownertrust
--Input
--multifile
--input-size-hint
--utf8-strings
--no-utf8-strings
--set-filesize
--no-literal
--set-notation
--sig-notation
--cert-notation
--set-policy-url
--sig-policy-url
--cert-policy-url
--sig-keyserver-url
--Output
--armor
--armour
--no-armor
--no-armour
--output
--max-output
--comment
--default-comment
--no-comments
--emit-version
--no-emit-version
--no-version
--not-dash-escaped
--escape-from-lines
--no-escape-from-lines
--mimemode
--textmode
--no-textmode
--set-filename
--for-your-eyes-only
--no-for-your-eyes-only
--show-notation
--no-show-notation
--show-session-key
--use-embedded-filename
--no-use-embedded-filename
--unwrap
--mangle-dos-filenames
--no-mangle-dos-filenames
--no-symkey-cache
--skip-verify
--list-only
--compress-level
--bzip2-compress-level
--disable-signer-uid
--ImportExport
--auto-key-locate
--no-auto-key-locate
--auto-key-import
--no-auto-key-import
--auto-key-retrieve
--no-auto-key-retrieve
--include-key-block
--no-include-key-block
--disable-dirmngr
--keyserver
--keyserver-options
--key-origin
--import-options
--import-filter
--export-options
--export-filter
--merge-only
--allow-secret-key-import
--Keylist
--list-options
--show-photos
--no-show-photos
--show-policy-url
--no-show-policy-url
--with-colons
--with-tofu-info
--with-key-data
--with-sig-list
--with-sig-check
--with-fingerprint
--with-subkey-fingerprint
--with-subkey-fingerprints
--with-icao-spelling
--with-keygrip
--with-secret
--with-wkd-hash
--with-key-origin
--fast-list-mode
--fixed-list-mode
--legacy-list-mode
--print-pka-records
--print-dane-records
--keyid-format
--show-keyring
--recipient
--hidden-recipient
--recipient-file
--hidden-recipient-file
--remote-user
--throw-keyids
--no-throw-keyids
--local-user
--trusted-key
--sender
--try-secret-key
--try-all-secrets
--no-default-keyring
--no-keyring
--keyring
--primary-keyring
--secret-keyring
--skip-hidden-recipients
--no-skip-hidden-recipients
--override-session-key
--override-session-key-fd
--Security
--s2k-mode
--s2k-digest-algo
--s2k-cipher-algo
--s2k-count
--require-backsigs
--require-cross-certification
--no-require-backsigs
--no-require-cross-certification
--verify-options
--enable-special-filenames
--no-random-seed-file
--no-sig-cache
--ignore-time-conflict
--ignore-valid-from
--ignore-crc-error
--ignore-mdc-error
--disable-cipher-algo
--disable-pubkey-algo
--cipher-algo
--digest-algo
--cert-digest-algo
--override-compliance-check
--allow-weak-key-signatures
--allow-weak-digest-algos
--weak-digest
--allow-multisig-verification
--allow-multiple-messages
--no-allow-multiple-messages
--batch
--no-batch
--yes
--no
--status-fd
--status-file
--attribute-fd
--attribute-file
--command-fd
--command-file
--passphrase
--passphrase-fd
--passphrase-file
--passphrase-repeat
--pinentry-mode
--force-sign-key
--request-origin
--display
--ttyname
--ttytype
--lc-ctype
--lc-messages
--xauthority
--no-autostart
--forbid-gen-key
--require-compliance
--use-only-openpgp-card
--rfc2440-text
--no-rfc2440-text
--personal-cipher-prefs
--personal-digest-prefs
--personal-compress-prefs
--sign-with
--user
--use-agent
--no-use-agent
--gpg-agent-info
--reader-port
--ctapi-driver
--pcsc-driver
--disable-ccid
--honor-http-proxy
--tofu-db-format
--sk-comments
--no-sk-comments
--compress-keys
--compress-sigs
--force-v3-sigs
--no-force-v3-sigs
--force-v4-certs
--no-force-v4-certs
--no-mdc-warning
--force-mdc
--no-force-mdc
--disable-mdc
--no-disable-mdc
--help
--version
--warranty
--dump-option-table
--dump-options
```
