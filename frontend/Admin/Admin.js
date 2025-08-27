let indice = 0;

function moverCarrusel(direccion) {
  const carrusel = document.querySelector('.carrusel');
  const items = document.querySelectorAll('.item');
  const itemsPorVista = 3; // Tarjetas visibles
  const total = items.length;

  // Ajustar índice
  indice += direccion;
  if (indice < 0) indice = 0;
  if (indice > total - itemsPorVista) indice = total - itemsPorVista;

  // Calcular ancho de cada tarjeta
  const tarjeta = items[0].offsetWidth + 20; // ancho + gap
  carrusel.style.transform = `translateX(-${indice * tarjeta}px)`;
}
