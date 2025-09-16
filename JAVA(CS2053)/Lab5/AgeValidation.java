package bca;

class UnderAgeException extends Exception {
    public UnderAgeException(String message) {
        super(message);
    }
}

import java.util.Scanner;

public class AgeValidation {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
       
        System.out.print("Enter your age: ");
        int age = scanner.nextInt();
        
        try {
           
            if (age < 18) {
                throw new UnderAgeException("You must be at least 18 years old!");
            }
            System.out.println("Valid age: " + age);
        } catch (UnderAgeException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
