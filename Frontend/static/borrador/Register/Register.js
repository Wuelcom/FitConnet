document.getElementById("registerForm").addEventListener("submit", async (e) => {
    e.preventDefault();

    const nombre = document.getElementById("nombre").value;
    const correo = document.getElementById("correo").value;
    const contrasena = document.getElementById("contrasena").value;
    const rol = document.getElementById("rol").value;

    try {
        const response = await fetch("http://127.0.0.1:8000/users/", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                nombre: nombre,
                correo_electronico: correo,
                contrasena: contrasena,
                rol: rol
            })
        });

        if (response.ok) {
            document.getElementById("successMsg").hidden = false;
            document.getElementById("errorMsg").hidden = true;
            document.getElementById("registerForm").reset();

            // Redirigir al login después de 2s
            setTimeout(() => {
                window.location.href = "../login/login.html";
            }, 2000);
        } else {
            document.getElementById("errorMsg").hidden = false;
            document.getElementById("successMsg").hidden = true;
        }
    } catch (error) {
        console.error("Error:", error);
        document.getElementById("errorMsg").hidden = false;
    }
});
