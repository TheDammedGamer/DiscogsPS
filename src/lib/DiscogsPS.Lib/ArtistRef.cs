using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class ArtistRef
    {
        public string JoinWith { get; set; }
        public string Name { get; set; }
        public string NameVariation { get; set; }
        public string Tracks { get; set; }
        public string Role { get; set; }
        public int Id { get; private set; }
        public string ResourceURI { get; private set; }

        public ArtistRef()
        {

        }

        public static ArtistRef Create(JsonElement element)
        {
            ArtistRef img = new ArtistRef();

            foreach (var property in element.EnumerateObject())
            {
                switch (property.Name)
                {
                    case "join":
                        img.JoinWith = property.Value.GetString();
                        break;
                    case "name":
                        img.Name = property.Value.GetString();
                        break;
                    case "id":
                        img.Id = property.Value.GetInt32();
                        break;
                    case "anv":
                        img.NameVariation = property.Value.GetString();
                        break;
                    case "role":
                        img.Role = property.Value.GetString();
                        break;
                    case "resource_url":
                        img.ResourceURI = property.Value.GetString();
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs ArtistRef Object. Parameter is: {0}", property.Name));
                }
            }
            return img;
        }
    }
}

/*
"join": "&",
"name": "Tony Sheridan",
"anv": "",
"tracks": "",
"role": "",
"resource_url": "https://api.discogs.com/artists/261052",
"id": 261052
 */
