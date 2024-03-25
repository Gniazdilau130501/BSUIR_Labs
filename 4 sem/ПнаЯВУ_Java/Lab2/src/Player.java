public class Player extends Programm {
    public String getUseFormat() {
        return UseFormat;
    }

    public void setUseFormat(String useFormat) {
        UseFormat = useFormat;
    }

    private String UseFormat;
    public Player(String strAutor,String strName, String strWay,String strDate,String strFormat)
    {
        this.setAutor(strAutor);
        this.setName(strName);
        this.setWay(strWay);
        this.setDate(strDate);
        this.setUseFormat(strFormat);
    }
    public void play_film(String way){
        System.out.println("Видео - "+way);
    };
}
