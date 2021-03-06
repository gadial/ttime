#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
import urllib
import zipfile
import tempfile
import codecs
import re
import ttime

from ttime.localize import _
from ttime import prefs


#####
# static constant
# TODO: do this the correct way
num_regexp = re.compile("[0-9][0-9\.,\/:-_]*", re.UNICODE)

def unicode_flip(string):
    return (unicode(string))[::-1]
   

# fix the hebrew
def bidi_flip(string):
    string=unicode(string)
    matches = num_regexp.finditer(string)
    for match in matches:
        string = string.replace(match.group(),unicode_flip(match.group()))
    return unicode_flip(string)

def repy_data():
    """Download raw REPY data from Technion, convert it to almost-unicode
    (numbers are reversed)"""
    REPY_URI = "http://ug.technion.ac.il/rep/REPFILE.zip"
    if prefs.options.usecache:
        t = open("REPFILE.zip")
    else:
        try:
            t = tempfile.TemporaryFile()
            t.write(urllib.urlopen(REPY_URI).read())
        except:
            ttime.warning(_("Network download of REPFILE.zip failed, " \
                    "trying local"))
            try:
                t = open("REPFILE.zip")
            except: raise _("REP file download has failed")
    try:
        z = zipfile.ZipFile(t)
    except:
        raise _("REP file is not a valid zip file!")
    repy_data = '\n'.join([ bidi_flip(unicode(x).rstrip('\r')) for x in
        unicode(z.read('REPY'), 'cp862').split('\n') ])
    z.close
    t.close
    return repy_data

# FIXME - Remove this:
if __name__ == '__main__':
    f = codecs.open('repy_data_example','w',encoding='utf-8')
    d = repy_data()
    f.write(d)
    f.close()
