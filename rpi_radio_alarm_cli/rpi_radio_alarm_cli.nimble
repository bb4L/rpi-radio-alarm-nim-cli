# Package

version       = "0.1.0"
author        = "bb4L"
description   = "Nim cli for the rpi-radio-alarm"
license       = "LGPL-3.0"
srcDir        = "src"
bin           = @["rpi_radio_alarm_cli"]



# Dependencies

requires "nim >= 1.2.0"

task build_all, "This a complete build task":
  exec "nim c -d:ssl --outdir:bin src/rpi_radio_alarm_cli.nim"
  exec "nim c -d:ssl -d:mingw --outdir:bin  src/rpi_radio_alarm_cli.nim"