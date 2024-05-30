import os
import requests
from fastapi import FastAPI, status, Response
from pydantic import BaseModel

app = FastAPI()

# Setup the Open-Meteo API client with cache and retry on error
APIKEY = os.environ["WEATHERAPI"]
if APIKEY == "":
    raise Exception("Missing API Key")


@app.get("/health")
def healthcheck():
    return {"status": "ok"}


class WeatherDict:
    def __init__(self, data: any):
        self.Location = data["location"]["name"]
        self.Region = data["location"]["region"]
        self.Country = data["location"]["country"]
        self.Temp = data["current"]["temp_f"]
        self.Condition = data["current"]["condition"]["text"]
        self.MaxTemp = data["forecast"]["forecastday"][0]["day"]["maxtemp_f"]
        self.MinTemp = data["forecast"]["forecastday"][0]["day"]["mintemp_f"]
        self.ChanceOfRain = data["forecast"]["forecastday"][0]["day"][
            "daily_chance_of_rain"
        ]
        self.ChanceofSnow = data["forecast"]["forecastday"][0]["day"][
            "daily_chance_of_snow"
        ]


@app.get("/api/zipcode/{location}", status_code=200)
def getWeather(location: str, response: Response):
    if len(location) != 5:
        response.status_code = status.HTTP_400_BAD_REQUEST
        return {"status": "fail", "msg": "invalid zipcode"}
    zipcode: int
    try:
        if len(location) != 5:
            raise ValueError
        zipcode = int(location)
        url = f"https://api.weatherapi.com/v1/forecast.json?q={zipcode}&days=1&alerts=yes&aqi=yes&key={APIKEY}"
        res = requests.get(url)
        if res.status_code != 200:
            response.status_code = status.HTTP_400_BAD_REQUEST
            return {"status": "fail", "msg": "unable to parse request"}
        data = res.json()
        weather = WeatherDict(data)
        response.status_code = status.HTTP_200_OK
        return weather.__dict__

    except ValueError:
        response.status_code = status.HTTP_400_BAD_REQUEST
        return {"status": "fail", "msg": "invalid zipcode"}


@app.get("/api/city/{location}", status_code=200)
def getWeather(location: str, response: Response):
    url = f"https://api.weatherapi.com/v1/forecast.json?q={location}&days=1&alerts=yes&aqi=yes&key={APIKEY}"
    res = requests.get(url)
    if res.status_code != 200:
        return
    data = res.json()
    weather = WeatherDict(data)
    response.status_code = status.HTTP_200_OK
    return weather.__dict__
