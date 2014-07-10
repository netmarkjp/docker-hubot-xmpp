#!/bin/bash
# **template for hubot**

cd "`dirname $0`"

exec ./bin/hubot -a xmpp -n __HUBOT_NAME__ -l __HUBOT_ALIAS__
