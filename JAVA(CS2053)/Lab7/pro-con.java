class SharedBuffer {
    private int data;
    private boolean empty = true;

    public synchronized void produce(int value) {
        while (!empty) try { wait(); } catch (InterruptedException e) {}
        data = value;
        empty = false;
        System.out.println("Produced: " + value);
        notify();
    }

    public synchronized int consume() {
        while (empty) try { wait(); } catch (InterruptedException e) {}
        empty = true;
        System.out.println("Consumed: " + data);
        notify();
        return data;
    }
}

public class ProducerConsumer {
    public static void main(String[] args) {
        SharedBuffer buffer = new SharedBuffer();

        Thread producer = new Thread(() -> {
            for (int i = 1; i <= 5; i++) {
                buffer.produce(i);
                try { Thread.sleep(500); } catch (InterruptedException e) {}
            }
        });

        Thread consumer = new Thread(() -> {
            for (int i = 1; i <= 5; i++) {
                buffer.consume();
                try { Thread.sleep(800); } catch (InterruptedException e) {}
            }
        });

        producer.start();
        consumer.start();
    }
}
