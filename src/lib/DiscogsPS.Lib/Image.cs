using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;

namespace DiscogsPS.Lib
{
    public class Image
    {
        public int Id { get; private set; }
        public string ResourceURI { get; private set; }
        public int Height { get; set; }
        public int Width { get; set; }
        public string DownloadURL { get; set; }
        public ImageType Type { get; set; }
        public string ThumbnailURL { get; set; }

        private Image()
        {

        }

        public static Image Create(JsonElement element)
        {
            Image img = new Image();

            foreach (var property in element.EnumerateObject())
            {
                switch (property.Name)
                {
                    case "uri":
                        img.DownloadURL = property.Value.GetString();
                        break;
                    case "resource_url":
                        img.ResourceURI = property.Value.GetString();
                        break;
                    case "id":
                        img.Id = property.Value.GetInt32();
                        break;
                    case "height":
                        img.Height = property.Value.GetInt32();
                        break;
                    case "width":
                        img.Width = property.Value.GetInt32();
                        break;
                    case "type":
                        if (property.Value.GetString() == "primary")
                            img.Type = ImageType.Primary;
                        else if (property.Value.GetString() == "secondary")
                            img.Type = ImageType.Secondary;
                        else
                            img.Type = ImageType.Other;
                        break;
                    case "uri150":
                        img.ThumbnailURL = property.Value.GetString();
                        break;
                    default:
                        throw new Exception(string.Format("Unrecognised parameter when creating the DiscogsImage Object. Parameter is: {0}", property.Name));
                }
            }
            return img;
        }

    }


}
