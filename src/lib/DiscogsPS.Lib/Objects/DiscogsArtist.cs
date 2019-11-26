using System;
using System.Collections.Generic;
using System.Text;

namespace DiscogsPS.Lib.Objects
{
    public class DiscogsArtist
    {
        public string Pofile { get; set; }
        public string Name { get; set; }
        public string WebURL { get; set; }
        public List<string> URLs { get; set; }
        public string DataQuality { get; set; }

        public List<DiscogsArtistMember> Members {get; set;}




        private string ReleasesURL { get; set; }
        private string ResourceURL { get; set; }
        private int id { get; set; }
    }
}
