const emojiContainer = document.getElementById('emoji-container');

emojiData.forEach((emoji) => {
    const emojiDiv = document.createElement('div');
    emojiDiv.innerHTML = `
        <div class="emoji-box">
            <div class="emoji-icon">${emoji.char}</div>
            <p>${emoji.name}</p>
        </div>
    `;
    emojiContainer.appendChild(emojiDiv);
}); 
