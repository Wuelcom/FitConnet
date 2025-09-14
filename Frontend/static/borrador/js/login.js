// Validación básica para login
document.addEventListener('DOMContentLoaded', function() {
	const form = document.getElementById('loginForm');
	if (!form) return;
	const correo = document.getElementById('correo');
	const password = document.getElementById('password');
	const correoErr = document.getElementById('correoErr');
	const passErr = document.getElementById('passErr');

	form.addEventListener('submit', function(e) {
		let valid = true;

		// Validar correo
		if (!correo.value || !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(correo.value)) {
			correoErr.hidden = false;
			valid = false;
		} else {
			correoErr.hidden = true;
		}

		// Validar contraseña
		if (!password.value) {
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
