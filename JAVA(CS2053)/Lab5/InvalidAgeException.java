package bca;
import java.util.Scanner;

class InvalidAgeException extends Exception {
       public InvalidAgeException(String message) {

           super(message);
       }
    }
   public class SimpleCustomException {
      public static void main(String[] args) {
      Scanner sc = new Scanner(System.in);
          System.out.print("Enter student age: ");
          int age = sc.nextInt();
     try {

           if (age < 5 || age > 18) {
               throw new InvalidAgeException("Age must be between 5 and 18!");
               }
                System.out.println("Valid age: " + age);
                      } catch (InvalidAgeException e) {
                            System.out.println(&quot;Error: &quot; + e.getMessage());
               }
                System.out.println("Program continues...");
                sc.close();
          }
     }
