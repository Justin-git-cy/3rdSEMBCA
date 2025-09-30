class MessageSender {
    public synchronized void sendMessage(String msg) {
        for (char c : msg.toCharArray()) {
            System.out.print(c);
            try {
                Thread.sleep(50); 
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        System.out.println();
    }
}

public class MessageSenderTest {
    public static void main(String[] args) {
        MessageSender sender = new MessageSender();

        Thread sender1 = new Thread(() -> sender.sendMessage("Hello from thread 1!"), "Sender 1");
        Thread sender2 = new Thread(() -> sender.sendMessage("Hello from thread 2!"), "Sender 2");

        sender1.start();
        sender2.start();
    }
}
