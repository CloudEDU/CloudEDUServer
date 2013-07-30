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
        private static CloudEDUEntities ctx = new CloudEDUEntities();

        // This method is called only once to initialize service-wide policies.
        public static void InitializeService(DataServiceConfiguration config)
        {
            // TODO: set rules to indicate which entity sets and service operations are visible, updatable, etc.
            // Examples:
            config.SetEntitySetAccessRule("*", EntitySetRights.All);
            config.SetServiceOperationAccessRule("*", ServiceOperationRights.All);
            config.DataServiceBehavior.MaxProtocolVersion = DataServiceProtocolVersion.V3;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="customer_id"></param>
        /// <param name="course_id"></param>
        /// <returns>0 success, others fail</returns>
        [WebGet]
        public int? EnrollCourse(int customer_id, int course_id)
        {
            int? res = ctx.EnrollCourse(course_id, customer_id).FirstOrDefault();
            return res;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="teacher_id"></param>
        /// <param name="title"></param>
        /// <param name="intro"></param>
        /// <param name="category_id"></param>
        /// <param name="price"></param>
        /// <param name="pg_id"></param>
        /// <param name="icon_url"></param>
        /// <returns>0 success, others fail</returns>
        [WebGet]
        public int? CreateCourse(int teacher_id, string title, string intro, int category_id, double price, int pg_id, string icon_url)
        {
            int? res = ctx.CreateCourse(teacher_id, title, intro, category_id, new decimal(price), pg_id, icon_url).FirstOrDefault();
            return res;
        }


        //[WebGet]
        //public IQueryable<CUSTOMER> GetCustomersByName(string name)
        //{
        //    if (string.IsNullOrEmpty(name))
        //    {
        //        throw new ArgumentNullException("name", "You must provide a name!");
        //    }
        //    try
        //    {
        //        var result = from crs in ctx.CUSTOMERs
        //                     where crs.NAME == name
        //                     select crs;
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException(string.Format(
        //            "An error occurred: {0}", ex.Message));
        //    }
        //}

        //[WebGet]
        //public IQueryable<CUSTOMER> GetAllCustomers()
        //{
        //    try
        //    {
        //        var result = ctx.CUSTOMERs;
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException(string.Format(
        //            "An error occurred: {0}", ex.Message));
        //    }
        //}

        //[WebGet]
        //public IQueryable<CUSTOMER> GetCustomersByNameAndPassword(string name, string password)
        //{
        //    if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(password))
        //    {
        //        throw new ArgumentNullException("name", "You must provide a name!");
        //    }
        //    try
        //    {
        //        var result = from crs in ctx.CUSTOMERs
        //                     where crs.NAME == name && crs.PASSWORD == password
        //                     select crs;
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException(string.Format(
        //            "An error occurred: {0}", ex.Message));
        //    }
        //}

        //[WebGet]
        //public IQueryable<CUSTOMER> GetCustomerByID(int id)
        //{
        //    try
        //    {
        //        var result = from crs in ctx.CUSTOMERs
        //                     where crs.ID == id
        //                     select crs;
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException(string.Format(
        //            "An error occurred: {0}", ex.Message));
        //    }
        //}


        //[WebGet]
        //public IQueryable<COURSE_OK> GetAllCourses()
        //{
        //    try
        //    {
        //        var result = ctx.COURSE_OK;
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException(string.Format(
        //            "An error occurred: {0}", ex.Message));
        //    }

        //}

        //[WebGet]
        //public IQueryable<COURSE_OK> GetCoursesByName(string name)
        //{
        //    if (string.IsNullOrEmpty(name))
        //    {
        //        throw new ArgumentNullException("name", "You must provide a name!");
        //    }

        //    try
        //    {
        //        var result = from crs in ctx.COURSE_OK
        //                     where crs.TITLE == name
        //                     select crs;
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException(string.Format(
        //            "An error occurred: {0}", ex.Message));
        //    }
        //}

        //[WebGet]
        //public IQueryable<COURSE_OK> GetCoursesByDate()
        //{
        //    try
        //    {
        //        var result = from crs in ctx.COURSE_OK
        //                     orderby crs.START_TIME
        //                     select crs;
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException(string.Format(
        //            "An error occurred: {0}", ex.Message));
        //    }
        //}

        //[WebGet]
        //public IQueryable<CATEGORY> GetAllCategories()
        //{
        //    try
        //    {
        //        var result = ctx.CATEGORies;
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw new ApplicationException(string.Format(
        //            "An error occurred: {0}", ex.Message));
        //    }
        //}
    }
}
