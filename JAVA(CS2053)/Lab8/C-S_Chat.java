import java.io.*;
import java.net.*;

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
