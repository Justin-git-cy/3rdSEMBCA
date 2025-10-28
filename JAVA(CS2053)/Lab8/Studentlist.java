import java.util.*;

public class Lab1_StudentList {
    public static void main(String[] args) {
        ArrayList<String> students = new ArrayList<>();
        Scanner sc = new Scanner(System.in);

        students.add("Alice");
        students.add("Bob");
        students.add("Charlie");
        System.out.println("Initial list: " + students);

        students.add("David");

        students.add(1, "Eve");

        students.set(0, "Alicia");

        students.remove("Bob");

        students.remove(2);

        System.out.println("Final list: " + students);
    }
}
