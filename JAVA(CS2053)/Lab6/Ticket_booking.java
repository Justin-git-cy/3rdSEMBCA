class TicketBookingSystem {
    private int tickets = 5;

    public synchronized void bookTicket() {
        if (tickets > 0) {
            System.out.println(Thread.currentThread().getName() + " booked a ticket.");
            tickets--;
            System.out.println("Tickets remaining: " + tickets);
        } else {
            System.out.println("No tickets available for " + Thread.currentThread().getName());
        }
    }
}

public class TicketBookingTest {
    public static void main(String[] args) {
        TicketBookingSystem bookingSystem = new TicketBookingSystem();

        Thread user1 = new Thread(() -> bookingSystem.bookTicket(), "User 1");
        Thread user2 = new Thread(() -> bookingSystem.bookTicket(), "User 2");
        Thread user3 = new Thread(() -> bookingSystem.bookTicket(), "User 3");
        Thread user4 = new Thread(() -> bookingSystem.bookTicket(), "User 4");
        Thread user5 = new Thread(() -> bookingSystem.bookTicket(), "User 5");
        Thread user6 = new Thread(() -> bookingSystem.bookTicket(), "User 6");

        user1.start();
        user2.start();
        user3.start();
        user4.start();
        user5.start();
        user6.start();
    }
}
