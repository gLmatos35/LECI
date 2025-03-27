package ex3;

import java.util.List;

public class Main {
    public static void main(String[] args) {
        System.out.println();

        Movie movie = new Movie.MovieBuilder()
            .setTitle("Odyssey")
            .setYear(2026)
            .setDirector(new Person("Christopher Nolan"))
            .setWriter(new Person("Christopher Nolan"))
            .build();

        System.out.println("Movie 1:\n" + movie);


        Movie movie2 = new Movie.MovieBuilder()
            .setTitle("Inception")
            .setYear(2010)
            .setDirector(new Person("Christopher Nolan"))
            .setWriter(new Person("Christopher Nolan"))
            .setCast(List.of(new Person("Leonardo DiCaprio"), new Person("Joseph Gordon-Levitt")))
            .setLocations(List.of(new Place("Los Angeles"), new Place("Paris")))
            .setLanguages(List.of("English", "French"))
            .build();
        System.out.println("Movie 2:\n" + movie2);


        Movie movie3 = new Movie.MovieBuilder()
            .setTitle("Black Mirror: Bandersnatch")
            .setYear(2018)
            .setDirector(new Person("David Slade"))
            .setWriter(new Person("Charlie Brooker"))
            .setSeries("Black Mirror")
            .setIsNetflix(true)
            .build();
        System.out.println("Movie 3:\n" + movie3);


        Movie movie4 = new Movie.MovieBuilder()
            .setTitle("The Godfather")
            .setYear(1972)
            .setDirector(new Person("Francis Coppola"))
            .setWriter(new Person("Mario Puzo"))
            .setGenres(List.of("Gangster", "Crime", "Drama"))
            .setIsIndependent(false)
            .setIsTelevision(false)
            .build();
        System.out.println("Movie 4:\n" + movie4);
        

        Movie movie5 = new Movie.MovieBuilder()
            .setTitle("Interstellar")
            .setYear(2014)
            .setDirector(new Person("Christopher Nolan"))
            .setWriter(new Person("Jonathan Nolan"))
            .setSeries(null)
            .setCast(List.of(new Person("Matthew McConaughey"), new Person("Anne Hathaway")))
            .setLocations(List.of(new Place("Iceland"), new Place("Los Angeles")))
            .setLanguages(List.of("English"))
            .setGenres(List.of("Sci-Fi", "Adventure", "Drama"))
            .setIsTelevision(false)
            .setIsNetflix(false)
            .setIsIndependent(false)
            .build();
        System.out.println("Movie 5:\n" + movie5);
    }
}
