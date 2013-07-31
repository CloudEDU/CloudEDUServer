using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CloudEDUServer
{
    /// <summary>
    /// 用于查询订单信息，订单信息不允许更改
    /// </summary>
    public class TransactionAccess
    {
        public static SALEORDER[] GetAllSaleOrder()
        {
            SALEORDER[] orders = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                orders = ctx.SALEORDERs.ToArray<SALEORDER>();
            }
            return orders;
        }

        public static SALEORDER[] GetOrdersByBuyer(int customer_id)
        {
            SALEORDER[] orders = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                orders = ctx.SALEORDERs.Where(o => o.BUYER == customer_id).ToArray<SALEORDER>();
            }
            return orders;
        }

        public static SALEORDER[] GetOrdersBySaler(int customer_id)
        {
            SALEORDER[] orders = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                orders = ctx.SALEORDERs.Where(o => o.SALER == customer_id).ToArray<SALEORDER>();
            }
            return orders;
        }

        public static SALEORDER[] GetOrderByDateBetween(DateTime begin, DateTime end)
        {
            SALEORDER[] orders = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                orders = (from o in ctx.SALEORDERs
                          where o.TIME.CompareTo(begin) >= 0 && o.TIME.CompareTo(end) <= 0
                          select o).ToArray<SALEORDER>();
            }
            return orders;
        }

        public static string dateToString(string date)
        {
            string str = date.Substring(0, 4)+'-';
            date = date.Remove(0, 5);
            if (date[1] == '/')
            {
                str = str + '0' + date[0]+'-';
                date = date.Remove(0, 2);
            }
            else
            {
                str = str + date.Substring(0, 1)+'-';
                date = date.Remove(0, 3);
            }
            if (date.Length == 1)
            {
                str = str + '0' + date;
            }
            else
            {
                str = str + date;
            }
            return str;
        }
    }
}