//------------------------------------------------------------------------------
// <copyright file="WebDataService.svc.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------
using System;
using System.Collections.Generic;
using System.Data.Services;
using System.Data.Services.Common;
using System.Linq;
using System.ServiceModel.Web;
using System.Web;

namespace CloudEDUServer
{
    public class CustomerService : DataService<CloudEDUEntities>
    {
        // This method is called only once to initialize service-wide policies.
        public static void InitializeService(DataServiceConfiguration config)
        {
            // TODO: set rules to indicate which entity sets and service operations are visible, updatable, etc.
            // Examples:
            config.SetEntitySetAccessRule("*", EntitySetRights.AllRead);
            config.SetServiceOperationAccessRule("GetCustomersByName", ServiceOperationRights.All);
            config.SetServiceOperationAccessRule("GetAllCustomers", ServiceOperationRights.All);
            config.SetServiceOperationAccessRule("GetCustomersByNameAndPassword", ServiceOperationRights.All);
            config.SetServiceOperationAccessRule("GetCustomersByID", ServiceOperationRights.All);
            config.DataServiceBehavior.MaxProtocolVersion = DataServiceProtocolVersion.V3;
        }

        [WebGet]
        public IQueryable<CUSTOMER> GetCustomersByName(string name)
        {
            if (string.IsNullOrEmpty(name))
            {
                throw new ArgumentNullException("name", "You must provide a name!");
            }
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = from crs in ctx.CUSTOMERs
                                 where crs.NAME == name
                                 select crs;
                    return result;
                }
                catch (Exception ex)
                {
                    throw new ApplicationException(string.Format(
                        "An error occurred: {0}", ex.Message));
                }
            }        
        }

        [WebGet]
        public IQueryable<CUSTOMER> GetAllCustomers()
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = ctx.CUSTOMERs;
                    return result;
                }
                catch (Exception ex)
                {
                    throw new ApplicationException(string.Format(
                        "An error occurred: {0}", ex.Message));
                }
            }        
        }

        [WebGet]
        public IQueryable<CUSTOMER> GetCustomersByNameAndPassword(string name, string password)
        {
            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(password))
            {
                throw new ArgumentNullException("name", "You must provide a name!");
            }
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = from crs in ctx.CUSTOMERs
                                 where crs.NAME == name && crs.PASSWORD == password
                                 select crs;
                    return result;
                }
                catch (Exception ex)
                {
                    throw new ApplicationException(string.Format(
                        "An error occurred: {0}", ex.Message));
                }
            }       
        }

        [WebGet]
        public IQueryable<CUSTOMER> GetCustomerByID(int id)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = from crs in ctx.CUSTOMERs
                                 where crs.ID == id
                                 select crs;
                    return result;
                }
                catch (Exception ex)
                {
                    throw new ApplicationException(string.Format(
                        "An error occurred: {0}", ex.Message));
                }
            }  
        }
    }
}
