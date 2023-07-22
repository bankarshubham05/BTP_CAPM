
using {  shubham.db.master , shubham.db.transaction} from '../db/datamodel';


service CatalogService@(path:'/CatalogService'){

entity AddressSet as projection on master.address;
entity BussinessPartnerSet as projection on master.businesspartner;
entity ProductSet as projection on master.product;
//entity ProductTextSet as projection on master.prodtext;
    
entity POs as projection on transaction.purchaseorder {
    *,
    Items : redirected to POItems
}
 

 entity POItems as projection on transaction.poitems{
    *,
    PARENT_KEY : redirected to POs,
    PRODUCT_GUID : redirected to ProductSet
 }

}