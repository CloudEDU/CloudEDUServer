using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CloudEDUServer
{
    public class CustomerAccess
    {
        private static CloudEDUEntities ctx = new CloudEDUEntities();

        public static CUSTOMER[] GetAllCustomers()
        {
            return ctx.CUSTOMERs.ToArray();
        }

        public static bool UpdateCustomer(CUSTOMER customer)
        {
            try
            {
                ctx.Entry(customer).State = System.Data.EntityState.Modified;
                ctx.SaveChanges();
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine(e);
                return false;
            }
            return true;
        }
    }
}