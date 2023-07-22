
using { shubham.db.master, shubham.db.transaction } from '../db/datamodel';

service data {

    function hello(msg : String) returns String;

    @readonly
    entity ReadProductSet as projection on master.product;
    @insertonly
    entity InsertProductSet as projection on master.product;
    @updateonly
    entity UpdateProductSet as projection on master.product;
    @deletonly
    entity DeleteProductSet as projection on master.product;

}







