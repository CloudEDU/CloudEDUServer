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
    }
}