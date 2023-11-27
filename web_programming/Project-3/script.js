document.addEventListener('DOMContentLoaded', () => {
    const dateForm = document.getElementById('dateForm');
    const apodDataElement = document.getElementById('apodData');
    const favoritesElement = document.getElementById('favorites');

    dateForm.addEventListener('submit', async (event) => {
        event.preventDefault();
        const dateInput = document.getElementById('dateInput').value;
        const today = new Date().toISOString().split('T')[0];

        if (dateInput > today) {
            alert('Please enter a date on or before today.');
            return;
        }

        try {
            const apod = await fetchApodData(dateInput);
            displayApodData(apod);
        } catch (error) {
            console.error('Error fetching APOD:', error);
        }
    });

    function fetchApodData(date) {
        // Simulating API call using a static object (Replace with actual fetch to APOD API)
        const staticData = {
            "date": "2022-03-27",
            "explanation": "Why would the surface of Titan light up with a blinding flash? The reason: a sunglint from liquid seas.",
            "hdurl": "https://apod.nasa.gov/apod/image/2203/TitanGlint_cassini_2002.jpg",
            "media_type": "image",
            "service_version": "v1",
            "title": "Titan Seas Reflect Sunlight",
            "url": "https://apod.nasa.gov/apod/image/2203/TitanGlint_cassini_960.jpg"
        };

        return new Promise((resolve) => {
            setTimeout(() => {
                resolve(staticData);
            }, 1000); // Simulating delay of 1 second for API call
        });
    }

    function displayApodData(apod) {
        const { date, explanation, hdurl, media_type, title, url } = apod;

        const apodDiv = document.createElement('div');
        apodDiv.classList.add("apodDiv");
        apodDiv.innerHTML = `
        <div>
            <img class="apodImage" src="${url}" alt="${title}">
        </div>
        <div>
            <h3>${title}</h3>
            <p>${date}</p>
            <p>${explanation}</p>
            <button id="addFav">Add to Favorites</button>
        </div>`;

        if (media_type === 'image') {
            apodDiv.querySelector('img').addEventListener('click', () => {
                window.open(hdurl);
            });
        }

        const favoriteButton = document.getElementById('addFav');
        favoriteButton.addEventListener('click', () => {
            saveToFavorites(apod);
        });
        // apodDiv.appendChild(favoriteButton);

        apodDataElement.innerHTML = '';
        apodDataElement.appendChild(apodDiv);
    }

    function saveToFavorites(apod) {
        let favorites = JSON.parse(localStorage.getItem('favorites')) || [];
        favorites.push(apod);
        localStorage.setItem('favorites', JSON.stringify(favorites));
        displayFavorites();
    }

    function displayFavorites() {
        favoritesElement.innerHTML = '';
        const favorites = JSON.parse(localStorage.getItem('favorites')) || [];

        favorites.forEach((favorite, index) => {
            const favoriteDiv = document.createElement('div');
            favoriteDiv.innerHTML = `
          <h3>${favorite.title}</h3>
          <p>Date: ${favorite.date}</p>
          <p>${favorite.explanation}</p>
          <img src="${favorite.url}" alt="${favorite.title}">
        `;

            const removeButton = document.createElement('button');
            removeButton.textContent = 'Remove from Favorites';
            removeButton.addEventListener('click', () => {
                removeFromFavorites(index);
            });
            favoriteDiv.appendChild(removeButton);

            favoritesElement.appendChild(favoriteDiv);
        });
    }

    function removeFromFavorites(index) {
        let favorites = JSON.parse(localStorage.getItem('favorites')) || [];
        favorites.splice(index, 1);
        localStorage.setItem('favorites', JSON.stringify(favorites));
        displayFavorites();
    }

    displayFavorites(); // Display favorites on page load
});
