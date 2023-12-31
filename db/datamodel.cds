namespace shubham.db;

using {shubham.common.Amount} from './common';
using {
    cuid,
    temporal
} from '@sap/cds/common';


type Guid : String(64);

context master {
    entity businesspartner {
        key NODE_KEY      : Guid;
            BP_ROLE       : String(2);
            EMAIL_ADDRESS : String(64);
            PHONE_NUMBER  : String(14);
            FAX_NUMBER    : String(14);
            WEB_ADDRESS   : String(64);
            ADDRESS_GUID  : Association to address;
            BP_ID         : String(16);
            COMPANY_NAME  : String(84);
    }

    annotate businesspartner with {
        NODE_KEY @title: '{i18n>bp_key}';
        BP_ROLE  @title: '{i18n>bp_role}';
        COMPANY_NAME @title : '{i18n>company_name}';
        BP_ID @title : '{i18n>bp_Id}';
        EMAIL_ADDRESS @title : '{i18n>email_addr}';
    };



    entity address {
        key NODE_KEY        : Guid;
            CITY            : String(64);
            POSTAL_CODE     : String(64);
            STREET          : String(64);
            BUILDING        : String(64);
            COUNTRY         : String(64);
            ADDRESS_TYPE    : String(64);
            VAL_START_DATE  : Date;
            VAL_END_DATE    : Date;
            LATITUDE        : Decimal;
            LONGITUDE       : Decimal;
            businesspartner : Association to businesspartner
                                  on businesspartner.ADDRESS_GUID = $self;


    }

    // entity prodtext {

    //     key NODE_KEY : Guid;
    //     PARENT_KEY : Guid;
    //     LANGUAGE : String(2);
    //     TEXT : String(256);

    // }

    entity product {
        key NODE_KEY       : Guid;
            PRODUCT_ID     : String(28);
            TYPE_CODE      : String(2);
            CATEGORY       : String(32);
            DESCRIPTION    : localized String(255);
            SUPPLIER_GUID  : Association to master.businesspartner;
            TAX_TARIF_CODE : Integer;
            MEASURE_UNIT   : String(2);
            WEIGHT_MEASURE : Decimal(5, 2);
            WEIGHT_UNIT    : String(2);
            CURRENCY_CODE  : String(4);
            PRICE          : Decimal(15, 2);
            WIDTH          : Decimal(5, 2);
            DEPTH          : Decimal(5, 2);
            HEIGHT         : Decimal(5, 2);
            DIM_UNIT       : String(2);

    }


}

context transaction {

    entity purchaseorder : Amount {

        key ID               : Guid;
            PO_ID            : String(24);
            PARTNER_GUID     : Association to master.businesspartner;
            LIFECYCLE_STATUS : String(1);
            OVERALL_STATUS   : String(2);
            Items : Association to many poitems on Items.PARENT_KEY = $self;


    }

    entity poitems : Amount {
        key ID           : Guid;
            PARENT_KEY   : Association to transaction.purchaseorder;
            PO_ITEM_POS  : Integer;
            PRODUCT_GUID : Association to master.product;


    }

}
