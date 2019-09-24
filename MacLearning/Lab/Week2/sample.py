import pandas as pd

fileToRead = pd.read_csv("weather.csv")

dataToObtain = fileToRead[fileToRead.temperature > 25]

print(dataToObtain)


