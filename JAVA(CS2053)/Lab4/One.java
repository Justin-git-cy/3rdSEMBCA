public class One {
    public static void main(String[] args) {
        C one = new C();
        
    }
    
}
class A{
    String name;
    A(){
     this.name = "I am A";
     System.out.println(name);
    }
}
class B extends A{
    B(){
        this.name = "I am B";
        System.out.println(name);
    }
}
class C extends B{
    C(){
        this.name = "I am c";
        System.out.println(name);
    }
}
