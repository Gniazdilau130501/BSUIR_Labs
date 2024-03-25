import java.util.InputMismatchException;
import java.util.Scanner;

public class Scanint {
    Scanner scanner = new Scanner(System.in);
    //    String str;
    int num;
    int flag = 1;

    public int scanInt() {

        try {
            num = scanner.nextInt();
            return num;
        } catch (InputMismatchException e) {
            System.out.println("Ошибка ввода!");
            return 0;
        }
    }

}
