############################################################################################## 
# PS1 script for transmitting previous day logs to Secondary log server
#
# Assumptions - file-yyyy-mm-dd.log is the file format...change as you need
#             - transmission via something like Win32_OpenSSH
#
# change timestamps...if you want to make some test files...
# get-childitem .\log-2021-09-01.txt | % {$_.LastWriteTime = '09/01/2021 06:00:00'}
#
# Win32_OpenSSH: https://github.com/PowerShell/Win32-OpenSSH/releases/tag/V8.6.0.0p1-Beta
##############################################################################################
# Zero, define your stuff
$logpath = "C:\Users\User\Downloads\OpenSSH-Win64\logs"
$yesterday = (get-date).adddays(-1)
$ylog = Get-ChildItem .\logs -Filter *$(get-date -date $yesterday -Format "yyyy-MM-dd")* | select name

# ...you might think we're done, but NOOOO! You have to further re-define this variable to knock off
# the 'Name' header attached.
$ylog = $ylog.Name

# Transmit via SCP...because I loath anything that requires opening a session...
C:\Users\User\Downloads\OpenSSH-Win64\scp.exe .\logs\$rlog user@secondlog.lcl:./path/to/logs

# Of course we want to automate this, so call the PS1 from your TaskScheduler and call it a day,
# so go do that before grabbing lunch. Enjoy!
