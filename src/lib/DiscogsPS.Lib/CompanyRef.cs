using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace DiscogsPS.Lib
{
    public class CompanyRef
    {
        public string CatalogNo {get; set;}
        public string EntityType {get; set;}
        public string EntityTypeName {get; set;}
        public int Id {get; private set;}
        public string Name {get; set;}
        public string ResourceURI { get; private set; }

    }
}

/*
{
    "catno": "",
    "entity_type": "13",
    "entity_type_name": "Phonographic Copyright (p)",
    "id": 82835,
    "name": "BMG Records (UK) Ltd.",
    "resource_url": "https://api.discogs.com/labels/82835"
},
*/