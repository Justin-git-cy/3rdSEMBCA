public class WrapperDemo {
    public static void main(String[] args) {
       
        int a = 100;
        Integer boxedA = a; 
        System.out.println("Autoboxed Integer: " + boxedA);


        Integer b = new Integer(200);
        int unboxedB = b;
        System.out.println("Auto-unboxed int: " + unboxedB);

        Integer sum = boxedA + b; 
        System.out.println("Sum (autoboxed + wrapper): " + sum);

        printDouble(b);  
    }

    public static void printDouble(int value) {
        System.out.println("Double of value: " + (value * 2));
    }
}
