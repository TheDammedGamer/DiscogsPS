using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class VideoRef
    {
        public int Duration { get; private set; }
        public bool Embed { get; private set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string URL { get; private set; }

        private VideoRef()
        {

        }
        public static VideoRef Create(JsonElement element)
        {
            VideoRef member = new VideoRef();

            foreach (var property in element.EnumerateObject())
            {
                switch (property.Name)
                {
                    case "duration":
                        member.Duration = property.Value.GetInt32();
                        break;
                    case "embed":
                        member.Embed = property.Value.GetBoolean();
                        break;
                    case "title":
                        member.Title = property.Value.GetString();
                        break;
                    case "description":
                        member.Description = property.Value.GetString();
                        break;
                    case "uri":
                        member.URL = property.Value.GetString();
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs VideoRef Object. Parameter is: {0}", property.Name));
                }
            }
            return member;
        }

    }
}
