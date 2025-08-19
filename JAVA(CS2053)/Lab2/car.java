package Car;

class Car {
      String brand;
      int year;
      
      //constructor
      Car(String b,int y) {
    	  brand =b;
    	  year =y;
    	  
      }
      
      void display() {
    	  System.out.println("Car: " + brand +" ("+ year+")");
      }
      
      public static void main(String[] arg)  {
    	  Car c1=new Car("Toyota",2020);
    	  Car c2=new Car("Honda", 2022);
    	  
    	  c1.display();
    	  c2.display();
      }
}
