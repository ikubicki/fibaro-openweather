# OpenWeather weather provider

An alternative to YR weather provider, that is default weather provider for HC3.

Beside main virtual device, it provides couple other virtual devices (sensors) that show current:
* Temperature
* Wind
* Rain
* Pressure
* Humidity
* Cloud cover
* UV index
* Time of sunrise
* Time of sunset

Data updates every 1 hour.

## Configuration

Main device requires only an `APIKEY` to be specified.
APIKEY can be obtained from [OpenWeather API keys](https://home.openweathermap.org/api_keys) page.

To filter child devices you can use `Devices` variable where you can use specify one or more of following values:
* temperature
* wind
* pressure
* humidity
* clouds
* uv
* sunrise
* sunset
* rain

Please specify multiple values separated by comas. Do not use any white characters!

Defaults to `temperature,wind,pressure,humidity,clouds,uv,sunrise,sunset,rain`

## Changing weather provider

To change default weather provider you need to go to Settings page and click General category. 
On displayed page you should see section called Main Sensors with Weather provider dropdown, that will let you pick OpenWeather Station as your new source of information.

To see changes in top bar, you need to refresh Home Center UI.
