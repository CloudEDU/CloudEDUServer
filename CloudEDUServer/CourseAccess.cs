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
        #endregion

    }
}