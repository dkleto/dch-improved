dch-improved
============

A script that makes incrementing the debian changelog simpler.

This is a simple bash script designed to make incrementing the debian changelog
a little less tedious. It increments the debian changelog and calls dch, 
preventing dch from appending your distro name at the end of the version string.
It was written with the Catalyst AU version number convention in mind 
(Specifically for moodle sites). 

Usually, this will be: "(&lt;application version&gt;.&lt;datestamp&gt;-&lt;revision&gt;)"

The script will do the following:<br>
    - Check that there is a version string enclosed in parentheses<br>
    - If there is a number at the end of string, preceded by a hyphen:<br>
        - Look for an 8 digit datestamp in the string: <br>
            - If one is found, check it against the current date and update it <br>
            if necessary. If the datestamp matches or exceeds the current date,
            it will increment the revision number at the end of the string.<br>
            - If no datestamp is found, increment the revision number at the
            end of the string.<br>
    - If there is no revision number (number at the end preceded by a hyphen),
    just call dch -i, and call it a day.<br><br>

Use at your own risk. I threw this together as a quick hack. It works for me.
