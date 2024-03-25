import java.util.Scanner;

public class Scanstr {
    private String str=null;
    Scanner scanner = new Scanner(System.in);
   public String scanStr() {
        str = scanner.nextLine();
        return str;
    }
}
