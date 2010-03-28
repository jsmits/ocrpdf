set errmsg to "dummy error message" as string
set errnum to 1722 as number

my dsperrmsg(errmsg, errnum)

-- logging error messages
on dsperrmsg(errmsg, errnum)
    do shell script ("/usr/bin/logger -t localhost.ocrpdf '" & errmsg & " (" & errnum & ")'")
end dsperrmsg