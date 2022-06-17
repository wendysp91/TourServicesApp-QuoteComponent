public interface QuotationSync {
    
    Boolean confirmProductExistByCode(String prodCode);
    Product2 searchProductByCode(String prodCode);
}