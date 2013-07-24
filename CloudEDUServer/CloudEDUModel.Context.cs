﻿//------------------------------------------------------------------------------
// <auto-generated>
//    此代码是根据模板生成的。
//
//    手动更改此文件可能会导致应用程序中发生异常行为。
//    如果重新生成代码，则将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace CloudEDUServer
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Objects;
    using System.Data.Objects.DataClasses;
    using System.Linq;
    
    public partial class CloudEDUEntities : DbContext
    {
        public CloudEDUEntities()
            : base("name=CloudEDUEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<CATEGORY> CATEGORies { get; set; }
        public DbSet<COMMENT> COMMENTs { get; set; }
        public DbSet<COURSE> COURSEs { get; set; }
        public DbSet<DOCUMENT> DOCUMENTs { get; set; }
        public DbSet<LESSON> LESSONs { get; set; }
        public DbSet<PARENT_GUIDE> PARENT_GUIDE { get; set; }
        public DbSet<RECOMMENDATION> RECOMMENDATIONs { get; set; }
        public DbSet<RES_TYPE> RES_TYPE { get; set; }
        public DbSet<RESOURCE> RESOURCEs { get; set; }
        public DbSet<ATTEND> ATTENDs { get; set; }
        public DbSet<CUSTOMER> CUSTOMERs { get; set; }
        public DbSet<NOTE> NOTEs { get; set; }
        public DbSet<OPR_LOG> OPR_LOG { get; set; }
        public DbSet<MANAGER> MANAGERs { get; set; }
        public DbSet<PERMISSION> PERMISSIONs { get; set; }
        public DbSet<TYPE> TYPEs { get; set; }
        public DbSet<SALEORDER> SALEORDERs { get; set; }
        public DbSet<COURSE_OK> COURSE_OK { get; set; }
        public DbSet<COURSE_PENDING> COURSE_PENDING { get; set; }
        public DbSet<COURSE_CANCEL> COURSE_CANCEL { get; set; }
    
        public virtual ObjectResult<CreateCourse_Result> CreateCourse(Nullable<int> teacher, string title, string intro, Nullable<int> category, Nullable<decimal> price, Nullable<int> pg, string icon_url)
        {
            var teacherParameter = teacher.HasValue ?
                new ObjectParameter("teacher", teacher) :
                new ObjectParameter("teacher", typeof(int));
    
            var titleParameter = title != null ?
                new ObjectParameter("title", title) :
                new ObjectParameter("title", typeof(string));
    
            var introParameter = intro != null ?
                new ObjectParameter("intro", intro) :
                new ObjectParameter("intro", typeof(string));
    
            var categoryParameter = category.HasValue ?
                new ObjectParameter("category", category) :
                new ObjectParameter("category", typeof(int));
    
            var priceParameter = price.HasValue ?
                new ObjectParameter("price", price) :
                new ObjectParameter("price", typeof(decimal));
    
            var pgParameter = pg.HasValue ?
                new ObjectParameter("pg", pg) :
                new ObjectParameter("pg", typeof(int));
    
            var icon_urlParameter = icon_url != null ?
                new ObjectParameter("icon_url", icon_url) :
                new ObjectParameter("icon_url", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<CreateCourse_Result>("CreateCourse", teacherParameter, titleParameter, introParameter, categoryParameter, priceParameter, pgParameter, icon_urlParameter);
        }
    
        public virtual ObjectResult<EnrollCourse_Result> EnrollCourse(Nullable<int> course_id, Nullable<int> customer_id)
        {
            var course_idParameter = course_id.HasValue ?
                new ObjectParameter("course_id", course_id) :
                new ObjectParameter("course_id", typeof(int));
    
            var customer_idParameter = customer_id.HasValue ?
                new ObjectParameter("customer_id", customer_id) :
                new ObjectParameter("customer_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<EnrollCourse_Result>("EnrollCourse", course_idParameter, customer_idParameter);
        }
    }
}
