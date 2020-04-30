import std/[terminal]
import alarms_tool
import json_helper
import my_utils

# http://patorjk.com/software/taag/#p=display&f=Small&t=RPI-ALARM
const alarmHeading = """
  ___ ___ ___     _   _      _   ___ __  __ 
 | _ \ _ \_ _|__ /_\ | |    /_\ | _ \  \/  |
 |   /  _/| |___/ _ \| |__ / _ \|   / |\/| |
 |_|_\_| |___| /_/ \_\____/_/ \_\_|_\_|  |_|
"""
const input_msg = """
    [a] enter alarms
    [r] enter radios
    [q] quit programm
    """


when isMainModule:
  printHeading(alarmHeading)
  let settings = getSettings()
  eraseScreen()

  while true:
    let input = getInput(alarmHeading, input_msg,  fgRed)

    case input:
      of "a":
        alarmsTool(settings)
      of "r":
        styledEcho styleBright, fgRed, "[ERROR]: Radio Tool not yet implemented"

    if quitString(input):
      quit(QuitSuccess)
