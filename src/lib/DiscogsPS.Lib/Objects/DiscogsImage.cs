using System;
using System.Collections.Generic;
using System.Text;

namespace DiscogsPS.Lib.Objects
{
    class DiscogsImage
    {
        private int id { get; set; }
        private string ResourceURL { get; set; }

        public int Height { get; set; }
        public int Width { get; set; }
        public string URI { get; set; }
        public DiscogsImageType Type {get; set;}
        public string URI150 { get; set; }
    }

    
}
