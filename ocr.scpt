on run
    set the_folder to "Macintosh HD:Users:jsmits:Documents:data:scans:te_verwerken:"
    set the_folder_list to list folder the_folder without invisibles
    -- TODO filter the_folder_list for *.pdf only
    set output_folder to "Macintosh HD:Users:jsmits:Documents:data:scans:verwerkt:"
    set destination_path to POSIX path of output_folder
    with timeout of 36000 seconds
        try
            repeat with x from 1 to count of the_folder_list
                set the_file to the_folder & item x of the_folder_list
                set file_path to POSIX path of the_file
                tell application "Adobe Acrobat Professional"
                    activate
                    open the_file
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
                -- copy and remove the processed PDF file to the output folder
                do shell script ("/usr/bin/ditto -rsrc " & file_path & " " & destination_path)
                do shell script ("/bin/rm " & file_path)
            end repeat
            quit application "Adobe Acrobat Professional"
        on error errmsg number errnum
            my dsperrmsg(errmsg, errnum)
        end try
    end timeout
end run

-- logging error messages
on dsperrmsg(errmsg, errnum)
    do shell script ("/usr/bin/logger -t localhost.ocrpdf '" & errmsg & " (" & errnum & ")'")
end dsperrmsg