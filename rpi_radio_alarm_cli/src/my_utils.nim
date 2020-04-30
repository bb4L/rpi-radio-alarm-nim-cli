import std/[terminal]
import strutils
import alarm_types

proc printHeading*(heading:string, fg: ForegroundColor=fgBlue)=
  eraseScreen()
  styledEcho fg, heading

proc getInput*(heading:string, question:string="", headingFg:ForegroundColor=fgDefault, questionFg:ForegroundColor=fgDefault):string =
    styledEcho headingFg, heading, questionFg, "\n\n" & question
    let input = readLine(stdin)
    cursorUp()
    eraseLine()
    return input


proc prettyPrintAlarm*(alarm:Alarm)=
    let val = "Name:\t" & alarm.name & "\tHour:\t" & $alarm.hour & ":" & $alarm.min & "\tDays:\t" & $alarm.days
    if alarm.on:
        styledEcho val , "\tOn: ", fgGreen, $alarm.on
    else:
        styledEcho val, "\tOn: ", fgRed, $alarm.on
    echo ""

proc prettyPrintAlarms*(alarms:seq[Alarm])=
    for alarm in alarms:
        prettyPrintAlarm(alarm)

proc quitString*(input:string):bool =
    let input = input.multiReplace([(" ",""),("\t","")])
    result = input=="q"
