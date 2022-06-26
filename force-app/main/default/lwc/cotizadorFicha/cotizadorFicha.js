import { LightningElement,wire, api } from 'lwc';
import { reduceErrors } from 'c/ldsUtils';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';

import searchPBE from '@salesforce/apex/QuotationHelper.searchPBE';
import search from '@salesforce/apex/QuoteController.search';
import searchProductByCode from '@salesforce/apex/QuotationHelper.searchProductByCode';
import save from '@salesforce/apex/QuoteController.save';
export default class CotizadorFicha extends LightningElement {
    code;
    inventory;
    priceBookEntry;
    product;
    quantity;
    @api recordId;

    handelSearchKeyCode(event){
        this.code = event.target.value;
    }

    handelSearchCode(){
        //call Apex method.
        search(
            {textkey: this.code} )
        .then(result => {
                let responseValue =JSON.parse(JSON.stringify(result));
                this.parseResponse(responseValue);
                if(responseValue.length > 0){
                    this.inventory = responseValue[0];
                }else{
                    this.inventory = null;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error!!',
                            message: 'Lo siento, el código del producto no se encuentra registrado',
                            variant: 'error'
                        })
                    );
                }
        })
        .catch( error=>{
           this.inventory = null;
           this.errors = reduceErrors(error); // code to execute if the promise is rejected
           
        });
        searchPBE({prodCode: this.code})
        .then(result => {
                let responseValue =JSON.parse(JSON.stringify(result));;
                // this.parseResponse(responseValue);
                if(responseValue.length > 0){
                    this.priceBookEntry = responseValue[0];
                }else{
                    this.priceBookEntry = null;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error!!',
                            message: 'Lo siento, el código del producto no se encuentra registrado',
                            variant: 'error'
                        })
                    );
                }
        })
        .catch( error=>{
            this.priceBookEntry = null;
            this.errors = reduceErrors(error); // code to execute if the promise is rejected
         });
         searchProductByCode({prodCode: this.code})
        .then(result => {
                let responseValue =JSON.parse(JSON.stringify(result));;
                // this.parseResponse(responseValue);
                if(responseValue != null){
                    this.product = responseValue;
                }else{
                    this.product = null;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error!!',
                            message: 'Lo siento, el código del producto no se encuentra registrado',
                            variant: 'error'
                        })
                    );
                }
        })
        .catch( error=>{
            this.product = null;
            this.errors = reduceErrors(error); // code to execute if the promise is rejected
         });
    };

    parseResponse(list){
        list.forEach(row => {
             for (const col in row) {
               const curCol = row[col];
               if (typeof curCol === 'object') {
                 const newVal = curCol.Id ? ('/' + curCol.Id) : null;
                 this.flattenStructure(row, col + '_', curCol);
                 if (newVal === null) {
                   delete row[col];
                 } else {
                   row[col] = newVal;
                 }
               }
             }
         });
    }

     flattenStructure(topObject, prefix, toBeFlattened) {
        for (const prop in toBeFlattened) {
          const curVal = toBeFlattened[prop];
          if (typeof curVal === 'object') {
            flattenStructure(topObject, prefix + prop + '_', curVal);
          } else {
            topObject[prefix + prop] = curVal;
          }
        }
    }

    handelQuantity(event){
        this.quantity = event.detail.value;    
    }
    saveHandler(){
        save({quantity: this.quantity, code: this.code, recordId: this.recordId})
        .then( result => {
            console.log( JSON.stringify( "Apex update result: " + result ) )
            if(result === true){
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Exito!!',
                        message: 'Se ha creado una cotización exitosamente!',
                        variant: 'success'
                    })
                ); 
                eval("$A.get('e.force:refreshView').fire();");
                this.cancelHndler();
            } else {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error!!',
                        message: 'No se pudo crear la cotizacion, revise que los datos sean correctos',
                        variant: 'error'
                    })
                );
            }
         })
        .catch( error=>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error!!',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
         
    }
    get allData(){
        return this.inventory != null && this.priceBookEntry != null && this.product != null;
    }
    get isInventoryReady(){
        return this.inventory != null;
    }

    get isPriceBookReady(){
        return this.priceBookEntry != null;
    }
    get isProductReady(){
        return this.product != null;
    }
    cancelHndler(){
        this.inventory = null;
        this.product = null;
        this.inventory = null;
        this.priceBookEntry = null;
        this.quantity = null;
        this.template.querySelectorAll('lightning-layout-item').forEach(element => {
              element.value = null;
          });
          this.template.querySelectorAll('lightning-input').forEach(element => {
            element.value = null;
        });
        this.template.querySelector('lightning-input[data-id="quant"]').value = null;
    }
}


   
