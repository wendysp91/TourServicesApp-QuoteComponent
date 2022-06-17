public with sharing class QuoterController {
    private final SObject parent;
    private String codigo{get;set;}
    private List<PricebookEntry> listInv {get;set;}

    public QuoterController(Apexpages.StandardController controller) {
        parent=controller.getRecord();
    }
    public void buscar(){
        QuotationHelper qh = new QuotationHelper();
        Product2 product = qh.searchProductByCode(codigo);
        listInv = Database.query(product);
    }
    public void guardar(){}
    public void cancelar(){
        listInv.clear();
    }
}
