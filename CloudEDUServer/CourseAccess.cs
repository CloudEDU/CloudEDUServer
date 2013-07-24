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
    }

    public class CourseAccess
    {
        #region 查询方法
        public static COURSE_PENDING[] GetAllPendingCourses()
        {
            COURSE_PENDING[] courses = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                courses = ctx.COURSE_PENDING.ToArray();
            }
            return courses;
        }

        public static COURSE_CANCEL[] GetAllCancelCourses()
        {
            COURSE_CANCEL[] courses = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                courses = ctx.COURSE_CANCEL.ToArray();
            }
            return courses;
        }

        public static COURSE_OK[] GetAllOKCourses()
        {
            COURSE_OK[] courses = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                courses = ctx.COURSE_OK.ToArray();
            }
            return courses;
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

        public static RESOURCE[] GetDocumentsByLesson(LESSON lesson)
        {
            RESOURCE[] resources = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var rs = ctx.LESSONs.Include("RESOURCEs").Where(l => l.ID == lesson.ID).FirstOrDefault();
                resources = rs.RESOURCEs.ToArray();
            }
            return resources;
        }


        public static RESOURCE[] GetDocumentsByLesson(int lesson_id)
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

        public static CUSTOMER[] GetCustomersAsStudentByCourse(int course_id)
        {
            CUSTOMER[] customers = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var cs = ctx.COURSEs.Include("CUSTOMER_attend").Where(c => c.ID == course_id).FirstOrDefault();
                customers = cs.CUSTOMER_attend.ToArray();
            }
            return customers;
        }

        public static RECOMMENDATION[] GetAllRecommendations()
        {
            RECOMMENDATION[] reco = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                reco = ctx.RECOMMENDATIONs.ToArray();
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

        public static bool AddCourseToRecommendation(COURSE course, RECOMMENDATION reco)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var rc = ctx.RECOMMENDATIONs.Include("COURSEs").Where(r => r.ID == reco.ID).FirstOrDefault();
                    rc.COURSEs.Add(course);
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

        #endregion

        #region 删除方法
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