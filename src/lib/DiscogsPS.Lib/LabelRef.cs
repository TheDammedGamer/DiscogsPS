using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class LabelRef
    {
        public string CatalogNo { get; set; }
        public string EntityType { get; set; }
        public int Id { get; private set; }
        public string Name { get; set; }
        public string ResourceURI { get; private set; }

        private LabelRef()
        {

        }
        public static LabelRef Parse(JsonElement element)
        {
            var item = new LabelRef();
            foreach (var obj in element.EnumerateObject())
            {
                switch (obj.Name)
                {
                    case "name":
                        item.Name = obj.Value.GetString();
                        break;
                    case "entity_type":
                        item.EntityType = obj.Value.GetString();
                        break;
                    case "id":
                        item.Id = obj.Value.GetInt32();
                        break;
                    case "resource_url":
                        item.ResourceURI = obj.Value.GetString();
                        break;
                    case "catno":
                        item.CatalogNo = obj.Value.GetString();
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs LabelRef Object. Parameter is: {0}", obj.Name));
                }
            }

            return item;
        }
    }
}
}
/*
{
"catno": "PB 41447",
"entity_type": "1",
"id": 895,
"name": "RCA",
"resource_url": "https://api.discogs.com/labels/895"
}
*/