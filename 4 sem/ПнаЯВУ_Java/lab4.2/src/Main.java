import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

public class Main {
    private static List<Thread> threadList = new ArrayList<>();

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Запускаем отдельный поток для чтения пользовательского ввода
        Thread inputThread = new Thread(() -> {
            while (true) {
                System.out.println("Press '1' to add a thread or '0' to remove a thread: ");
                int input = scanner.nextInt();

                if (input == 1) {
                    if (threadList.size() < 5) {
                        Thread newThread = new Thread(Main::execute);
                        threadList.add(newThread);
                        newThread.start();
                        System.out.println("Thread added");
                    } else {
                        System.out.println("Error. You cannot add more than 5 threads");
                    }
                } else if (input == 0) {
                    if (!threadList.isEmpty()) {
                        final Random random = new Random();
                        Thread threadToRemove = threadList.get(random.nextInt(threadList.size()));
                        threadToRemove.interrupt();
                        threadList.remove(threadToRemove);
                    } else {
                        System.out.println("No threads available");
                    }
                }
            }
        });
        inputThread.start();

        // Ожидаем завершения потока чтения пользовательского ввода
        try {
            inputThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static void execute() {
        int id = threadList.size();
        while (true) {
            String message = "Working" + " " + id + " ";
            char[] chars = message.toCharArray();
            synchronized (threadList) {
                System.out.println();
                for (int i = 0; i < message.length(); i++) {
                    System.out.print(chars[i]);
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException e) {
                        System.out.println("Thread " + id + " has finished its work");
                        return;
                    }

                }
                try {
                    Thread.sleep(600);
                } catch (InterruptedException e) {
                    System.out.println("Thread " + id + " has finished its work");
                    return;
                }
            }
        }
    }
}