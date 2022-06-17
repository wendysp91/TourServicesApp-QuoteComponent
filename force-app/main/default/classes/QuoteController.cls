public class QuoteController {
    private final SObject parent;
    public String codigo{get;set;}
    public Product2 prod{get;set;}
    public Inventario__c inv{get;set;}
    public PriceBookEntry pbe{get;set;}
    public Double cantDisp{get;set;}
    public Double cantApart{get;set;}
    public Double quantity{get;set;}
    public String quoteId;

    public QuoteController(Apexpages.StandardController controller) {
        parent = controller.getRecord();
    }
    public void buscar(){
        QuotationHelper qh = new QuotationHelper();
        Boolean existe = qh.confirmProductExistByCode(codigo);
        if(existe){
            String query = 'SELECT Cantidad_apart__c,Cantidad_dis__c, Product__r.Name, Product__r.ProductCode,Product__r.ExternalId  FROM Inventario__c WHERE Product__r.ProductCode =: codigo';
            inv = Database.query(query);
            String pbeQuery = 'SELECT UnitPrice FROM PriceBookEntry WHERE Product2.ProductCode =: codigo LIMIT 1';
            pbe = Database.query(pbeQuery);
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'El codigo no existe'));
        }  
    }
    public void guardar(){
        try{
            QuotationHelper qh = new QuotationHelper();
            prod = qh.searchProductByCode(codigo);
            cantApart = qh.searchCantApartadaByCode(codigo);
            pbe = [SELECT Id,UnitPrice FROM PriceBookEntry WHERE Product2.ProductCode =: codigo LIMIT 1];
            quoteId = ApexPages.currentPage().getParameters().get('id');
            QuoteLineItem newQli = new QuoteLineItem(Product2Id = prod.Id, 
                                                     QuoteId = quoteId, 
                                                     pricebookentryId = pbe.Id, 
                                                     Quantity = quantity, 
                                                     UnitPrice = pbe.UnitPrice);
            insert newQli;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Cotizacion creada exitosamente!'));
        }catch(DmlException ex){
            ex.getMessage();
        }
    }
    
    public void atras(){
        prod.clear();
        inv.clear();
        pbe.clear();
    }
}