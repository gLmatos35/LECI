package ex3;

import java.util.List;

public class Movie {
    private final String title;
    private final int year;
    private final Person director;
    private final Person writer;
    private final String series;
    private final List<Person> cast;
    private final List<Place> locations;
    private final List<String> languages;
    private final List<String> genres;
    private final boolean isTelevision;
    private final boolean isNetflix;
    private final boolean isIndependent;

    private Movie(MovieBuilder builder) {
        this.title = builder.title;
        this.year = builder.year;
        this.director = builder.director;
        this.writer = builder.writer;
        this.series = builder.series;
        this.cast = builder.cast;
        this.locations = builder.locations;
        this.languages = builder.languages;
        this.genres = builder.genres;
        this.isTelevision = builder.isTelevision;
        this.isNetflix = builder.isNetflix;
        this.isIndependent = builder.isIndependent;
    }

    @Override
    // public String toString() {
    //     return this.title + " de " + this.director.getName() +
    //         ", lançado em " + this.year;
    // }
    public String toString() {
        String str = "";
        if (this.isTelevision) {
            str += "Série ";
        } else {
            str += "Filme ";
        }
        str += this.title + " de " + this.director.getName() + " com estreia em " + this.year;
        str += "\n";
        if (this.isNetflix) {
            str += "Disponível na Netflix\n";
        } else {
            str += "Não disponível na Netflix\n";
        }
        if (this.isIndependent) {
            str += "Produção independente\n";
        } else {
            str += "Produção de estúdio\n";
        }
        if (this.series != null) {
            str += "Série: " + this.series + "\n";
        }
        if (this.writer != null) {
            str += "Escrito por: " + this.writer.getName() + "\n";
        }
        if (this.cast != null) {
            str += "Elenco: ";
            for (Person person : this.cast) {
                str += person.getName() + ", ";
            }
            str = str.substring(0, str.length() - 2);
            str += "\n";
        }
        if (this.locations != null) {
            str += "Filmado em: ";
            for (Place place : this.locations) {
                str += place.getLocation() + ", ";
            }
            str = str.substring(0, str.length() - 2);
            str += "\n";
        }
        if (this.languages != null) {
            str += "Idiomas: ";
            for (String language : this.languages) {
                str += language + ", ";
            }
            str = str.substring(0, str.length() - 2);
            str += "\n";
        }
        if (this.genres != null) {
            str += "Gêneros: ";
            for (String genre : this.genres) {
                str += genre + ", ";
            }
            str = str.substring(0, str.length() - 2);
            str += "\n";
        }
        return str;
    }

    public static class MovieBuilder {
        private String title;
        private int year;
        private Person director;
        private Person writer;
        private String series;
        private List<Person> cast;
        private List<Place> locations;
        private List<String> languages;
        private List<String> genres;
        private boolean isTelevision;
        private boolean isNetflix;
        private boolean isIndependent;

        public MovieBuilder setTitle(String title) {
            this.title = title;
            return this;
        }

        public MovieBuilder setYear(int year) {
            this.year = year;
            return this;
        }

        public MovieBuilder setDirector(Person director) {
            this.director = director;
            return this;
        }

        public MovieBuilder setWriter(Person writer) {
            this.writer = writer;
            return this;
        }

        public MovieBuilder setSeries(String series) {
            this.series = series;
            return this;
        }

        public MovieBuilder setCast(List<Person> cast) {
            this.cast = cast;
            return this;
        }

        public MovieBuilder setLocations(List<Place> locations) {
            this.locations = locations;
            return this;
        }

        public MovieBuilder setLanguages(List<String> languages) {
            this.languages = languages;
            return this;
        }

        public MovieBuilder setGenres(List<String> genres) {
            this.genres = genres;
            return this;
        }

        public MovieBuilder setIsTelevision(boolean isTelevision) {
            this.isTelevision = isTelevision;
            return this;
        }

        public MovieBuilder setIsNetflix(boolean isNetflix) {
            this.isNetflix = isNetflix;
            return this;
        }

        public MovieBuilder setIsIndependent(boolean isIndependent) {
            this.isIndependent = isIndependent;
            return this;
        }

        public Movie build() {
            return new Movie(this);
        }

        public String getTitle() {
            return this.title;
        }


        public int getYear() {
            return this.year;
        }


        public Person getDirector() {
            return this.director;
        }


        public Person getWriter() {
            return this.writer;
        }

        public String getSeries() {
            return this.series;
        }


        public List<Person> getCast() {
            return this.cast;
        }


        public List<Place> getLocations() {
            return this.locations;
        }


        public List<String> getLanguages() {
            return this.languages;
        }


        public List<String> getGenres() {
            return this.genres;
        }


        public boolean isIsTelevision() {
            return this.isTelevision;
        }

        public boolean getIsTelevision() {
            return this.isTelevision;
        }


        public boolean isIsNetflix() {
            return this.isNetflix;
        }

        public boolean getIsNetflix() {
            return this.isNetflix;
        }


        public boolean isIsIndependent() {
            return this.isIndependent;
        }

        public boolean getIsIndependent() {
            return this.isIndependent;
        }
    }
}
