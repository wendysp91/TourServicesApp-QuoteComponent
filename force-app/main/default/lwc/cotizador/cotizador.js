import { LightningElement,track } from 'lwc';
/*import { reduceErrors } from 'c/ldsUtils';
import search from '@salesforce/apex/QuoteController.search';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';*/

export default class Cotizador extends LightningElement {
  /*  searchKey;
    @track inventory;
    errors;
    draftValues;
    _datatableresp;

    //This Funcation will get the value from Code Input.
    handelSearchKey(event){
        this.searchKey = event.target.value;
    }

    //This function will fetch the Inventory on basis of searchkey
    SearchInventoryHandler(){
        //call Apex method.
        search(
            {textkey: this.searchKey} )
        .then(result => {
                let newV =JSON.parse(JSON.stringify(result));;
                this.testFun(newV);
                this.inventory = newV;
        })
        .catch( error=>{
           // this.inventory = null;
           this.errors = reduceErrors(error); // code to execute if the promise is rejected
            
        });

    };

    testFun(list){
       list.forEach(row => {
            for (const col in row) {
              const curCol = row[col];
              if (typeof curCol === 'object') {
                const newVal = curCol.Id ? ('/' + curCol.Id) : null;
                // let newRow = Object.assign({},row);
                this.flattenStructure(row, col + '_', curCol);
                // list[row] = newRow;
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

    cols = [
        { label: 'Nombre del Producto', fieldName: 'Product__r_Name', type: 'text' },
        { label: 'Codigo del producto', fieldName: 'Product__r_ProductCode', type: 'text' },
        { label: 'Cantidad a cotizar', type: 'number', editable: "true", fieldName: 'Cantidad_apart__c' },
        { label: 'Cantidad disponible', fieldName: 'Cantidad_dis__c', type: 'number' },
        { label: 'Nombre del inventario', fieldName: 'Name', type: 'text' }
        
    ];

    //This function will save the QLI 
    handleSave(event){
        this.draftValues = event.detail.draftValues;
        alert('draf '+JSON.stringify(this.draftValues))
         save({qli: this.draftValues, textkey: this.searchKey})
         .then( result => {
            console.log( JSON.stringify( "Apex update result: " + result ) )
            if(result === true){
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success!!',
                        message: 'successfully QLI has been updated',
                        variant: 'success'
                    })

                );
                this.draftValues = []
                return refreshApex(this._datatableresp);
            } else {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error!!',
                        message: 'something went wrong please try again',
                        variant: 'error'
                    })
                );
            }

         })
    }*/
}