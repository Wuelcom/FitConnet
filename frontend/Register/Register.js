// Referencias a los elementos
const form = document.getElementById("registerForm");
const username = document.getElementById("username");
const password = document.getElementById("password");
const confirmPw = document.getElementById("confirm");
const submitBtn = document.getElementById("submitBtn");

// Elementos de error
const uErr = document.getElementById("uErr");
const pErr = document.getElementById("pErr");
const cErr = document.getElementById("cErr");

// Barra de fuerza
const pwBar = document.getElementById("pwBar");

// Función para mostrar/ocultar elementos de error
function show(el, cond) {
    el.hidden = !cond;
}

// Calcular fuerza de contraseña
function scorePassword(pw) {
    let s = 0;
    if (!pw) return 0;
    const uniq = new Set(pw).size;
    s += Math.min(uniq * 3, 30);
    if (/[a-z]/.test(pw)) s += 15;
    if (/[A-Z]/.test(pw)) s += 15;
    if (/\d/.test(pw)) s += 15;
    if (/[^A-Za-z0-9]/.test(pw)) s += 15;
    if (pw.length >= 12) s += 10;
    else if (pw.length >= 8) s += 5;
    return Math.min(s, 100);
}

// Validar formulario
function validate() {
    const uOk = username.value.trim().length >= 3;
    const pOk = password.value.length >= 8;
    const mOk = password.value && password.value === confirmPw.value;

    show(uErr, !uOk && username.value.length > 0);
    show(pErr, !pOk && password.value.length > 0);
    show(cErr, !mOk && confirmPw.value.length > 0);

    submitBtn.disabled = !(uOk && pOk && mOk);
    return uOk && pOk && mOk;
}

// Mostrar/ocultar contraseña
document.querySelectorAll(".pw-toggle").forEach(btn => {
    btn.addEventListener("click", () => {
        const target = document.getElementById(btn.dataset.target);
        const isPw = target.type === "password";
        target.type = isPw ? "text" : "password";
        btn.textContent = isPw ? "Ocultar" : "Mostrar";
    });
});

// Indicador de fuerza en vivo
password.addEventListener("input", () => {
    const sc = scorePassword(password.value);
    pwBar.style.width = sc + "%";
    pwBar.style.background = sc < 40 ? "red" : (sc < 70 ? "orange" : "green");
});

// Eventos para validar en vivo
["input", "blur", "keyup", "change"].forEach(evt => {
    [username, password, confirmPw].forEach(el => el.addEventListener(evt, validate));
});

// Guardar usuario (modo demo con localStorage)
form.addEventListener("submit", (e) => {
    e.preventDefault();
    if (!validate()) {
        alert("Revisa los campos en rojo");
        return;
    }

    const user = username.value.trim();
    const users = JSON.parse(localStorage.getItem("fit_users") || "{}");
    if (users[user]) {
        alert("Ese usuario ya existe");
        return;
    }

    const hash = btoa(password.value).split("").reverse().join("");
    users[user] = { pw: hash, createdAt: new Date().toISOString() };
    localStorage.setItem("fit_users", JSON.stringify(users));

    alert("¡Cuenta creada con éxito!");
    form.reset();
    pwBar.style.width = "0%";
    submitBtn.disabled = true;
});

// Estado inicial
submitBtn.disabled = true;
