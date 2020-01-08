#!/bin/bash

# Author: haw
# Error code:
#   1 - Usage error
#   2 - Command not exist

_SCRIPT=$(basename ${0})

# USAGE: bandit-ssh.sh LEVEL
if [[ "${#}" -ne 1 ]]; then
    echo "USAGE: ${_SCRIPT} LEVEL"
    exit 1
fi

# sshpass command 
which sshpass 1> /dev/null
if [[ "${?}" -ne 0 ]]; then
    echo "No such command: sshpass"
    exit 2
fi

_level=${1}
_user="bandit${_level}"

if [[ ${_level} -lt 10 ]]; then
    _level="0${_level}"
fi

_password_file="level${_level}.txt"

if [[ ! -f "./${_password_file}" ]]; then
    echo "Password file ${_password_file} not exist."
    exit 1
fi

echo "Select level: ${_level}"
echo "Password file: ${_password_file}"

read _passwd < ./${_password_file}

sshpass -p ${_passwd} ssh -p 2220 ${_user}@bandit.labs.overthewire.org
#ssh -p 2220 bandit11@bandit.labs.overthewire.org