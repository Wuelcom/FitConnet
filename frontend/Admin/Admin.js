const tabla = document.querySelector("#tablaUsuarios tbody");
const logoutBtn = document.getElementById("logout");

async function cargarUsuarios() {
  const res = await fetch("http://127.0.0.1:8000/usuarios/");
  const usuarios = await res.json();

  tabla.innerHTML = "";
  usuarios.forEach(u => {
    const row = `
      <tr>
        <td>${u.id_usuario}</td>
        <td>${u.nombre}</td>
        <td>${u.correo_electronico}</td>
        <td>${u.rol}</td>
        <td>
          <button class="edit" onclick="editar(${u.id_usuario})">Editar</button>
          <button onclick="eliminar(${u.id_usuario})">Eliminar</button>
        </td>
      </tr>`;
    tabla.innerHTML += row;
  });
}

async function eliminar(id) {
  if (!confirm("¿Eliminar usuario?")) return;
  await fetch(`http://127.0.0.1:8000/usuarios/${id}`, { method: "DELETE" });
  cargarUsuarios();
}

function editar(id) {
  alert("Funcionalidad de editar pendiente (se puede abrir modal o formulario)");
}

logoutBtn.addEventListener("click", () => {
  localStorage.removeItem("usuario");
  window.location.href = "../login/login.html";
});

cargarUsuarios();
