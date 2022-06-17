public class InventarioViewController {
	private final sObject parent;
    public String codigo{get;set;}
    public List<Inventario__c> listInv {get;set;}
    
    public InventarioViewController(ApexPages.StandardController controller){
        parent = controller.getRecord();
    }
    public void buscar(){
        String query = 'Select Id, Codigo_Prod__c, Cantidad_dis__c, Cantidad_apart__c from Inventario__c where Codigo_Prod__c=:codigo';
        listInv = Database.query(query);  
    }
    public void limpiar(){
        listInv.clear();
    }
    
}