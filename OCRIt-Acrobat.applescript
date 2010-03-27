property mytitle : "ocrIt-Acrobat"
-- Modified from a script created by Macworld http://www.macworld.com/article/60229/2007/10/nov07geekfactor.html

-- I am called when the user open the script with a double click
on run
	tell me
		activate
		display dialog "I am an AppleScript droplet." & return & return & "Please drop a bunch of PDF files onto my icon to batch OCR them." buttons {"OK"} default button 1 with title mytitle with icon note
	end tell
end run

-- I am called when the user drops Finder items onto the script icon
-- Timeout of 36000 seconds to allow for OCRing really big documents
on open droppeditems
	with timeout of 36000 seconds
		try
			repeat with droppeditem in droppeditems
				set the item_info to info for droppeditem
				tell application "Adobe Acrobat Professional"
					activate
					open droppeditem
				end tell
				tell application "System Events"
					
					tell application process "Acrobat"
						
						click the menu item "Recognize Text Using OCR..." of menu 1 of menu item "OCR Text Recognition" of the menu "Document" of menu bar 1
						try
							click radio button "All pages" of group 1 of group 2 of group 1 of window "Recognize Text"
						end try
						click button "OK" of window "Recognize Text"
						
					end tell
					
				end tell
				tell application "Adobe Acrobat Professional"
					save the front document with linearize
					close the front document
				end tell
			end repeat
			-- catching unexpected errors
		on error errmsg number errnum
			my dsperrmsg(errmsg, errnum)
		end try
	end timeout
end open

-- I am displaying error messages
on dsperrmsg(errmsg, errnum)
	tell me
		activate
		display dialog "Sorry, an error occured:" & return & return & errmsg & " (" & errnum & ")" buttons {"Never mind"} default button 1 with icon stop with title mytitle
	end tell
end dsperrmsg