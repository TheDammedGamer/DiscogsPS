using System;
namespace DiscogsPS.Lib
{
    public class APIError
    {
        public int StatusCode {get; set;}
        public bool IsSimple {get; set;}
        public string ReturnMessage {get; set;}
        public string APIMessage {get; set;}

        public void Throw() {
            throw new Exception(ReturnMessage);
        }

        public APIError() {

        }
        public static APIError SimpleError(int code, string msg) {
            var item = new APIError();
            item.IsSimple = true;
            item.StatusCode = code;
            item.ReturnMessage = msg;
            return item;
        }
        public static APIError ComplexError(int code, string msg, string apimsg) {
            var item = new APIError();
            item.IsSimple = true;
            item.StatusCode = code;
            item.ReturnMessage = msg;
            item.APIMessage = apimsg;
            return item;
        }
    }
}