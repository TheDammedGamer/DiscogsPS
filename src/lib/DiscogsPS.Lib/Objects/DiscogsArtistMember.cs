using System;
using System.Collections.Generic;
using System.Text;

namespace DiscogsPS.Lib.Objects
{
    public class DiscogsArtistMember
    {
        public string Name { get; set; }
        public bool IsActive {get; set;}
        private int id { get; set; }
        private string ResourceURL {get; set;}
    }
}
