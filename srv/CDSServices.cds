using { shubham.db.CDSViews } from '../db/CDSViews';
using { shubham.db.master, shubham.db.transaction } from '../db/datamodel';


service CDSService@(path:'/CDSService'){

entity POworklist as projection on CDSViews.POworklist;
entity ProductOrders1  as projection on CDSViews.ProductViewSum;
entity ProductAggregation1 as projection on CDSViews.CProductValuesVies;

      

}
