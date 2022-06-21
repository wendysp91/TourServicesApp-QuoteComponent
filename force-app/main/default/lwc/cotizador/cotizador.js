import { LightningElement,track } from 'lwc';
import buscar from '@salesforce/apex/QuoteController.buscar';

export default class Cotizador extends LightningElement {
    searchKey;
    @track inventory;
    //This Funcation will get the value from Text Input.
    handelSearchKey(event){
        this.searchKey = event.target.value;
    }

 //This funcation will fetch the Account Name on basis of searchkey
    SearchInventoryHandler(){
        //call Apex method.
        buscar({textkey: this.searchKey})
        .then(result => {
                let newV =JSON.parse(JSON.stringify(result));;
                this.testFun(newV);
                this.inventory = newV;
        })
        .catch( error=>{
            this.inventory = null;
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
        { label: 'Nombre del inventario', fieldName: 'Name', type: 'text' },
        { label: 'Cantidad disponible', fieldName: 'Cantidad_dis__c', type: 'number' },
        { label: 'Cantidad apartada', fieldName: 'Cantidad_apart__c', type: 'number' },
        { label: 'Nombre del Producto', fieldName: 'Product__r_Name', type: 'text' },
        { label: 'Codigo del producto', fieldName: 'Product__r_ProductCode', type: 'text' }
    ];

}