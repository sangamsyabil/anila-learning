// Function to generate a random code with optional parameters
function generateCode(length = 6, includeNumbers = false) {
    const charset = getCharset(includeNumbers);
    let code = "";
    for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * charset.length);
        code += charset.charAt(randomIndex);
    }
    return code;
}

function getCharset(includeNumbers) {
    let charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    if (includeNumbers) {
        charset += "0123456789";
    }
    return charset;
}

// Function to get a character by its UTF-16 value
function getCharByCodePoint(codePoint) {
    return String.fromCodePoint(codePoint);
}

// Function to get the UTF-16 value of a character
function getCodePointByChar(char) {
    return char.codePointAt(0);
}

// Function to display generated code on the HTML page
function displayGeneratedCode(code) {
    document.getElementById("code").textContent = code;
}

// Function to generate and display code on button click
function generateCodeOnClick() {
    const codeLength = document.getElementById("codeLength").value;
    const includeNumbers = document.getElementById("includeNumbers").checked;
    const code = generateCode(codeLength, includeNumbers);
    displayGeneratedCode(code);
}

// Event listener for button click
document.getElementById("generateButton").addEventListener("click", generateCodeOnClick);

