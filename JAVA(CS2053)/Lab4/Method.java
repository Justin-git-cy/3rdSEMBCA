public class method{
    public static void main(String[] args) {
    B one = new B();
    String first = one.add("akash","bisht");
    System.out.println(first);    
    }
}
class A{
    int add(int a,int b){
        return a+b;
    }
    double add(double a,double b){
        return a+b;
    }
}
class B extends A{
    String add(String a, String b){
        return a+b;
    }
}
