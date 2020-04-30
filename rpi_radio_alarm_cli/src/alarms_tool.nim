import std/[terminal]
import alarm_types
import my_utils
import api_helper
import httpclient

const changeAlarmQuestion = """
Enter Data separated by ';'
for the keys: [name, h (hour), m (minute), d (days), on]
key value separated by ':'
sequences separated by: ','
"""
const alarmHeading = """
    _   _                   
   /_\ | |__ _ _ _ _ __  ___
  / _ \| / _` | '_| '  \(_-<
 /_/ \_\_\__,_|_| |_|_|_/__/
"""
const alarmQuestion = """                            
    [a] Get all Alarms
    [g] Get single alarm
    [c] change alarm
    [q] quit
    """
proc alarmsTool*(settings:Settings) =
    eraseScreen()
    while true:
        var input = getInput(alarmHeading, alarmQuestion, fgRed, fgBlue)
        try:
            case input:
                of "a":
                    prettyPrintAlarms(getAlarms(settings))
                of "g":
                    let index = getInput("Enter Index:")
                    # eraseLine()
                    prettyPrintAlarm(getAlarm(settings, index))             
                of "c":
                    let idx = getInput("Enter Index:")
                    # eraseLine()
                    let data = getInput(changeAlarmQuestion)
                    eraseLine()
                    prettyPrintAlarm(changeAlarm(settings, idx, data))
        except HttpRequestError:
            # TODO: proper error handling => 
            styledEcho fgRed, "HTTP ERROR"
        if quitString(input):
            break
    