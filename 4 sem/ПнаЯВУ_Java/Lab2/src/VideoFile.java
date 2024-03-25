public class VideoFile extends AbstractFile{
    private int time;
    private String format;
    public VideoFile(String AppWay,String AppDate,int AppTime,String AppFormat){
        this.setWay(AppWay);
        this.setDate(AppDate);
        this.setTime(AppTime);
        this.setFormat(AppFormat);
    }
    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }
}
