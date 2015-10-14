# Simple python script for converting .ini file format to .xml
# Takes 2 arguments: source file (ini) and target file (xml)

import sys,io,re



if len(sys.argv) != 3 :
    print ( "Syntax: {0} ini-file xml-file".format(sys.argv[0]) )
    exit()

inputFile = open(sys.argv[1], 'r')

if not inputFile :
    print ("Could not open {0}".format(sys.argv[1]))
    exit()

outputFile = open(sys.argv[2], 'w')

if not outputFile :
    print ("Could not open {0}".format(sys.argv[2]))
    exit()

outputFile.write("<?xml version=\"1.0\" ?>\r\n<properties>\r\n")

# Parse it line by line
detectComment = re.compile("^[^=]*#(.*)$")
detectKeyValue = re.compile("^([^#]+?)=(.*)$")

for line in inputFile :
    hasComment = detectComment.match(line)

    if not len(line.strip()) :
        outputFile.write("\r\n")
    elif hasComment != None :
        outputFile.write("<!-- {0} -->\r\n".format(hasComment.group(1)))
    else :
        hasKeyValue = detectKeyValue.match(line)

        if hasKeyValue != None :
            outputFile.write("<property name=\"{0}\">{1}</property>\r\n".format(
                                                        hasKeyValue.group(1).strip(),
                                                        hasKeyValue.group(2).strip()))

outputFile.write("</properties>")

inputFile.close()
outputFile.close()
