const cds = require("@sap/cds")
const { product } = cds.entities("shubham.db.master")

const myFun = function (srv) {
    srv.on('hello', (req, res) => {
        return "Hey" + req.data.msg;

    });

    srv.on("READ", "ReadProductSet", async (req, res) => {

        var result = [];
        // result.push({
        //     "NODE_KEY":"74867AD200E41EDBA5D8B06B26EB4052",
        //     "DESCRIPTION" :"Hello"
        // })


        // CDS query language
        // result = await cds.tx(req).run(SELECT.from(product).limit(3));

        // cDS query to read single record with where

        // result = await cds.tx(req).run(SELECT.from(product).where({"NODE_KEY":"74867AD200E41EDBA5D8B06B26EB4052"}));

        //CDS query fro if user pass key like/entity/key

        var whereCondition = req.data;
        console.log(whereCondition)
        if (whereCondition.hasOwnProperty("NODE_KEY")) {
            result = await cds.tx(req).run(SELECT.from(product).where(whereCondition));
        }
        else {
            result = await cds.tx(req).run(SELECT.from(product).limit(1));
        }


        return result;
    });

    function randomString(length, chars) {
        var result = '';
        for (var i = length; i > 0; --i) result += chars[Math.floor(Math.random() * chars.length)];
        return result;
    };


    // srv.on("CREATE", "InsertProductSet" , async(req, res) =>{

    //     // for (let index = 0; index < req.data.length; index++) {
    //     //     const element = req.data[index];
    //     //     var dataSet = [];
    //     //     var rString = randomString(32, '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
    //     //     element.NODE_KEY = rString.toUpperCase();
    //     //     dataSet.push(element);

    //     // }
    //     console.log(req.data)   ;
    //     console.log(dataSet);
    //     let returnData = await cds.transaction(req).run([

    //             INSERT.into(product).entries([req.data])
    //         ]).then((resolve, reject) => {
    //             if(typeof(resolve !== undefined)){
    //                 return req.data;
    //             }
    //             else{
    //                 req.error(500 ,"there is an issue with insert");
    //             }
    //         }).catch(err => {
    //             req.error(500,'There was an issue in insert' + err.toString());
    //         });
    // });


    srv.on("UPDATE", "UpdateProductSet", async (req, res) => {
        console.log(req.data);
        var returnData = await cds.transaction(req).run([

            UPDATE(product).set({
                DESCRIPTION: req.data.DESCRIPTION
            }).where({ NODE_KEY: req.data.NODE_KEY }),

            UPDATE(product).set({
                DESCRIPTION: req.data.DESCRIPTION
            }).where({ NODE_KEY: req.data.NODE_KEY })

        ]).then((resolve, reject) => {
            if (typeof (resolve) !== undefined) {
                return req.data;
            }
            else {
                req.error(500, "there was issue with Updat");
            }
        }).catch(err => {
            req.error(500, "there was issue with Updat" + err.toSring());
        });
        return returnData;
    });

}

module.exports = myFun;