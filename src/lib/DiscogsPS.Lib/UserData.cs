using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
namespace DiscogsPS.Lib
{
    public class UserData
    {
        public bool InCollection { get; set; }
        public bool InWantlist { get; set; }

        private UserData()
        {

        }
        public static UserData Parse(JsonElement element)
        {
            var item = new UserData();
            foreach (var obj in element.EnumerateObject())
            {
                switch (obj.Name)
                {
                    case "in_collection":
                        item.InCollection = obj.Value.GetBoolean();
                        break;
                    case "in_wantlist":
                        item.InWantlist = obj.Value.GetBoolean();
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs UserData Object. Parameter is: {0}", obj.Name));
                }
            }
            return item;
        }
    }
}