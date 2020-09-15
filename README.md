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

## Changing weather provider

To change default weather provider you need to go to Settings page and click General category. 
On displayed page you should see section called Main Sensors with Weather provider dropdown, that will let you pick OpenWeather Station as your new source of information.

To see changes in top bar, you need to refresh Home Center UI.
