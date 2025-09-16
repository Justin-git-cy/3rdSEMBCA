package bca;
import java.util.Scanner;

class InvalidMarksException extends Exception {
public InvalidMarksException(String message) {
super(message);
  }
}
public class CustomExceptionExample {
      public static void main(String[] args) {
      Scanner sc = new Scanner(System.in);
         System.out.print("Enter marks (0-100): ");
         int marks = sc.nextInt();
try {
     if (marks < 0 || marks > 100) {
     throw new InvalidMarksException(&quot;Marks should be between 0 and 100!&quot;);
     } else {
             System.out.println("Marks entered:" + marks);
            }
     } catch (InvalidMarksException e) {
     System.out.println("Error:"+ e.getMessage());
     }
     System.out.println("Program continues...");
     sc.close();
  }
}
