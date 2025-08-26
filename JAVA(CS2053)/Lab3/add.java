package Lab_3;

public class add {
    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("Please provide two numbers as command line arguments.");
            return;
        }

        
            int num1 = Integer.parseDouble(args[0]);
            int num2 = Integer.parseDouble(args[1]);
        
            int sum = num1 + num2;

        system.out.println("The sum of " + num1 + " and " +num2 + "is: " +sum);
    }
}
