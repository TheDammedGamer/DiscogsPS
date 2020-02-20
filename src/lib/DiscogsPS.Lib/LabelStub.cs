using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class LabelStub
    {
        public string Name {get; set;}
        public string CatalogNo { get; set; }
        public string ResourceURI { get; private set; }
        public int Id { get; private set; }
        public string EntityType { get; set; }
        public string EntityTypeName { get; set; }

        private LabelStub()
        {

        }
        public static LabelStub Parse(JsonElement element)
        {
            var item = new LabelStub();
            foreach (var obj in element.EnumerateObject())
            {
                switch (obj.Name)
                {
                    case "name":
                        item.Name = obj.Value.GetString();
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

                    case "entity_type_name":
                        item.EntityTypeName = obj.Value.GetString();
                        break;
                    case "entity_type":
                        item.EntityType = obj.Value.GetString();
                        break;
                    case "type":
                        //Don't Care
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs LabelStub Object. Parameter is: {0}", obj.Name));
                }
            }

            return item;
        }
    }
}

/*
thumb        :
title        : Aer-born
user_data    : @{in_collection=False; in_wantlist=False}
master_url   :
uri          : /label/81903-Aer-born
cover_image  : https://img.discogs.com/b732ab3bfd35cc5750d4cf1f09ae41bbfbe5d7eb/images/spacer.gif
resource_url : https://api.discogs.com/labels/81903
master_id    :
type         : label
id           : 81903
*/
