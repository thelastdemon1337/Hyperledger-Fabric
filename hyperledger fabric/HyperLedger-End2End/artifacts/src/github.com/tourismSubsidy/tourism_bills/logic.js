// Title    : Chaincode to collect bill Data using fabric-contract-api & shim-api
// Platform : Hyperledger Fabric 2.0
// Author   : Tarun Kotagiri
// Email    : tarun@metalok.io


'use strict';

const { Contract } = require('fabric-contract-api');

class BillDataContract extends Contract {

    async submitBill(ctx, billId, billData) {
        const billKey = ctx.stub.createCompositeKey('bill', [billId]);
        await ctx.stub.putState(billKey, Buffer.from(JSON.stringify(billData)));
        console.log(`Successfully stored Bill data : ${billData}`);
    }

    async getBill(ctx, billId) {
        const billKey = ctx.stub.createCompositeKey('bill', [billId]);
        const billData = await ctx.stub.getState(billKey);
        if (!billData || billData.length === 0) {
            throw new Error(`Bill with ID ${billId} does not exist`);
        }
        return JSON.parse(billData.toString());
    }

}

module.exports = BillDataContract;