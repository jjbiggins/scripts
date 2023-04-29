#!/usr/bin/env python
import requests
from urllib.parse import quote


# get the user's query
query = input("Enter a song to search for: ")

# make a get request to spotify's search endpoint
encoded_query = quote(query)
print("https://api.spotify.com/v1/search?q=" + encoded_query+ "&type=track&limit=10")

response = requests.get("https://api.spotify.com/v1/search?q=" + encoded_query + "&type=track&limit=10")

print(response)
# parse the response
data = response.json()

# loop through each result and display the track name, artist name, album name, and album artwork

print(data)
for track in data['tracks']['items']:
    print("Track Name: " + track['name'])
    print("Artist Name: " + track['artists'][0]['name'])
    print("Album Name: " + track['album']['name'])
    print("Album Artwork: " + track['album']['images'][0]['url'])
    print("\n")




