#!/usr/bin/bash

msg="Success"

if [[ $(curl -o /dev/null -s -w "%{http_code}\n" $1) -ne 200 ]] ; then
  msg="Failure"
fi

echo $msg
