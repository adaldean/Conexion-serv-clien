function confirmarEliminacion(event, url) {
    event.preventDefault();
    if (confirm("¿Estás seguro de que quieres eliminar este usuario?")) {
        window.location.href = url;
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const input = document.getElementById('buscar-id');
    if (!input) return; 

    input.addEventListener('keyup', function() {
        const filter = input.value.trim();
        const rows = document.querySelectorAll('table tbody tr');

        rows.forEach(row => {
            const idCell = row.querySelector('td:first-child').textContent;
            if (idCell.includes(filter)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
});