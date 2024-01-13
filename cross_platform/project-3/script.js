// Function to add classes based on screen size
function addClassBasedOnScreen() {
    var screenWidth = window.innerWidth;

    // Target the sign-up-page element
    var signUpPage = document.getElementById('sign-up');
    var pseudoSign = document.getElementById('pseudo-box');

    if (screenWidth < 768) { // Mobile or Tablet
        signUpPage.classList.add('container-fluid');
        signUpPage.classList.remove('container');

        pseudoSign.classList.add('container-fluid');
        pseudoSign.classList.remove('container');
    } else { // Desktop
        signUpPage.classList.remove('container-fluid');
        signUpPage.classList.add('container');

        pseudoSign.classList.remove('container-fluid');
        pseudoSign.classList.add('container');
    }
}

// Call the function initially and whenever the window size changes
addClassBasedOnScreen();

window.addEventListener('resize', addClassBasedOnScreen);