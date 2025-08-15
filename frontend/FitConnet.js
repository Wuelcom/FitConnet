// Cambiar el color del header al hacer scroll
window.addEventListener("scroll", function() {
    let header = document.querySelector(".section1");
    if (window.scrollY > 50) {
        header.classList.add("scrolled");
    } else {
        header.classList.remove("scrolled");
    }
});

// Funcionalidad de los botones
document.getElementById("cerrarSesion").addEventListener("click", function() {
    window.location.href = "login.html";
});

document.getElementById("perfil").addEventListener("click", function() {
    window.location.href = "perfil.html";
});