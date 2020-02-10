using System;
using System.Collections.Generic;
using System.Text.Json;

namespace DiscogsPS.Lib
{
    public class TrackListItem
    {
        public int Position { get; set; }
        public string Title { get; set; }
        public List<ArtistRef> ExtraArtists { get; set; }
        public TimeSpan Duration { get; set; }
        public string Type { get; private set; }

        private TrackListItem()
        {

        }

        public static TrackListItem Create(JsonElement element)
        {
            var item = new TrackListItem();

            foreach (var property in element.EnumerateObject())
            {
                switch (property.Name)
                {
                    case "title":
                        item.Title = property.Value.GetString();
                        break;
                    case "type_":
                        item.Type = property.Value.GetString();
                        break;
                    case "position":
                        item.Position = int.Parse(property.Value.GetString());
                        break;
                    case "duration":
                        item.Duration = TimeSpan.Parse(property.Value.GetString());
                        break;
                    case "extraartists":
                        item.ExtraArtists = new List<ArtistRef>();
                        foreach (var extraArtist in property.Value.EnumerateArray())
                        {
                            item.ExtraArtists.Add(ArtistRef.Create(extraArtist));
                        }
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs TrackListItem Object. Parameter is: {0}", property.Name));
                }
            }

            return item;
        }
    }
}

/*
"tracklist": [
    {
      "duration": "7:00",
      "position": "1",
      "type_": "track",
      "title": "Alien Encounter (Part 2)"
    },
    {
      "duration": "7:13",
      "position": "2",
      "type_": "track",
      "extraartists": [
        {
          "join": "",
          "name": "DJ Sangeet",
          "anv": "",
          "tracks": "",
          "role": "Written-By, Producer",
          "resource_url": "https://api.discogs.com/artists/25460",
          "id": 25460
        }
      ],
      "title": "From The Heart"
    },
    {
      "duration": "6:45",
      "position": "3",
      "type_": "track",
      "title": "Radio S.P.A.C.E."
    }
  ],
*/
