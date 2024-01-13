// Account Email: aenilas99@gmail.com
// API Key: cEcu1q4HSB9oPfTmaJGVDhUrlDMfzO3G3ENk2AdD
// https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY

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

        async function callFunction() {
            try {
                const apod = await fetchApodData(dateInput);
                console.log(apod);

                displayApodData(apod);

                apodDiv = document.getElementsByClassName('apodDiv');
                const favoriteButton = document.getElementById('addFav');
                if (favoriteButton) {
                    favoriteButton.addEventListener('click', () => {
                        saveToFavorites(apod);
                        apodDiv.appendChild(favoriteButton);
                    });
                }
            } catch (error) {
                console.error(error);
            }
        }
        callFunction();
    });

    function fetchApodData(date) {
        const api_key = "cEcu1q4HSB9oPfTmaJGVDhUrlDMfzO3G3ENk2AdD";
        const apiUrl = `https://api.nasa.gov/planetary/apod?date=${date}&api_key=${api_key}`;

        return new Promise((resolve, reject) => {
            fetch(apiUrl)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    const staticData = {
                        "date": data.date,
                        "explanation": data.explanation,
                        "hdurl": data.hdurl,
                        "media_type": data.media_type,
                        "service_version": data.service_version,
                        "title": data.title,
                        "url": data.url
                    };

                    resolve(staticData);
                })
                .catch(error => {
                    console.error('Error fetching data:', error);
                    reject(error);
                });
        });
    }


    function displayApodData(apod) {
        const { date, explanation, hdurl, media_type, title, url } = apod;

        const apodDiv = document.createElement('div');
        apodDiv.classList.add("apodDiv");
        apodDiv.innerHTML = `
        <div class="apodImage" style="background-image: url('${url}'); alt="${title}";"></div>
        <div class="apodContent">
            <h3>${title}</h3>
            <p>${date}</p>
            <p>${explanation}</p>
            <button id="addFav">Add to Favorites</button>
        </div>`;

        if (media_type === 'image') {
            const apodImage = apodDiv.querySelector('.apodImage');
            const modal = document.getElementById('modal');
            const modalImage = document.getElementById('modalImage');
            const closeModal = modal.querySelector('.close');

            apodImage.addEventListener('click', () => {
                modal.style.display = 'block';
                modalImage.src = hdurl;
            });

            closeModal.addEventListener('click', () => {
                modal.style.display = 'none';
                modalImage.src = '';
            });

            window.addEventListener('click', (event) => {
                if (event.target === modal) {
                    modal.style.display = 'none';
                    modalImage.src = '';
                }
            });
        }

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
            favoriteDiv.classList.add("favoriteDiv");
            favoriteDiv.innerHTML = `
            <div class="favImage" style="background-image: url('${favorite.url}'); alt="${favorite.title}";"></div>
                <div class="apodContent">
                <h3>${favorite.title}</h3>
                <p>${favorite.date}</p>
                <p>${favorite.explanation.length > 300 ? `${favorite.explanation.substring(0, 300)} ...` : favorite.explanation}</p>
            </div>`;

            const removeButton = document.createElement('button');
            removeButton.classList.add("removeButton");
            removeButton.textContent = 'Remove';
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

    displayFavorites(); 
});
