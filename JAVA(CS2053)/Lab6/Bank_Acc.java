class BankAccount {
    private int balance = 1000;
  
    public synchronized void withdraw(int amount) {
        if (balance >= amount) {
            System.out.println(Thread.currentThread().getName() + " is withdrawing " + amount);
            balance -= amount;
            System.out.println("Remaining balance: " + balance);
        } else {
            System.out.println("Insufficient funds for " + Thread.currentThread().getName());
        }
    }
}

public class BankAccountTest {
    public static void main(String[] args) {
        BankAccount account = new BankAccount();

        Thread person1 = new Thread(() -> account.withdraw(700), "Person 1");
        Thread person2 = new Thread(() -> account.withdraw(500), "Person 2");

        person1.start();
        person2.start();
    }
}
