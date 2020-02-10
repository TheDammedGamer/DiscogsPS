using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class MasterStub
    {
        public string Artist { get; set; }
        public int Id { get; private set; }
        public int ReleaseID { get; private set; }
        public string ResourceURI { get; private set; }
        public string Role { get; set; }
        public string ThumbnailURL { get; set; }
        public string Title { get; set; }
        public int Year { get; set; }

        private MasterStub()
        {

        }

        public static MasterStub Parse(JsonElement element)
        {
            var item = new MasterStub();
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
                    case "main_release":
                        item.ReleaseID = obj.Value.GetInt32();
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
      "id": 173765,
      "main_release": 3128432,
      "resource_url": "http://api.discogs.com/masters/173765",
      "role": "Main",
      "thumb": "https://api-img.discogs.com/lb0zp7--FLaRP0LmJ4W6DhfweNc=/fit-in/90x90/filters:strip_icc():format(jpeg):mode_rgb()/discogs-images/R-5557864-1396493975-7618.jpeg.jpg",
      "title": "Curb",
      "type": "master",
      "year": 1996
    }
    {
      "artist": "Nickelback",
      "id": 173767,
      "main_release": 1905922,
      "resource_url": "http://api.discogs.com/masters/173767",
      "role": "Main",
      "thumb": "https://api-img.discogs.com/12LXbUV44IHjyb6drFZOTQxgCqs=/fit-in/90x90/filters:strip_icc():format(jpeg):mode_rgb()/discogs-images/R-1905922-1251540516.jpeg.jpg",
      "title": "Leader Of Men",
      "type": "master",
      "year": 1999
    }
*/
