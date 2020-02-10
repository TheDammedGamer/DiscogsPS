using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class ArtistReleasesPage
    {
        public Paging Pagination { get; set; }
        public List<object> Releases { get; set; }

        private ArtistReleasesPage()
        {

        }
        public static ArtistReleasesPage Parse(string jsonIn)
        {
            var page = new ArtistReleasesPage();
            page.Releases = new List<object>();
            var obj = JsonDocument.Parse(jsonIn).RootElement;

            foreach (var item in obj.EnumerateObject())
            {
                switch (item.Name)
                {
                    case "pagination":
                        page.Pagination = Paging.Create(item.Value);
                        break;
                    case "releases":
                        foreach (var releaseObj in item.Value.EnumerateArray())
                        {
                            foreach (var releaseItem in releaseObj.EnumerateObject())
                            {
                                if (releaseItem.Name == "master")
                                {
                                    page.Releases.Add(MasterStub.Parse(releaseObj));
                                }
                                else if (releaseItem.Name == "release")
                                {
                                    page.Releases.Add(ReleaseStub.Parse(releaseObj));
                                }
                                else
                                {
                                    throw new Exception(String.Format("Unknown Object Type when parsing Artist Releases page: {0}", releaseItem.Name));
                                }
                            }
                        }
                        break;
                    default:
                        break;
                }
            }

            return page;
        }
    }
}