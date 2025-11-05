CREATE DATABASE mus;
USE mus;

CREATE TABLE Artist(
  ArtistID INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(200)
);

CREATE TABLE Album(
  AlbumID INT PRIMARY KEY AUTO_INCREMENT,
  Title VARCHAR(200),
  ArtistID INT,
  ReleaseDate DATE,
  FOREIGN KEY (ArtistID) REFERENCES Artist(ArtistID)
);

CREATE TABLE Song(
  SongID INT PRIMARY KEY AUTO_INCREMENT,
  AlbumID INT,
  Title VARCHAR(200),
  DurationSec INT,
  FOREIGN KEY (AlbumID) REFERENCES Album(AlbumID)
);

INSERT INTO Artist(Name) VALUES ('Arijit Singh'),('Shreya Ghoshal');
INSERT INTO Album(Title,ArtistID,ReleaseDate) VALUES ('Heartbeats',1,'2024-05-10'),('Melodies',2,'2025-03-20');
INSERT INTO Song(AlbumID,Title,DurationSec) VALUES (1,'Echoes',210),(1,'Midnight',180),(2,'Sunrise',200);

SELECT al.Title,COUNT(s.SongID) AS TotalSongs FROM Song s JOIN Album al ON s.AlbumID=al.AlbumID GROUP BY al.Title;
SELECT ar.Name,al.Title,s.Title,s.DurationSec FROM Song s JOIN Album al ON s.AlbumID=al.AlbumID JOIN Artist ar ON al.ArtistID=ar.ArtistID;

DELIMITER //
CREATE PROCEDURE AddOrUpdateSong(IN sid INT,IN aid INT,IN stitle VARCHAR(200),IN dur INT)
BEGIN
  IF EXISTS(SELECT 1 FROM Song WHERE SongID=sid) THEN
    UPDATE Song SET AlbumID=aid,Title=stitle,DurationSec=dur WHERE SongID=sid;
  ELSE
    INSERT INTO Song(AlbumID,Title,DurationSec) VALUES(aid,stitle,dur);
  END IF;
END //
DELIMITER ;
