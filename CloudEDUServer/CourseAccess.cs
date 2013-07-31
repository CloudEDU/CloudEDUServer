using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CloudEDUServer
{
    public enum CourseStatus
    {
        PENDING,
        OK,
        CANCEL
    };

    public class CourseAccess
    {
        #region 查询方法

        public static COURSE[] GetAllCourses()
        {
            COURSE[] courses = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                courses = ctx.COURSEs.ToArray();
            }
            return courses;
        }

        public static COURSE[] GetAllPendingCourses()
        {
            COURSE_PENDING[] courses = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                courses = ctx.COURSE_PENDING.ToArray();
            }

            COURSE[] returnCourse=new COURSE[courses.Length];
            for (int i = 0; i < courses.Length; i++)
            {
                returnCourse[i] = ConvertToCourse(courses[i]);
            }
            return returnCourse;
        }

        public static COURSE[] GetAllCancelCourses()
        {
            COURSE_CANCEL[] courses = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                courses = ctx.COURSE_CANCEL.ToArray();
            }
            COURSE[] returnCourse = new COURSE[courses.Length];
            for (int i = 0; i < courses.Length; i++)
            {
                returnCourse[i] = ConvertToCourse(courses[i]);
            }
            return returnCourse;
        }

        public static COURSE[] GetAllOKCourses()
        {
            COURSE_OK[] courses = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                courses = ctx.COURSE_OK.ToArray();
            }
            COURSE[] returnCourse = new COURSE[courses.Length];
            for (int i = 0; i < courses.Length; i++)
            {
                returnCourse[i] = ConvertToCourse(courses[i]);
            }
            return returnCourse;
        }

        public static CATEGORY[] GetAllCategories()
        {
            CATEGORY[] categories = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                categories = ctx.CATEGORies.ToArray();
            }
            return categories;
        }

        public static LESSON GetLessonByID(int lesson_id)
        {
            LESSON lesson = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                lesson = ctx.LESSONs.Where(l => l.ID == lesson_id).FirstOrDefault();
            }
            return lesson;
        }

        public static int GetDownloadTimeByCourseID(int course_id)
        {
            int count = 0;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                count = ctx.ATTENDs.Where(a => a.COURSE_ID == course_id).Count();
            }
            return count;
        }

        public static COURSE GetCourseById(int course_id)
        {
            COURSE course = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
            
                course=ctx.COURSEs.Where(c=>c.ID==course_id).FirstOrDefault();
            }
            return course;
        }

        public static COURSE[] GetCoursesByCategory(CATEGORY category)
        {
            COURSE[] courses = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                courses = ctx.COURSEs.Where(c => c.CATEGORY == category.ID).ToArray();
            }
            return courses;
        }

        public static LESSON[] GetLessonsByCourse(COURSE course)
        {
            LESSON[] lessons = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var cs = ctx.COURSEs.Include("LESSONs").Where(c => c.ID == course.ID).FirstOrDefault();
                lessons = cs.LESSONs.ToArray();
            }
            return lessons;
        }

        public static LESSON[] GetLessonsByCourse(int course_id)
        {
            LESSON[] lessons = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var cs = ctx.COURSEs.Include("LESSONs").Where(c => c.ID == course_id).FirstOrDefault();
                lessons = cs.LESSONs.ToArray();
            }
            return lessons;
        }

        public static DOCUMENT[] GetDocumentsByLesson(LESSON lesson)
        {
            DOCUMENT[] documents = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var ls = ctx.LESSONs.Include("DOCUMENTs").Where(l => l.ID == lesson.ID).FirstOrDefault();
                documents = ls.DOCUMENTs.ToArray();
            }
            return documents;
        }

        public static DOCUMENT[] GetDocumentsByLesson(int lesson_id)
        {
            DOCUMENT[] documents = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var ls = ctx.LESSONs.Include("DOCUMENTs").Where(l => l.ID == lesson_id).FirstOrDefault();
                documents = ls.DOCUMENTs.ToArray();
            }
            return documents;
        }

        public static DOCUMENT GetDocumentByDocumentID(int document_id)
        {
            DOCUMENT document = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                document = ctx.DOCUMENTs.Where(c => c.ID == document_id).FirstOrDefault();
            }
            return document;
        }

        public static RESOURCE GetResourceByResourceID(int resource_id)
        {
            RESOURCE resource = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                resource = ctx.RESOURCEs.Where(r => r.ID == resource_id).FirstOrDefault();
            }
            return resource;
        }

        public static RES_TYPE GetResourceTypeByID(int id)
        {
            RES_TYPE res = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                res = ctx.RES_TYPE.Where(r => r.ID == id).FirstOrDefault();
            }
            return res;
        }

        public static PARENT_GUIDE GetParentGuideByID(int id)
        {
            PARENT_GUIDE pg = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                pg = ctx.PARENT_GUIDE.Where(p => p.ID == id).FirstOrDefault();
            }
            return pg;
        }

        public static RESOURCE[] GetResourcesByLesson(LESSON lesson)
        {
            RESOURCE[] resources = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var rs = ctx.LESSONs.Include("RESOURCEs").Where(l => l.ID == lesson.ID).FirstOrDefault();
                resources = rs.RESOURCEs.ToArray();
            }
            return resources;
        }



        public static COMMENT GetCommentByID(int comment_id)
        {
            COMMENT comment = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                comment = ctx.COMMENTs.Where(c => c.ID == comment_id).FirstOrDefault();
            }
            return comment;
        }

        public static RESOURCE[] GetResourcesByLesson(int lesson_id)
        {
            RESOURCE[] resources = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var rs = ctx.LESSONs.Include("RESOURCEs").Where(l => l.ID == lesson_id).FirstOrDefault();
                resources = rs.RESOURCEs.ToArray();
            }
            return resources;
        }

        public static NOTE_SHARABLE[] GetAllNotesSharable()
        {
            NOTE_SHARABLE[] notes = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                notes = ctx.NOTE_SHARABLE.ToArray();
            }
            return notes;
        }

        public static NOTE_SHARABLE[] GetNoteSharableByLesson(LESSON lesson)
        {
            NOTE_SHARABLE[] notes = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                notes = ctx.NOTE_SHARABLE.Where(n => n.LESSON_ID == lesson.ID).ToArray();
            }
            return notes;
        }

        public static NOTE_SHARABLE[] GetNoteSharableByCustomer(CUSTOMER customer)
        {
            NOTE_SHARABLE[] notes = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                notes = ctx.NOTE_SHARABLE.Where(n => n.CUSTOMER_ID == customer.ID).ToArray();
            }
            return notes;
        }

        public static COMMENT[] GetCommentsByCustomer(CUSTOMER customer)
        {
            COMMENT[] comments = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                comments = ctx.COMMENTs.Where(c => c.CUSTOMER_ID == customer.ID).ToArray();
            }
            return comments;
        }

        public static COMMENT[] GetCommentsByCourse(COURSE course)
        {
            COMMENT[] comments = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                comments = ctx.COMMENTs.Where(c => c.COURSE_ID == course.ID).ToArray();
            }
            return comments;
        }

        //public static CUSTOMER[] GetCustomersAsStudentByCourse(int course_id)
        //{
        //    CUSTOMER[] customers = null;
        //    using (CloudEDUEntities ctx = new CloudEDUEntities())
        //    {
        //        var cs = ctx.COURSEs.Include("CUSTOMER_attend").Where(c => c.ID == course_id).FirstOrDefault();
        //        customers = cs.CUSTOMER_attend.ToArray();
        //    }
        //    return customers;
        //}

        public static RECOMMENDATION[] GetAllRecommendations()
        {
            RECOMMENDATION[] reco = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                reco = ctx.RECOMMENDATIONs.ToArray();
            }
            return reco;
        }

        public static CATEGORY GetCategoryByID(int cate_id)
        {
            CATEGORY cate = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                cate = ctx.CATEGORies.Where(c => c.ID == cate_id).FirstOrDefault();
            }
            return cate;
        }

        public static COURSE_HOTRANK_Result[] GetHotRankOfCourses()
        {
            COURSE_HOTRANK_Result[] hotrank = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                hotrank = ctx.COURSE_HOTRANK().ToArray();
            }
            return hotrank;
        }

        public static RECOMMENDATION GetRecommendationByID(int reco_id)
        {
            RECOMMENDATION reco = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                reco = ctx.RECOMMENDATIONs.Where(r => r.ID == reco_id).FirstOrDefault();
            }
            return reco;
        }

        public static COURSE[] GetCoursesByRecommendation(RECOMMENDATION reco)
        {
            COURSE[] courses = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var rc = ctx.RECOMMENDATIONs.Include("COURSEs").Where(r => r.ID == reco.ID).FirstOrDefault();
                courses = rc.COURSEs.ToArray();
            }
            return courses;
        }

        #endregion

        #region 更新方法

        /// <summary>
        /// 用于更新课程的状态，状态包括Pending、OK、Cancel三项
        /// </summary>
        /// <param name="course_id">课程的ID</param>
        /// <param name="state">课程的状态，类型为枚举CourseStatus</param>
        /// <returns>true表示成功，false表示失败</returns>
        public static bool UpdateCourseStatus(int course_id, CourseStatus state)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    COURSE course = ctx.COURSEs.Where(c => c.ID == course_id).FirstOrDefault();
                    course.COURSE_STATUS = state.ToString();
                    ctx.Entry(course).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }


        /// <summary>
        /// 用于更改课程信息，这是一个很强的方法，理论上可以更改全部信息。该方法可以覆盖UpdateCourseStatus的功能。
        /// 如果有更相应的方法不推荐使用这个方法
        /// </summary>
        /// <param name="course">更改后的Course的实例</param>
        /// <returns>ture表示成功，false表示失败</returns>
        public static bool UpdateCourse(COURSE course)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Entry(course).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool AddCategory(CATEGORY category)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Set<CATEGORY>().Add(category);
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool AddRecommendation(RECOMMENDATION reco)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Set<RECOMMENDATION>().Add(reco);
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool AddCourseToRecommendation(COURSE course, RECOMMENDATION reco)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var rc = ctx.RECOMMENDATIONs.Include("COURSEs").Where(r => r.ID == reco.ID).FirstOrDefault();
                    var cs = ctx.COURSEs.Where(c => c.ID == course.ID).FirstOrDefault();
                    rc.COURSEs.Add(cs);
                    ctx.Entry(rc).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }

            }
            return true;
        }

        
        private static bool AddLessonsToCourse(LESSON[] lessons, COURSE course)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var cs = ctx.COURSEs.Include("LESSONs").Where(c => c.ID == course.ID).FirstOrDefault();
                    foreach (LESSON ls in lessons)
                        cs.LESSONs.Add(ls);
                    ctx.Entry(cs).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        private static bool AddResourcesToLesson(RESOURCE[] res, LESSON lesson)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var ls = ctx.LESSONs.Include("RESOURCEs").Where(l => l.ID == lesson.ID).FirstOrDefault();
                foreach (RESOURCE rs in res)
                    ls.RESOURCEs.Add(rs);
                ctx.Entry(ls).State = System.Data.EntityState.Modified;
                ctx.SaveChanges();
            }
            return true;
        }

        public static bool ToggleNoteSharability(NOTE note)
        {
            note.SHARE = !note.SHARE;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Set<NOTE>().Attach(note);
                    ctx.Entry(note).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool UpdateCategory(CATEGORY category)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Entry(category).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool UpdateRecommendation(RECOMMENDATION reco)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Entry(reco).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        #endregion

        #region 删除方法
        public static bool RemoveLesson(LESSON lesson)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Set<LESSON>().Attach(lesson);
                    ctx.Set<LESSON>().Remove(lesson);
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool RemoveResource(RESOURCE resource)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Set<RESOURCE>().Attach(resource);
                    ctx.Set<RESOURCE>().Remove(resource);
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool RemoveDocument(DOCUMENT document)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Set<DOCUMENT>().Attach(document);
                    ctx.Set<DOCUMENT>().Remove(document);
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool RemoveComment(COMMENT comment)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Set<COMMENT>().Attach(comment);
                    ctx.Set<COMMENT>().Remove(comment);
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }


        public static bool RemoveCategory(CATEGORY category)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Set<CATEGORY>().Attach(category);
                    ctx.Set<CATEGORY>().Remove(category);
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool RemoveCourseFromRecommendation(COURSE course, RECOMMENDATION reco)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.RECOMMENDATIONs.Attach(reco);
                    ctx.COURSEs.Attach(course);
                    reco.COURSEs.Remove(course);
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool RemoveRecommendation(RECOMMENDATION reco)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.RECOMMENDATIONs.Attach(reco);
                    ctx.RECOMMENDATIONs.Remove(reco);
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }

            }
            return true;
        }

        

        #endregion

        #region 转换方法
        public static COURSE ConvertToCourse(COURSE_CANCEL course)
        {
            COURSE cs = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                cs = ctx.COURSEs.Where(c => c.ID == course.ID).FirstOrDefault();
            }
            return cs;
        }

        public static COURSE ConvertToCourse(COURSE_OK course)
        {
            COURSE cs = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                cs = ctx.COURSEs.Where(c => c.ID == course.ID).FirstOrDefault();
            }
            return cs;
        }

        public static COURSE ConvertToCourse(COURSE_PENDING course)
        {
            COURSE cs = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                cs = ctx.COURSEs.Where(c => c.ID == course.ID).FirstOrDefault();
            }
            return cs;
        }

        public static NOTE ConvertToNote(NOTE_SHARABLE note)
        {
            NOTE nt = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                nt = ctx.NOTEs.Where(n => n.ID == note.ID).FirstOrDefault();
            }
            return nt;
        }
        #endregion

    }
}