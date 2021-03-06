﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class Master
    {
        public List<string> Styles { get; set; }
        public List<string> Genres { get; set; }
        public string ReleaseURI { get; private set; }
        public int NumberForSale { get; set; }
        public List<VideoRef> Videos { get; set; }
        public string Title { get; set; }
        public int ReleaseId { get; private set; }
        public List<ArtistRef> Artists { get; set; }
        public string WebURL { get; set; }
        public string VersionsURI { get; private set; }
        public double LowestPrice { get; set; }
        public int Year { get; set; }
        public List<Image> Images { get; set; }
        public string ResourceURI { get; private set; }
        public List<TrackListItem> Tracklist { get; set; }
        public int Id { get; private set; }
        public string DataQulity { get; set; }

        private Master()
        {

        }
        public static Master Create(JsonElement element)
        {
            var master = new Master();
            foreach (var property in element.EnumerateObject())
            {
                switch (property.Name)
                {
                    case "styles":
                        master.Styles = new List<string>();
                        foreach (var style in property.Value.EnumerateArray())
                        {
                            master.Styles.Add(style.GetString());
                        }
                        break;
                    case "genres":
                        master.Genres = new List<string>();
                        foreach (var genre in property.Value.EnumerateArray())
                        {
                            master.Genres.Add(genre.GetString());
                        }
                        break;
                    case "videos":
                        master.Videos = new List<VideoRef>();
                        foreach (var genre in property.Value.EnumerateArray())
                        {
                            master.Videos.Add(VideoRef.Create(genre));
                        }
                        break;
                    case "title":
                        master.Title = property.Value.GetString();
                        break;
                    case "main_release":
                        master.ReleaseId = property.Value.GetInt32();
                        break;
                    case "main_release_url":
                        master.ReleaseURI = property.Value.GetString();
                        break;
                    case "uri":
                        master.WebURL = property.Value.GetString();
                        break;
                    case "artists":
                        master.Artists = new List<ArtistRef>();
                        foreach (var artist in property.Value.EnumerateArray())
                        {
                            master.Artists.Add(ArtistRef.Create(artist));
                        }
                        break;
                    case "versions_url":
                        master.VersionsURI = property.Value.GetString();
                        break;
                    case "year":
                        master.Year = property.Value.GetInt32();
                        break;
                    case "images":
                        master.Images = new List<Image>();
                        foreach (var img in property.Value.EnumerateArray())
                        {
                            master.Images.Add(Image.Create(img));
                        }
                        break;
                    case "resource_url":
                        master.ResourceURI = property.Value.GetString();
                        break;
                    case "tracklist":
                        master.Tracklist = new List<TrackListItem>();
                        foreach (var track in property.Value.EnumerateArray())
                        {
                            master.Tracklist.Add(TrackListItem.Create(track));
                        }
                        break;
                    case "id":
                        master.Id = property.Value.GetInt32();
                        break;
                    case "num_for_sale":
                        master.NumberForSale = property.Value.GetInt32();
                        break;
                    case "lowest_price":
                        master.LowestPrice = property.Value.GetDouble();
                        break;
                    case "data_quality":
                        master.DataQulity = property.Value.GetString();
                        break;
                    default:
                        throw new ArgumentException("Unrecognised parameter when creating the Discogs Master Object.", property.Name);
                }
            }

            return master;
        }
    }
}









/*
{
  "styles": [
    "Goa Trance"
  ],
  "genres": [
    "Electronic"
  ],
  "videos": [
    {
      "duration": 421,
      "description": "Electric Universe - Alien Encounter Part 2 (Spirit Zone 97)",
      "embed": true,
      "uri": "https://www.youtube.com/watch?v=n1LGinzMDi8",
      "title": "Electric Universe - Alien Encounter Part 2 (Spirit Zone 97)"
    }
  ],
  "title": "Stardiver",
  "main_release": 66785,
  "main_release_url": "https://api.discogs.com/releases/66785",
  "uri": "http://www.discogs.com/Electric-Universe-Stardiver/master/1000",
  "artists": [
    {
      "join": "",
      "name": "Electric Universe",
      "anv": "",
      "tracks": "",
      "role": "",
      "resource_url": "https://api.discogs.com/artists/21849",
      "id": 21849
    }
  ],
  "versions_url": "https://api.discogs.com/masters/1000/versions",
  "year": 1997,
  "images": [
    {
      "height": 569,
      "resource_url": "https://api-img.discogs.com/_0K5t_iLs6CzLPKTB4mwHVI3Vy0=/fit-in/600x569/filters:strip_icc():format(jpeg):mode_rgb():quality(96)/discogs-images/R-66785-1213949871.jpeg.jpg",
      "type": "primary",
      "uri": "https://api-img.discogs.com/_0K5t_iLs6CzLPKTB4mwHVI3Vy0=/fit-in/600x569/filters:strip_icc():format(jpeg):mode_rgb():quality(96)/discogs-images/R-66785-1213949871.jpeg.jpg",
      "uri150": "https://api-img.discogs.com/sSWjXKczZseDjX2QohG1Lc77F-w=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb()/discogs-images/R-66785-1213949871.jpeg.jpg",
      "width": 600
    },
    {
      "height": 296,
      "resource_url": "https://api-img.discogs.com/1iD31iOWgfgb2DpROI4_MvmceFw=/fit-in/600x296/filters:strip_icc():format(jpeg):mode_rgb():quality(96)/discogs-images/R-66785-1213950065.jpeg.jpg",
      "type": "secondary",
      "uri": "https://api-img.discogs.com/1iD31iOWgfgb2DpROI4_MvmceFw=/fit-in/600x296/filters:strip_icc():format(jpeg):mode_rgb():quality(96)/discogs-images/R-66785-1213950065.jpeg.jpg",
      "uri150": "https://api-img.discogs.com/Cm4Q_1S784pQeRfwa0lN2jsj47Y=/fit-in/150x150/filters:strip_icc():format(jpeg):mode_rgb()/discogs-images/R-66785-1213950065.jpeg.jpg",
      "width": 600
    }
  ],
  "resource_url": "https://api.discogs.com/masters/1000",
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
  "id": 1000,
  "num_for_sale": 9,
  "lowest_price": 9.36,
  "data_quality": "Correct"
}

*/
