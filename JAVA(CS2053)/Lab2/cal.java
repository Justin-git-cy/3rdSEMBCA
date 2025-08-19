class Calculator {
      int add(int a, int b) {
        return a+b;
      }

      int subtract(int a, int b) {
        return a-b;
      }

      public static void main(String[] arg) {
        Calculator calc = new Calculator();
        system.out.println("Addition: " + calc.add(10,5));
        system.out.println("Subtraction: " + calc.subtract(10,5));
      }
}  
