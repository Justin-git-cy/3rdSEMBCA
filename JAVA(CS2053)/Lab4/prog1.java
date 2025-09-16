class a
{
	a()
	{
		System.out.println("Hi im in class A");
	}

	
}
class b extends a
{
    b()
    {
    	System.out.println("Hi im in class B");
    }
}
class c extends b
{
	c()
	{
		System.out.println("Hi im in class c");
	}
}
public class Lab4{
	public static void main(String[]args)
	{
		c ob=new c();
	}
}
