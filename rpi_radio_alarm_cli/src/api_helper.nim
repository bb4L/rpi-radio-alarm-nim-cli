import httpClient
import json
import alarm_types
import json_helper

proc prepare_client(settings:Settings):HttpClient=
    result = newHttpClient()
    result.headers = newHttpHeaders({ settings.header: settings.key })


proc getAlarms*(settings:Settings): seq[Alarm] =
    let client = prepare_client(settings)
    return to(parseJson(client.getContent(settings.host & "/alarm")),seq[Alarm])

    #  only prepare the http client so that the route can be send to the function and then it returns the content without json processing
proc getAlarm*(settings:Settings, index:string): Alarm = 
    let client = prepare_client(settings)
    return to(parseJson(client.getContent(settings.host & "/alarm/" & index)),Alarm)

proc changeAlarm*(settings:Settings, index:string, data:string): Alarm=
    let client = prepare_client(settings)
    client.headers["Content-Type"]="application/json"
    let body = stringToJsonData(data)
    return to(parseJson(client.putContent(settings.host & "/alarm/" & index, $body)),Alarm)


proc changeRadio*(settins:Settings, on:bool) = 
    echo "change radio"