module.exports = cds.service.impl(async function() {

    const {
        AddressSet

    } = this.entities;

    this.before('UPDATE', AddressSet, (req, res)=>{

        if (req.data.CITY === 'Pune') {
            req.error(500 ,'City Mismatch');
        }

    })
    
});