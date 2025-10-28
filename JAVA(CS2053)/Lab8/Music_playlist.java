import java.util.*;

public class Lab2_MusicPlaylist {
    public static void main(String[] args) {
        LinkedList<String> playlist = new LinkedList<>();

        playlist.add("Song A");          
        playlist.addFirst("Song B");     
        playlist.addLast("Song C");

        System.out.println("Playlist: " + playlist);

        playlist.removeFirst();          
        playlist.removeLast();           

        playlist.set(0, "Song D");       
        System.out.println("Updated Playlist: " + playlist);
    }
}
