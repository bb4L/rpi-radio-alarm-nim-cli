type
    Alarm* = object
        name*: string
        hour*: int
        min*: int
        days*: seq[int]
        on*: bool
    Radio* = object
        is_running*:bool
    Settings* = object
        host*: string
        header*: string
        key*: string