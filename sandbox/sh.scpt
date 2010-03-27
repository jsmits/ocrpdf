set the_item to "Macintosh HD:Users:jsmits:Documents:dev:repos:ocrpdf:sandbox:test.txt"
set destination to "Macintosh HD:Users:jsmits:Documents:dev:repos:ocrpdf:sandbox:output:"
set item_path to POSIX path of the_item
set destination_path to POSIX path of destination
do shell script ("/usr/bin/ditto -rsrc " & item_path & " " & destination_path)
do shell script ("rm " & item_path)