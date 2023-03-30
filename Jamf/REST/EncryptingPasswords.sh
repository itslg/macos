#!/bin/sh
# Test Encryption
echo 'mysecretpassword' | openssl enc -base64 -e -aes-256-cbc -nosalt  -pass pass:garbageKey
# Test Decryption
echo 'O7LX4VmomxrBgNHS+R1FcoNneSrqWFY0oTn3ammEF7w=' | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:garbageKey

# Encrypt & Save Hash to File
echo 'mysecretpassword' | openssl enc -base64 -e -aes-256-cbc -nosalt  -pass pass:garbageKey  > .secret.lck

# Composer Deploy .LCK File onto Devices

# Running Encrypted Hash as Variable w/ Decryption
PASS=`cat .secret.lck | openssl enc -base64 -d -aes-256-cbc -nosalt -pass pass:garbageKey

# Permissions for the PW Hash
chmod 600 secret.lck





# enc -aes-256-cbc: The encoding type. We’re using the Advanced Encryption Standard 256-bit key cipher with cipher-block chaining.
# -md sha512: The message digest (hash) type. We’re using the SHA512 cryptographic algorithm.
# -a: This tells openssl to apply base-64 encoding after the encryption phase and before the decryption phase.
# -pbkdf2: Using Password-Based Key Derivation Function 2 (PBKDF2) makes it much more difficult for a brute force attack to succeed in guessing your password. PBKDF2 requires many computations to perform the encryption. An attacker would need to replicate all of those computations.
# -iter 100000: Sets the number of computations that PBKDF2 will use.
# -salt: Using a randomly applied salt value makes the encrypted output different every time, even if the plain text is the same.
# -pass pass:’pick.your.password’: The password we’ll need to use to decrypt the encrypted remote password. Substitute pick.your.password with a robust password of your choosing.


## This part confuses me...
echo 'mysecretpassword' | openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 -salt -pass pass:'super.strong.password'

echo U2FsdGVkX19iiiRNhEsG+wm/uKjtZJwnYOpjzPhyrDKYZH5lVZrpIgo1S0goZU46 | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:'super.strong.password'
