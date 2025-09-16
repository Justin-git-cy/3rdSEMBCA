package bca;
import java.util.Scanner;
public class OverloadAdd {
   public static void main(String[] args) {
	   Scanner sc= new Scanner(System.in);
	   
	   System.out.print("Enter Numerator:");
	   int numerator=sc.nextInt();
	   
	   System.out.print("Enter Denominator:");
			   int denominator=sc.nextInt();
			   
	   try {
		    int result=numerator/denominator;
		    System.out.println("Result:" +result);
	   }catch(ArithmeticException e) {
		   System.out.println("Error : Cannot divide by zero!");
	   }
	   System.out.println("Program Continues....");
	   sc.close();
	   
	   
   }
}
