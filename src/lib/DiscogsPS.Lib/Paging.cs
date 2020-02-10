using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class Paging
    {
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
        public int TotalItems { get; set; }
        public int ItemsPerPage { get; set; }
        public string FirstPageURI { get; set; }
        public string LastPageURI { get; set; }
        public string NextPageURI { get; set; }
        public string PrevPageURI { get; set; }

        private Paging()
        {

        }
        public static Paging Create(JsonElement element)
        {
            Paging page = new Paging();

            foreach (var property in element.EnumerateObject())
            {
                switch (property.Name)
                {
                    case "page":
                        page.CurrentPage = property.Value.GetInt32();
                        break;
                    case "pages":
                        page.TotalPages = property.Value.GetInt32();
                        break;
                    case "items":
                        page.TotalItems = property.Value.GetInt32();
                        break;
                    case "per_page":
                        page.ItemsPerPage = property.Value.GetInt32();
                        break;
                    case "urls":
                        foreach (var url in property.Value.EnumerateObject())
                        {
                            switch (url.Name)
                            {
                                case "first":
                                    page.FirstPageURI = property.Value.GetString();
                                    break;
                                case "prev":
                                    page.PrevPageURI = property.Value.GetString();
                                    break;
                                case "next":
                                    page.NextPageURI = property.Value.GetString();
                                    break;
                                case "last":

                                    page.LastPageURI = property.Value.GetString();
                                    break;
                                default:
                                    throw new Exception(string.Format("Unrecognised URL parameter when creating the Discogs Paging Object. Parameter is: {0}", url.Name));
                            }
                        }
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs Paging Object. Parameter is: {0}", property.Name));
                }
            }
            return page;
        }

    }
}

/*
"pagination": {
    "page": 2,
    "pages": 30,
    "items": 2255,
    "per_page": 75,
    "urls":
        {
            "first": "https://api.discogs.com/artists/1/releases?page=1&per_page=75",
            "prev": "https://api.discogs.com/artists/1/releases?page=1&per_page=75",
            "next": "https://api.discogs.com/artists/1/releases?page=3&per_page=75",
            "last": "https://api.discogs.com/artists/1/releases?page=30&per_page=75"
        }
    }
},
*/
