#!/bin/bash
#===============================================================================
#
#          FILE:  testall.sh
# 
#         USAGE:  ./testall.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  xiehongbao (), xiehongbao@xunlei.com
#       COMPANY:  XunLei Networking Tech
#       VERSION:  1.0
#       CREATED:  11/07/2013 01:07:27 AM CST
#      REVISION:  ---
#===============================================================================

./lemplate.lua test.tpl test.lua
lua ./t.lua
