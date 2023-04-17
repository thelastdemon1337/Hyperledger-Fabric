// Title    : Chaincode to collect Form Data using fabric-contract-api & shim-api
// Platform : Hyperledger Fabric 2.0
// Author   : Tarun Kotagiri
// Email    : tarun@metalok.io


'use strict';

const { Contract } = require('fabric-contract-api');

class FormDataContract extends Contract {

    async submitForm(ctx, formId, formData) {
        const formKey = ctx.stub.createCompositeKey('form', [formId]);
        await ctx.stub.putState(formKey, Buffer.from(JSON.stringify(formData)));
        console.log(`Successfully stored form data : ${formData}`);
    }

    async getForm(ctx, formId) {
        const formKey = ctx.stub.createCompositeKey('form', [formId]);
        const formData = await ctx.stub.getState(formKey);
        if (!formData || formData.length === 0) {
            throw new Error(`Form with ID ${formId} does not exist`);
        }
        return JSON.parse(formData.toString());
    }

}

module.exports = FormDataContract;