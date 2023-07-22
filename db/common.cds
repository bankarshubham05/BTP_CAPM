namespace shubham.common;
using {  sap, Currency , managed, temporal } from '@sap/cds/common';


type AmountT : Decimal(15, 2)@(
    semantics.amount.CurrencyCode  : 'CURRENCY_CODE',
    sap.unit : 'CURRENCY_CODE'
);


  aspect Amount {
         CURRENCY_CODE : String(4);
            GROSS_AMOUNT : AmountT;
            NET_AMOUNT : AmountT ;
            TAX_AMOUNT : AmountT ;
};