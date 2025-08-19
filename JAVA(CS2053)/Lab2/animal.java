class Animal {
      void sound() {
        System.out.println("Animal makes a sound");
      }
}
class Dog extends Animal {
      void sound() {
        System.out.println("Dog barks");
      }
  public static void main (String[] arg) {
    Dog d = new Dog();
    d.sound(); //overridden method
  }
}  
