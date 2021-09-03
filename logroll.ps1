############################################################################################## 
# PS1 script for transmitting previous day logs to Secondary log server
#
# Assumptions - file-yyyy-mm-dd.log is the file format...pretty standard, but up to you.
#
# change timestamps...if you want to make some test files...
# get-childitem .\log-2021-09-01.txt | % {$_.LastWriteTime = '09/01/2021 06:00:00'}
##############################################################################################

# First, define yesterdays date
$yesterday = (get-date).adddays(-1)

# Second, define the log file labeled for yesterday
$ylog = Get-ChildItem .\logs -Filter *$(get-date -date $yesterday -Format "yyyy-MM-dd")* | select name

# ...you might think we're done, but NOOOO! You have to further re-define this variable to knock off
# the 'Name' header attached.
$rlog = $ylog.Name

# Transmit $ylog to secondary log server. I'm using SCP because I loath anything that requires me 
# opening a session and feeding in crap (S/FTP, FTPS, FTP, TELNET, etc...)
C:\Users\User\Downloads\OpenSSH-Win64\scp.exe .\logs\$rlog user@secondlog.lcl:./path/to/logs

# Of course we want to automate this, so call the PS1 from your TaskScheduler and call it a day,
# so go do that before grabbing lunch. Enjoy!
