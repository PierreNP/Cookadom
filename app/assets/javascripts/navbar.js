window.onscroll = function() {
    "use strict";
    var myNav = document.getElementById("nav");
    if (document.body.scrollTop >= 58 || document.documentElement.scrollTop >= 58) {
        myNav.classList.add("shadow");
        myNav.classList.add("bg-light");
    } else {
        myNav.classList.remove("bg-light");
        myNav.classList.remove("shadow");
    }
};