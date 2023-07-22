namespace shubham.db;

using {
    shubham.db.master,
    shubham.db.transaction
} from './datamodel';

context CDSViews {

    define view![POworklist] as
        select from transaction.purchaseorder {
            key PO_ID                             as![PurchaseOrderId],
                PARTNER_GUID.BP_ID                as![PartnerID],
                PARTNER_GUID.COMPANY_NAME         as![CompanyName],
                GROSS_AMOUNT                      as![POGrossAmount],
                CURRENCY_CODE                     as![POCurrencyCode],
                LIFECYCLE_STATUS                  as![POstatu],
            key Items.PO_ITEM_POS                 as![ItemsPosition],
                Items.PRODUCT_GUID.PRODUCT_ID     as![ProductId],
                Items.PRODUCT_GUID.DESCRIPTION    as![ProcName],
                PARTNER_GUID.ADDRESS_GUID.CITY    as![City],
                PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country],
                Items.GROSS_AMOUNT                as![GrossAmount],
                Items.NET_AMOUNT                  as![NetAmount],
                Items.TAX_AMOUNT                  as![TaxAmount],
                Items.CURRENCY_CODE               as![CurrencyCode],


        };

    define view![ItemsView] as
        select from transaction.poitems {
            PARENT_KEY.PARTNER_GUID.NODE_KEY as![Partner],
            PRODUCT_GUID.NODE_KEY            as![ProductId],
            CURRENCY_CODE                    as![CurrencyCode],
            GROSS_AMOUNT                     as![GrossAmount],
            TAX_AMOUNT                       as![TaxAmount],
            NET_AMOUNT                       as![NetAmount],
            PARENT_KEY.OVERALL_STATUS        as![PoStatus]

        };

    define view ProductViewSum as
        select from master.product as Prod {
            PRODUCT_ID as ![ProductId],
            
            (
                select from transaction.poitems as a {
                    SUM(
                        a.GROSS_AMOUNT
                    ) as SUM
                }
                where
                    Prod.NODE_KEY = a.PRODUCT_GUID.NODE_KEY

            ) as POSum: Decimal(10, 2)
        };


    define view ProductView as
        select from master.product
        mixin {
            PO_ORDER : Association[ * ] to ItemsView
                           on PO_ORDER.ProductId = $projection.ProductID
        }
        into {
            NODE_KEY                           as![ProductID],
            DESCRIPTION,
            CATEGORY                           as![Catogory],
            PRICE                              as![Price],
            TYPE_CODE                          as![TypeCode],
            SUPPLIER_GUID.BP_ID                as![BPId],
            SUPPLIER_GUID.COMPANY_NAME         as![CompanyName],
            SUPPLIER_GUID.ADDRESS_GUID.CITY    as![City],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
            //Exposed Association which means someone red the view
            // the data for Orders wont be read by default
            // untill uneless someoene consume the association

            PO_ORDER
        };


    define view CProductValuesVies as
        select from ProductView {
            ProductID,
            Country,
            PO_ORDER.CurrencyCode,
            SUM(
                PO_ORDER.GrossAmount) as SUM :Decimal(10, 2)
        }  
        group by
            ProductID,
            Country,
            PO_ORDER.CurrencyCode ;

    define view ProductValueHelp as
        select from master.product {
            @EndUser.label: [{
                languae: 'EN',
                text   : 'Product ID'
            }, {
                languae: 'DE',
                text   : 'Prodect ID'
            }]
            PRODUCT_ID  as![ProductId],

            @EndUser.label: [{
                languae: 'EN',
                text   : 'Product Description'
            }, {
                languae: 'DE',
                text   : 'Prodect Description'
            }]
            DESCRIPTION as![Description],

        };


}
