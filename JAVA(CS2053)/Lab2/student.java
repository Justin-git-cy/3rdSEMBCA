package Student;

class Student{
	String name;
	int age;
		  
	void displayInfo() {
			System.out.println("Name: " + name + ",Age: " + age);
	}
	public static void main(String[] args) {
		Student s1 =new Student();
			s1.name= "John";
			s1.age= 20;
			s1.displayInfo();
	}
}
