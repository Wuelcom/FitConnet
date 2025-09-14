const user = JSON.parse(localStorage.getItem("usuario"));
const nombreUsuario = document.getElementById("nombreUsuario");
const cerrarSesion = document.getElementById("cerrarSesion");

if (user) {
  nombreUsuario.textContent = user.nombre;
} else {
  window.location.href = "../login/login.html";
}

cerrarSesion.addEventListener("click", () => {
  localStorage.removeItem("usuario");
  window.location.href = "../login/login.html";
});
