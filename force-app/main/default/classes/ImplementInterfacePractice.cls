public class ImplementInterfacePractice implements InterfacePractice{
   public void metodo1(){
        System.debug('Desde el Metodo1');
    }
   public String metodo2(){
        return 'Desde el Metodo2';
    }
   public void metodo3(String param){
        System.debug(param);
    }
}
