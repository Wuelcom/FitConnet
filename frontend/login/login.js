const form = document.getElementById("loginForm");
const errorMsg = document.getElementById("errorMsg");

form.addEventListener("submit", async (e) => {
  e.preventDefault();

  const data = {
    nombre: document.getElementById("username").value,
    contrasena: document.getElementById("password").value
  };

  const res = await fetch("http://127.0.0.1:8000/usuarios/login", {
    method: "POST",
    headers: {"Content-Type": "application/json"},
    body: JSON.stringify(data)
  });

  if (res.ok) {
    const user = await res.json();
    localStorage.setItem("usuario", JSON.stringify(user));
    if (user.rol === "Admin") {
      window.location.href = "../admin/admin.html";
    } else {
      window.location.href = "../user/fitconnet.html";
    }
  } else {
    errorMsg.hidden = false;
  }
});
