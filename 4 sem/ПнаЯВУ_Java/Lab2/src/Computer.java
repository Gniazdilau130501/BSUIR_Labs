
import java.util.ArrayList;
public class Computer {
    private String name = "Acer";
    private ArrayList<Browser> browsers = new ArrayList<>();
    private ArrayList<Player> players = new ArrayList<>();
    private ArrayList<VideoFile> videos = new ArrayList<>();
    public void addApp (int i, String Appautor, String Appname, String FileWay,String FileDate,String UseFormat) {
        if (i==1) {
            browsers.add(new Browser(Appautor, Appname,FileWay,FileDate));
        } else if (i==2) {
            players.add(new Player(Appautor, Appname,FileWay,FileDate,UseFormat));
        }else{
            System.out.println("Ошибка, невозможное число");
        }
    }
    public int delApp(int i,int t) {
            if (i==1) {
                if (browsers.size() == 0) {
                    return 0;
                }
                browsers.remove(t - 1);
            }else if (i == 2){
                if(players.size() == 0) {
                    return 0;
                }
                players.remove(t - 1);
             }else {
            return 0;
            }
        return 1;
    }
    public int download(int h,String AppWay,String AppDate,int AppTime,String AppFormat)
    {
        if(browsers.size()==0)
        {
          return 0;
        }
            browsers.get(h-1).open_page();
            videos.add(new VideoFile(AppWay,AppDate,AppTime,AppFormat));
            return 1;
        }


    public int use(int h,int t) {
        if (players.size() == 0||videos.size() ==0) {
           return 0;
        }
        if(videos.get(t-1).getFormat().equals( players.get(h-1).getUseFormat())){
            players.get(h-1).play_film(videos.get(t-1).getWay());
            return 1;
        }

        return 0;
    }


    public void see()
    {
        System.out.println("Браузеры\n--------");
        if(browsers.size()==0)
            System.out.println("Коллекция пуста\n");
        for(int t=0;t<browsers.size();t++) {
            System.out.println(t+1 +")"+ browsers.get(t).getName() + " " + browsers.get(t).getAutor()+ " "+browsers.get(t).getWay()+ " "+browsers.get(t).getDate());
        }
        System.out.println("______________________________");
        System.out.println("Плееры\n--------");
        if(players.size()==0)
            System.out.println("Коллекция пуста\n");
        for(int t=0;t<players.size();t++) {
            System.out.println(t+1 +")" + players.get(t).getName() + " " + players.get(t).getAutor()+ " " + players.get(t).getWay()+ " " + players.get(t).getDate());
        }
        System.out.println("______________________________");
        System.out.println("Файлы\n--------");
        if(videos.size()==0)
            System.out.println("Коллекция пуста\n");
        for(int t=0;t<videos.size();t++) {
            System.out.println(t+1 +")" + videos.get(t).getFormat() + " " + videos.get(t).getTime()+ " " + videos.get(t).getWay()+ " " + videos.get(t).getDate());
        }
        System.out.println("______________________________");
    }
}

