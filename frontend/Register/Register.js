const form = document.getElementById("registerForm");
const msg = document.getElementById("msg");

form.addEventListener("submit", async (e) => {
  e.preventDefault();

  const data = {
    nombre: document.getElementById("nombre").value,
    correo_electronico: document.getElementById("correo").value,
    contrasena: document.getElementById("contrasena").value,
    rol: document.getElementById("rol").value
  };

  const res = await fetch("http://127.0.0.1:8000/usuarios/register", {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify(data)
  });

  if (res.ok) {
    msg.style.color = "green";
    msg.textContent = "Usuario registrado correctamente ✅";
    setTimeout(() => window.location.href = "../login/login.html", 1500);
  } else {
    msg.style.color = "red";
    msg.textContent = "Error al registrar usuario ❌";
  }
});
