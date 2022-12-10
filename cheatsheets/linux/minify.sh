#!/bin/sh
# From https://stackoverflow.com/questions/9907200/how-to-minify-obfuscate-a-bash-script
Script=${1}
if [ ! -z "${Script}" ] && [ -f ${Script} ] ; then
        CurrenTime=$(date | sed -e 's~ ~_~g' -e 's~:~~g')
        cp ${Script} ${Script}_${CurrenTime}
        #### Remove all empty lines
        #### Remove lines that begin with spaces and a comment sign #
        #### Remove all comment lines (meaning, lines that begin with a "#")
        awk '
                (/.*/ || /#!/) && (!/^#$/) &&
                (!/^#[[:blank:]]/) && (!/^#[a-z]/) && 
                (!/^#[A-Z]/) && (!/^##/) &&
                (!/^\t#/) && (!/^[[:space:]]*$/) &&
                ( /^#.*!/ || !/^[[:space:]]*#/)
        ' ${Script} | sed 's_^[[:space:]]*__g' > ${Script}.tmp 2>/dev/null
        #' ${Script} > ${Script}.tmp 2>/dev/null (comment out the above line and uncomment this line if your HEREDOCS are affected)
        ExitCode=$?
        if [ ${ExitCode} -eq 0 ] && [ -s ${Script}.tmp ] ; then
                echo
                echo "SUCCESS: Your newly [ minified ] script can be found here [ ${Script}.tmp ]."
                echo "Review the script [ ${Script}.tmp ] and if happy with it, replace your original script with it!"
                echo "NOTE: Your original script [ ${Script} ] was backed up as [ ${Script}_${CurrenTime} ]!"
                echo
                exit 0
        else
                echo
                echo "FAILURE: Unable to [ minify ] the specified script [ ${Script} ]!!!"
                echo
                exit 2
        fi
else
        echo
        echo "USAGE: ${0}  <your-script>"
        echo
        exit 3
fi
