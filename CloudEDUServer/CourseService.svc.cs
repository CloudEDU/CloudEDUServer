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
    public class CourseService : DataService<CloudEDUEntities>
    {
        // This method is called only once to initialize service-wide policies.
        public static void InitializeService(DataServiceConfiguration config)
        {
            // TODO: set rules to indicate which entity sets and service operations are visible, updatable, etc.
            // Examples:
            config.SetEntitySetAccessRule("*", EntitySetRights.AllRead);
            config.SetServiceOperationAccessRule("GetAllCourses", ServiceOperationRights.All);
            config.SetServiceOperationAccessRule("GetCourseByName", ServiceOperationRights.All);
            config.DataServiceBehavior.MaxProtocolVersion = DataServiceProtocolVersion.V3;
        }

        [WebGet]
        public IQueryable<COURSE> GetAllCourses()
        {
            // Get the ObjectContext that is the data source for the service.
            CloudEDUEntities ctx = new CloudEDUEntities();
            try
            {
                var result = ctx.COURSEs;
                return result;
            }
            catch (Exception ex)
            {
                throw new ApplicationException(string.Format(
                    "An error occurred: {0}", ex.Message));
            }
        }

        [WebGet]
        public IQueryable<COURSE> GetCourseByName(string name)
        {
            if (string.IsNullOrEmpty(name))
            {
                throw new ArgumentNullException("name", "You must provide a name!");
            }
            CloudEDUEntities ctx = new CloudEDUEntities();
            try
            {
                var result = from crs in ctx.COURSEs
                             where crs.TITLE == name
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
