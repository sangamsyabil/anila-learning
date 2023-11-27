// https://colors.zoodinkers.com/api?date=2021-04-01
const API_URL = 'https://colors.zoodinkers.com/api'
document.addEventListener("DOMContentLoaded", () => {
    const dateForm = document.getElementById("dateForm");
    const dateInput = document.getElementById("dateInput");
    const searchHistory = document.getElementById("searchHistory");
    const clearHistoryButton = document.getElementById("clearHistory");

    // Get today's date
    const today = new Date().toISOString().split('T')[0];

    // Set the input value to today's date
    dateInput.value = today;

    // Retrieve search history from local storage
    let history = JSON.parse(localStorage.getItem("searchHistory")) || [];

    // Display search history
    displayHistory();

    // Event listener for form submission
    dateForm.addEventListener("submit", async (e) => {
        e.preventDefault();
        const selectedDate = dateInput.value;

        // Fetch data from Color of the Day API
        const response = await fetch(`${API_URL}?date=${selectedDate}`);
        const data = await response.json();

        // Save search history and display color data
        saveToHistoryAndDisplay(selectedDate, data);
    });

    // Event listener to clear search history
    clearHistoryButton.addEventListener("click", () => {
        history = [];
        localStorage.removeItem("searchHistory");
        displayHistory();
    });

    // Function to save search history and display color data
    function saveToHistoryAndDisplay(selectedDate, data) {
        history.push({ date: selectedDate, hex: data.hex });
        localStorage.setItem("searchHistory", JSON.stringify(history));
        displayHistory();
    }

    // Function to display search history with recent data at the top
    function displayHistory() {
        searchHistory.innerHTML = "";

        if (history.length === 0) {
            const li = document.createElement("li");
            li.textContent = "There are no records in history.";
            searchHistory.appendChild(li);
        } else {
            for (let i = history.length - 1; i >= 0; i--) {
                const item = history[i];
                const li = document.createElement("li");
                const colorSwatch = document.createElement("div");
                colorSwatch.classList.add("colorSwatch");
                colorSwatch.style.backgroundColor = item.hex;

                li.appendChild(colorSwatch);

                const historyInfo = document.createElement("span");
                historyInfo.classList.add("historyInfo");
                historyInfo.innerHTML = `Color: ${item.hex} <br> Date: ${item.date}`;
                li.appendChild(historyInfo);

                searchHistory.appendChild(li);
            }
        }
    }
});
