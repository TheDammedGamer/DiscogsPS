using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class ArtistMember
    {
        public string Name { get; set; }
        public bool IsActive { get; set; }
        public int Id { get; private set; }
        public string ResourceURL { get; private set; }

        public ArtistMember(bool isActive, string URL, int id, string name)
        {
            Name = name;
            IsActive = isActive;
            Id = id;
            ResourceURL = URL;
        }

        public static ArtistMember Create(JsonElement element)
        {
            ArtistMember member = new ArtistMember();

            foreach (var property in element.EnumerateObject())
            {
                switch (property.Name)
                {
                    case "active":
                        member.IsActive = property.Value.GetBoolean();
                        break;
                    case "resource_url":
                        member.ResourceURL = property.Value.GetString();
                        break;
                    case "id":
                        member.Id = property.Value.GetInt32();
                        break;
                    case "name":
                        member.Name = property.Value.GetString();
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the Discogs ArtistMember Object. Parameter is: {0}", property.Name));
                }
            }
            return member;
        }

        private ArtistMember()
        {

        }
    }
}
