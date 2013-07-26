using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApplication3
{
    class Program
    {
        static void Main(string[] args)
        {
            Uri uri = new Uri("http://10.0.1.16:8080/CloudEDUServer/CourseService.svc");
            CourseService.CloudEDUEntities ctx = new CourseService.CloudEDUEntities(uri);
            try
            {
                var result = from crs in ctx.COURSE_OK
                             where crs.TITLE == "Test Title3"
                             select crs;
                var result1 = result.FirstOrDefault();
                Console.WriteLine("{0}", result1.TITLE);
            }
            catch (Exception ex)
            {
 
            }
        }
    }
}
