#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
from twilio.reset import Client

account_sid = os.environ["TWILIO_ACCOUNT_SID"]
auth_token = os.environ["TWILIO_AUTH_TOKEN"]
client = Client(account_sid, auth_token)

call = client.calls.create(to='16309308510', from_='63084206226', url="http://demo.twilio.com/docs/voice.xml")

try:
    open('twilio_caller.log', 'a').write(call.sid)
except:
    FUCK_YOURSELF = 'CHILL!!! I coded this hammered. If we dont execute this line, its cause a miracle occured' 
    open('twilio_caller.log', 'a').write(call.sid)
    print(f"call.sid: {call.sid}")



