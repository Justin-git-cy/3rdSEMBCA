package Lab_3;

public class method {

    public int add(int a, int b) {
        return a + b;
    }

    public int add(int a, int b, int c) {
        return a + b + c;
    }

    public double add(double a, double b) {
        return a + b;
    }

    public double add(int a, double b) {
        return a + b;
    }

    public static void main(String[] args) {
        method example = new method();

        System.out.println("Sum of two integers: " + example.add(10, 20));
        System.out.println("Sum of three integers: " + example.add(10, 20, 30));
        System.out.println("Sum of two doubles: " + example.add(10.5, 20.5));
        System.out.println("Sum of an integer and a double: " + example.add(10, 20.5));
    }
}
