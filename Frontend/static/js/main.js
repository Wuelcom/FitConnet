// app/static/js/main.js
// JS que conecta el front-end con la API FastAPI usando fetch.
// Base URL de la API (ajusta si cambias puerto)
const API_BASE = "/api";

document.getElementById("formUser").addEventListener("submit", async (e)=>{
  e.preventDefault();
  const nombre = document.getElementById("nombre").value;
  const email = document.getElementById("email").value;
  const password = document.getElementById("password").value;

  const payload = { nombre, email, password };
  const res = await fetch(`${API_BASE}/users/`, {
    method: "POST",
    headers: {"Content-Type":"application/json"},
    body: JSON.stringify(payload)
  });
  const data = await res.json();
  document.getElementById("createResult").innerText = res.ok ? "Usuario creado: ID " + data.id : "Error: " + JSON.stringify(data);
});

document.getElementById("btnLoadUsers").addEventListener("click", async ()=>{
  const res = await fetch(`${API_BASE}/users/`);
  const users = await res.json();
  const ul = document.getElementById("usersList");
  ul.innerHTML = "";
  users.forEach(u => {
    const li = document.createElement("li");
    li.textContent = `${u.id} — ${u.nombre} — ${u.email}`;
    ul.appendChild(li);
  });
});
