#!/bin/bash

tstmp = `date '+%Y-%m-%d_%H:%M'`
awk '{IGNORECASE=1}NF<13 !/sudo/ && /cron/{print} /var/log/syslog > ~/modul1/syslog_$tstmp.bak