document.getElementById("loginForm").addEventListener("submit", async (e) => {
    e.preventDefault();

    const correo = document.getElementById("correo").value;
    const contrasena = document.getElementById("contrasena").value;

    try {
        const response = await fetch("http://127.0.0.1:8000/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                correo_electronico: correo,
                contrasena: contrasena
            })
        });

        const data = await response.json();

        if (response.ok) {
            alert("✅ " + data.message);
            window.location.href = "../user/FitConnet.html"; // página de usuario
        } else {
            document.getElementById("errorMsg").hidden = false;
        }
    } catch (error) {
        console.error("Error:", error);
        document.getElementById("errorMsg").hidden = false;
    }
});
