using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class ArtistStub
    {
        public int Id { get; private set; }
        public string ResourceURI { get; private set; }
        public string WebURL {get; private set;}
        public string Role { get; set; }
        public string ThumbnailURL { get; set; }
        public string Title { get; set; }
        public int Year { get; set; }
        public UserData UserData {get; set;}

        public string Format { get; set; }
        public string Label { get; set; }

        private ArtistStub()
        {

        }

        public static ArtistStub Parse(JsonElement element)
        {
            var item = new ArtistStub();
            foreach (var obj in element.EnumerateObject())
            {
                switch (obj.Name)
                {
                    case "uri":
                        item.WebURL = "https://discogs.com" + obj.Value.GetString();
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
                    case "user_data":
                    item.UserData = UserData.Parse(obj.Value);
                        break;
                    case "type":
                    case "master_url":
                    case "master_id":
                        //Don't Care
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs ArtistStub Object. Parameter is: {0}", obj.Name));
                }
            }

            return item;
        }
    }
}

/*
thumb        : https://img.discogs.com/QtDSrerwwidPW24WDPyl5BuZElU=/150x150/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(40)/discogs-images/A-1503835-1446646097-5534.jpeg.jpg
title        : Patrizia Bovi
user_data    : @{in_collection=False; in_wantlist=False}
master_url   :
uri          : /artist/1503835-Patrizia-Bovi
cover_image  : https://img.discogs.com/V3KmAxXzcUWvRu0TQHsGAeLgT8Q=/600x899/smart/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/A-1503835-1446646097-5534.jpeg.jpg
resource_url : https://api.discogs.com/artists/1503835
master_id    :
type         : artist
id           : 1503835
*/