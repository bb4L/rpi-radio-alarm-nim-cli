import os
import std/[terminal]
import json
import strformat
import my_utils
import alarm_types
import strutils
import sequtils

proc getSettingsFile():string=
    result = "settings.json"
    if paramCount()>0:
        result = paramStr(1)

proc parseSettingsFile(filename:string="settings.json"): Settings =
    let jsonNode = parseFile(filename)
    return to(jsonNode, Settings)


proc getSettings*(): Settings =
    var gotSettings = false
    var filename = getSettingsFile()
    while not gotSettings:
        try:
            result = parseSettingsFile(filename)
            gotSettings = true
        except IOError:
            styledEcho styleBright, fgRed, fmt"Couldn't find/parse settings file {filename}"
            filename = getInput("Please specify a correct filepath:")
    styledEcho styleBright, fgGreen, fmt"[OK]: found settings in {filename}"

proc stringToJsonData*(data:string): JsonNode =
    # TODO: validate input / handle exceptions / inproper data
    let node = parseJson("{}")
    let s_data = data.replace(" ","").split(";")
    for s in s_data:
        let entry = s.split(":")
        case entry[0]:
            of "name":
                node.add("name", newJString(entry[1]))
            of "h":
                node.add("hour", newJInt(parseBiggestInt(entry[1])))
            of "m":
                node.add("min", newJInt(parseBiggestInt(entry[1])))
            of "days":
                let days_arr = newJArray()
                for day in (entry[1].multiReplace([("[",""), ("]","")]).split(",")).map(parseInt):
                    days_arr.add(newJInt(day))
                node.add("days", days_arr)
            of "on":
                var value = true
                case entry[1]:
                    of "f","false":
                        value=false
                node.add("on", newJBool(value))
    return node