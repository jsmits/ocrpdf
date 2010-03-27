#!/Users/jsmits/.virtualenvs/appscript/bin/python

from appscript import app, k, reference
import glob
import time
import subprocess

#folder = app(u'/System/Library/CoreServices/Finder.app').startup_disk. \
#    folders[u'Users'].folders[u'jsmits'].folders[u'Documents']. \
#    folders[u'data'].folders[u'scans'].folders[u'te verwerken']

#for fn in folder.items():
#    print fn

#to_process_dir = '/Users/jsmits/Documents/data/scans/te verwerken'
to_process_dir = '/Users/jsmits/Documents/data/scans/testing'

def test_opening():
    files = glob.glob('%s/*.pdf' % to_process_dir)
    if files:
        acrobat = app(u'Adobe Acrobat Professional')
        for fn in files: 
            print fn
            acrobat.open(fn)
            # acrobat.documents[1].close()
        # acrobat.quit()
        return acrobat

def test_ocr():
    files = glob.glob('%s/*.pdf' % to_process_dir)
    if files:
        acrobat = app(u'Adobe Acrobat Professional')
        for fn in files: 
            print fn
            acrobat.open(fn)
            se = app(u'System Events')
            se.processes["Acrobat"].click(se.processes["Acrobat"]. \
                menu_bars[1].menus['Document']. \
                menu_items['OCR Text Recognition'].menus[1]. \
                menu_items['Recognize Text Using OCR...'])
            # app(u'System Events').processes[u'Acrobat'].menu_bars[1].menus[u'Document'].menu_items[u'OCR Text Recognition'].menus[1].menu_items[u'Recognize Text Using OCR...'].click(timeout=120)
            try:
                se.processes[u'Acrobat'].windows[u'Recognize Text'].groups[1].groups[2].groups[1].radio_buttons[u'All pages'].click()
            except reference.CommandError:
                pass
            se.processes[u'Acrobat'].windows[u'Recognize Text'].buttons[u'OK'].click(timeout=120)
            #acrobat.documents[1].save(linearize=True)
            #acrobat.documents[1].close()
            #acrobat.documents[1].close()
        #acrobat.quit()
        return acrobat

def test_osa():
    files = glob.glob('%s/*.pdf' % to_process_dir)
    if files:
        cmd = "osascript ocr.scpt"
        subprocess.call(cmd, shell=True)

if __name__ == '__main__':
    acrobat = test_osa()
