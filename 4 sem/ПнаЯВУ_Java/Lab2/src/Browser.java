public class Browser extends Programm{
    public Browser(String strAutor, String strName, String strWay,String strDate)
    {
        this.setAutor(strAutor);
        this.setName(strName);
        this.setWay(strWay);
        this.setDate(strDate);
    }
    public void open_page(){
        System.out.println("Файл скачан\n");
    }
}
