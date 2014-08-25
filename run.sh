#!/bin/bash
# **template for hubot**

cd "`dirname $0`"

exec ./bin/hubot ${HUBOT_ARGS:- -a xmpp -n mybotname -l mybotalias}
