import java.net.*;
import java.io.*;
import java.util.*;

public class Lab7_HTTPHeader {
    public static void main(String[] args) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        System.out.print("Enter URL: ");
        String urlStr = br.readLine();

        URL url = new URL(urlStr);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        System.out.println("Method: " + conn.getRequestMethod());
        System.out.println("Response: " + conn.getResponseCode() + " " + conn.getResponseMessage());

        System.out.println("\nHeaders:");
        Map<String, List<String>> headers = conn.getHeaderFields();
        for (String key : headers.keySet())
            System.out.println(key + ": " + headers.get(key));

        conn.disconnect();
    }
}
