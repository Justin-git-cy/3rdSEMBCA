package bca;

class WeakPasswordException extends Exception {
    public WeakPasswordException(String message) {
        super(message);
    }
}

import java.util.Scanner;

public class PasswordStrengthCheck {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("Enter your password: ");
        String password = scanner.nextLine();
        
        try {
           
            if (password.length() < 6) {
                throw new WeakPasswordException("Password too short! Must be at least 6 characters.");
            }
            System.out.println("Password accepted.");
        } catch (WeakPasswordException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
