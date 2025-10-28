import java.io.*;
import java.net.*;

//SERVER SIDE
public class Lab5_Server {
    public static void main(String[] args) throws Exception {
        ServerSocket ss = new ServerSocket(5000);
        System.out.println("Waiting for client...");
        Socket s = ss.accept();
        System.out.println("Client connected!");

        BufferedReader in = new BufferedReader(new InputStreamReader(s.getInputStream()));
        String msg;
        while ((msg = in.readLine()) != null)
            System.out.println("Client: " + msg);

        s.close();
        ss.close();
    }
}

//CLIENT SIDE
import java.io.*;
import java.net.*;
import java.util.Scanner;

public class Lab5_Client {
    public static void main(String[] args) throws Exception {
        Socket s = new Socket("localhost", 5000);
        PrintWriter out = new PrintWriter(s.getOutputStream(), true);
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.print("You: ");
            out.println(sc.nextLine());
        }
    }
}
