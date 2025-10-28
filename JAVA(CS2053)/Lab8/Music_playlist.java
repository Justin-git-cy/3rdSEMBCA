import java.util.*;

public class Lab2_MusicPlaylist {
    public static void main(String[] args) {
        LinkedList<String> playlist = new LinkedList<>();

        playlist.add("Caroline Creature - Saint Avangeline");          
        playlist.addFirst("Sweet Carolina - Lana Del Rey");     
        playlist.addLast("Not quite you - Artemas");

        System.out.println("Playlist: " + playlist);

        playlist.removeFirst();          
        playlist.removeLast();           

        playlist.set(0, "Dracula - Tame Impala");       
        System.out.println("Updated Playlist: " + playlist);
    }
}
