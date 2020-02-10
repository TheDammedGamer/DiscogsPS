using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class Artist
    {
        public string Pofile { get; set; }
        public string Name { get; set; }
        public string WebURL { get; set; }
        public List<string> URLs { get; set; }
        public string DataQuality { get; set; }

        public List<ArtistMember> Members { get; set; }
        public List<Image> Images { get; set; }

        public string ReleasesURL { get; set; }
        public string ResourceURL { get; private set; }
        public int id { get; private set; }

        private Artist()
        {

        }

        static public Artist Create(string jsonIn)
        {
            Artist artist = new Artist();

            var obj = JsonDocument.Parse(jsonIn).RootElement;

            foreach (var item in obj.EnumerateObject())
            {
                switch (item.Name)
                {
                    case "urls":
                        artist.URLs = new List<string>();
                        foreach (var arrayItem in item.Value.EnumerateArray())
                        {
                            artist.URLs.Add(arrayItem.GetString());
                        }
                        break;
                    case "profile":
                        artist.Pofile = item.Value.GetString();
                        break;
                    case "releases_url":
                        artist.ReleasesURL = item.Value.GetString();
                        break;
                    case "name":
                        artist.Name = item.Value.GetString();
                        break;
                    case "uri":
                        artist.WebURL = item.Value.GetString();
                        break;
                    case "members":
                        artist.Members = new List<ArtistMember>();
                        foreach (var member in item.Value.EnumerateArray())
                        {
                            artist.Members.Add(ArtistMember.Create(member));
                        }
                        break;
                    case "images":
                        artist.Images = new List<Image>();
                        foreach (var member in item.Value.EnumerateArray())
                        {
                            artist.Images.Add(Image.Create(member));
                        }
                        break;
                    case "resource_url":
                        artist.ResourceURL = item.Value.GetString();
                        break;
                    case "id":
                        artist.id = item.Value.GetInt32();
                        break;
                    case "data_quality":
                        artist.DataQuality = item.Value.GetString();
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs Artist Object. Parameter is: {0}", item.Name));
                }
            }

            return artist;
        }
    }


}
