// Validación básica para registro
document.addEventListener('DOMContentLoaded', function() {
	const form = document.getElementById('registerForm');
	if (!form) return;
	const nombre = document.getElementById('nombre');
	const correo = document.getElementById('correo');
	const password = document.getElementById('password');
	const nombreErr = document.getElementById('nombreErr');
	const correoErr = document.getElementById('correoErr');
	const passErr = document.getElementById('passErr');

	form.addEventListener('submit', function(e) {
		let valid = true;

		// Validar nombre
		if (!nombre.value || nombre.value.length < 3) {
			nombreErr.hidden = false;
			valid = false;
		} else {
			nombreErr.hidden = true;
		}

		// Validar correo
		if (!correo.value || !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(correo.value)) {
			correoErr.hidden = false;
			valid = false;
		} else {
			correoErr.hidden = true;
		}

		// Validar contraseña
		if (!password.value || password.value.length < 6) {
			passErr.hidden = false;
			valid = false;
		} else {
			passErr.hidden = true;
		}

		if (!valid) {
			e.preventDefault();
		}
	});
});
