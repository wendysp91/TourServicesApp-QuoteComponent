public class QuoteController {
    private final SObject parent;
    public String codigo{get;set;}
    public Product2 prod{get;set;}
    public Inventario__c inv{get;set;}
    public PriceBookEntry pbe{get;set;}
    public Double cantDisp{get;set;}
    public Double cantApart{get;set;}
    

    public QuoteController(Apexpages.StandardController controller) {
        parent = controller.getRecord();
    }
    public void buscar(){
        QuotationHelper qh = new QuotationHelper();
        prod = qh.searchProductByCode(codigo);
        cantDisp = qh.searchCantDisponibleByCode(codigo);
        cantApart = qh.searchCantApartadaByCode(codigo);
        
        String query = 'SELECT Cantidad_apart__c,Cantidad_dis__c, Product__r.Name, Product__r.ProductCode,Product__r.ExternalId  FROM Inventario__c WHERE Product__r.ProductCode =: codigo';
        inv = Database.query(query);
        String pbeQuery = 'SELECT UnitPrice FROM PriceBookEntry WHERE Product2.ProductCode =: codigo LIMIT 1';
        pbe = Database.query(pbeQuery);
    }
    public void guardar(){
        
    }
    public void atras(){
        prod.clear();
    }
}