using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class ReleaseStub
    {
        public string Artist { get; set; }
        public int Id { get; private set; }
        public string ResourceURI { get; private set; }
        public string Role { get; set; }
        public string ThumbnailURL { get; set; }
        public string Title { get; set; }
        public int Year { get; set; }

        public string Format { get; set; }
        public string Label { get; set; }

        private ReleaseStub()
        {

        }

        public static ReleaseStub Parse(JsonElement element)
        {
            var item = new ReleaseStub();
            foreach (var obj in element.EnumerateObject())
            {
                switch (obj.Name)
                {
                    case "artist":
                        item.Artist = obj.Value.GetString();
                        break;
                    case "id":
                        item.Id = obj.Value.GetInt32();
                        break;
                    case "resource_url":
                        item.ResourceURI = obj.Value.GetString();
                        break;
                    case "role":
                        item.Role = obj.Value.GetString();
                        break;
                    case "thumb":
                        item.ThumbnailURL = obj.Value.GetString();
                        break;
                    case "title":
                        item.Title = obj.Value.GetString();
                        break;
                    case "year":
                        item.Year = obj.Value.GetInt32();
                        break;
                    case "format":
                        item.Format = obj.Value.GetString();
                        break;
                    case "label":
                        item.Label = obj.Value.GetString();
                        break;
                    case "type":
                        //Don't Care
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs MasterStub Object. Parameter is: {0}", obj.Name));
                }
            }

            return item;
        }
    }

}


/*

    {
      "artist": "Nickelback",
      "format": "CD, EP",
      "id": 4299404,
      "label": "Not On Label (Nickelback Self-released)",
      "resource_url": "http://api.discogs.com/releases/4299404",
      "role": "Main",
      "status": "Accepted",
      "thumb": "https://api-img.discogs.com/eFRGD78N7UhtvRjhdLZYXs2QJXk=/fit-in/90x90/filters:strip_icc():format(jpeg):mode_rgb()/discogs-images/R-4299404-1361106117-3632.jpeg.jpg",
      "title": "Hesher",
      "type": "release",
      "year": 1996
    }
*/
