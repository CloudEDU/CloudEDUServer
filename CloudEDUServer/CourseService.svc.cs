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
            config.SetServiceOperationAccessRule("GetCoursesByName", ServiceOperationRights.All);
            config.SetServiceOperationAccessRule("GetCoursesByDate", ServiceOperationRights.All);
            config.SetServiceOperationAccessRule("GetCoursesByAttendance", ServiceOperationRights.All);
            config.SetServiceOperationAccessRule("GetAllCategory", ServiceOperationRights.All);
            config.DataServiceBehavior.MaxProtocolVersion = DataServiceProtocolVersion.V3;
        }

        [WebGet]
        public IQueryable<COURSE_OK> GetAllCourses()
        {
            // Get the ObjectContext that is the data source for the service.
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = ctx.COURSE_OK;
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
        public IQueryable<COURSE_OK> GetCoursesByName(string name)
        {
            if (string.IsNullOrEmpty(name))
            {
                throw new ArgumentNullException("name", "You must provide a name!");
            }
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = from crs in ctx.COURSE_OK
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

        [WebGet]
        public IQueryable<COURSE_OK> GetCoursesByDate()
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = from crs in ctx.COURSE_OK
                                 orderby crs.START_TIME
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
        public IQueryable<ATTEND> GetCoursesByAttendance(COURSE course)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = from crs in ctx.ATTENDs
                                 where crs.COURSE_ID == course.ID
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
        public IQueryable<CATEGORY> GetAllCatagory()
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = ctx.CATEGORies;
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
        public IQueryable<COURSE_OK> GetCoursesByCategory(CATEGORY category)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    Random ran = new Random();
                    int randomNumber = ran.Next(5, 11);
                    var result = (from crs in ctx.COURSE_OK.Include("CATEGORY")
                                 where crs.CATEGORY == category.ID
                                 select crs).Take(randomNumber);
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
        public IQueryable<ATTEND> GetAttendanceByCustomer(CUSTOMER customer)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = from atd in ctx.ATTENDs
                                 where atd.CUSTOMER_ID == customer.ID
                                 select atd;
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
        public IQueryable<COURSE_OK> GetCourseByAttendance(ATTEND attend)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var result = from crs in ctx.COURSE_OK
                                 where crs.ID == attend.COURSE_ID
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

        //public IQueryable<COURSE_OK> GetTeachingCourseByUser(string name)
        //{
        //    if (string.IsNullOrEmpty(name))
        //    {
        //        throw new ArgumentNullException("name", "You must provide a name!");
        //    }
        //    CloudEDUEntities ctx = new CloudEDUEntities();
        //    try
        //    {
        //        var customer = ctx.CUSTOMERs.Where(p => p.NAME == name).FirstOrDefault<CUSTOMER>();
        //        return course;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException(string.Format(
        //            "An error occurred: {0}", ex.Message));
        //    }
        //}
    }
}
