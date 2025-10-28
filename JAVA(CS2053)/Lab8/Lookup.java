import java.io.*;
import java.net.*;

public class Lab4_Whois {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Enter domain: ");
        String domain = br.readLine();

        Socket s = new Socket("whois.internic.net", 43);
        OutputStream out = s.getOutputStream();
        out.write((domain + "\r\n").getBytes());
        out.flush();

        BufferedReader in = new BufferedReader(new InputStreamReader(s.getInputStream()));
        String line;
        while ((line = in.readLine()) != null)
            System.out.println(line);

        s.close();
    }
}
