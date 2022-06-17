global class myWebService {
webservice static Id makeAccount(String Description, String Name, String AccountNumber, String Website )
{
        Account c = new Account();
        c.Description = Description;
        c.Name = Name;
        c.AccountNumber = AccountNumber;
        c.Website = Website;
        insert c;
        return c.id;
    }
}