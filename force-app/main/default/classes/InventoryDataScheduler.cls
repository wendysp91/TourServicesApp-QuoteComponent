public class InventoryDataScheduler{
    //@future(callout=true)
    public static void ExternalLegacyConnection() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://64bjp0q5wg.execute-api.us-east-2.amazonaws.com/Implement/');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Inventory> inventories = new List<Inventory>();
        inventories = InventarioResponse.parse(response.getBody()).body.Inventory;
        system.debug(inventories.get(0));
        List<Inventario__c> inventarios = new List<Inventario__c>();
        for(Inventory item : inventories){
            Inventario__c inv = new Inventario__c();
            inv.Name = item.name;
            inv.Codigo_Prod__c = item.ProductID;
            inv.Cantidad_dis__c = item.Quan;
            inv.Cantidad_apart__c = item.BlockedQuan;
            inventarios.add(inv);

        }
        insert inventarios;
        }
        
    }