function fadeOutFlash() {
    window.addEventListener("DOMContentLoaded", function() {
        let flash = document.querySelector('#flash');
        console.log(flash);
        setTimeout(function(){ flash.classList.add('opacity-0')}, 5000)
        setTimeout(function(){ flash.innerHTML=""}, 7000)
    });
}
