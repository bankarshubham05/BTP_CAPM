const myFun = function(srv) {
    srv.on('hello', (req, res)=>{
        return "Hey" +req.data.msg;

    })
}

module.exports = myFun;