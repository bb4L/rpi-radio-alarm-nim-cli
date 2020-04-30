# rpi-radio-alarm-nim-cli

Cli for the [rpi-radio-alarm](https://github.com/bb4L/rpi-radio-alarm) written in Nim.

## Usage
* build the executable, a nimble task is prepared `nimble build_all`
* create a `JSON` file containing the following:
  ```JSON
  {
      "host":"HOSTNAME_URL",
      "header":"HEADER",
      "key":"KEY_FOR_THE_HEADER"
  }
  ```
  The `host` entry should point to the root of the rpi-radio-alarm api.
  The `header` and `key` values are used to create a custom header for every response.
* run the executable for your OS