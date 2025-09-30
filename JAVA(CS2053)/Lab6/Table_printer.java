class TablePrinter {
    private int number;

    public TablePrinter(int number) {
        this.number = number;
    }

    public synchronized void printTable() {
        for (int i = 1; i <= 10; i++) {
            System.out.println(Thread.currentThread().getName() + " prints: " + number + " x " + i + " = " + (number * i));
            try {
                Thread.sleep(100); 
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

public class TablePrinterTest {
    public static void main(String[] args) {
        TablePrinter printer = new TablePrinter(5);

        Thread t1 = new Thread(() -> printer.printTable(), "Thread 1");
        Thread t2 = new Thread(() -> printer.printTable(), "Thread 2");

        t1.start();
        t2.start();
    }
}
