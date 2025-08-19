// Simulación de usuarios con roles
const users = [
  { username: "admin", password: "1234", role: "admin" },
  { username: "juan", password: "abcd", role: "user" }
];

document.getElementById("loginForm").addEventListener("submit", function(event) {
  event.preventDefault();

  const username = document.getElementById("username").value;
  const password = document.getElementById("password").value;

  // Buscar usuario en la lista
  const user = users.find(u => u.username === username && u.password === password);

  if (user) {
    if (user.role === "admin") {
      window.location.href = "Admin.html"; // redirige a admin
    } else {
      window.location.href = "Fitconnet.html"; // redirige a usuario normal
    }
  } else {
    alert("Usuario o contraseña incorrectos");
  }
});
