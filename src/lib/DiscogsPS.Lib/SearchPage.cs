using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class SearchPage
    {
        public Paging Pagination { get; set; }
        public List<object> Results { get; set; }

        private SearchPage()
        {

        }
        public static SearchPage Parse(string jsonIn)
        {
            var page = new SearchPage();
            page.Results = new List<object>();
            var obj = JsonDocument.Parse(jsonIn).RootElement;

            foreach (var item in obj.EnumerateObject())
            {
                switch (item.Name)
                {
                    case "pagination":
                        page.Pagination = Paging.Create(item.Value);
                        break;
                    default:
                        foreach (var releaseObj in item.Value.EnumerateArray())
                        {
                            foreach (var releaseItem in releaseObj.EnumerateObject())
                            {
                                switch (releaseItem.Name)
                                {
                                    case "release":
                                        page.Results.Add(ReleaseStub.Parse(releaseObj));
                                        break;
                                    case "master":
                                        page.Results.Add(MasterStub.Parse(releaseObj));
                                        break;
                                    case "artist":
                                    case "label":
                                        throw new NotImplementedException();
                                    default:
                                        throw new Exception(String.Format("Unknown Object Type when parsing Artist Releases page: {0}", releaseItem.Name));
                                }
                            }
                        }
                        break;
                }
            }

            return page;
        }
    }
}