import java.net.*;
import java.io.*;

public class Lab6_WebsiteInfo {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Enter URL: ");
        String urlStr = br.readLine();

        URL url = new URL(urlStr);
        URLConnection conn = url.openConnection();

        System.out.println("Protocol: " + url.getProtocol());
        System.out.println("Content Type: " + conn.getContentType());
        System.out.println("Content Length: " + conn.getContentLength());

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        System.out.println("\nFirst few lines:");
        for (int i = 0; i < 3; i++) {
            String line = in.readLine();
            if (line == null) break;
            System.out.println(line);
        }
        in.close();
    }
}
