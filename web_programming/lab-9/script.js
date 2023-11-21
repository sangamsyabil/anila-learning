document.addEventListener("DOMContentLoaded", function () {
    const movieList = document.getElementById("movieList");
    const searchInput = document.getElementById("search");

    function displayMovies(movies) {
        movieList.innerHTML = "";
        movies.forEach(movie => {
            const li = document.createElement("li");
            li.textContent = `${movie.title} - ${movie.year}`;

            const description = document.createElement("p");
            description.textContent = movie.description;
            description.classList.add("description");

            li.appendChild(description);
            li.addEventListener("click", () => {
                description.classList.toggle("description");
            });

            movieList.appendChild(li);
        });
    }

    displayMovies(movies);

    searchInput.addEventListener("input", function () {
        const searchQuery = searchInput.value.toLowerCase();
        const filteredMovies = movies.filter(movie =>
            movie.title.toLowerCase().includes(searchQuery)
        );
        displayMovies(filteredMovies);
    });
});
