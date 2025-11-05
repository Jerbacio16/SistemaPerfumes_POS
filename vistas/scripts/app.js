var productos = []; // Array que almacena los prodcutos cargados
var paginaActual = 1; // Número de pagina actual para la paginacion
var totalPaginas = 1; // Total de paginas disponibles
var carrito = JSON.parse(localStorage.getItem('carrito')) || []; // Recupera el carrito del localstorage o inicializa array vacio

//funcion que se ejecuta el inicio

function init() {
    cargarCategorias(); // Carga las categorias disponibles
    cargarProductos(); // Carga los productos iniciales
    cargarMarcas(); // Carga de las marcas
    actualizarContadorCarrito(); // Actualiza el contador visual del carrito
}

// Funcion para cargar categorias dinamicamente
function cargarCategorias() {
    $.ajax({
        
    });
}

function cargarProductos(pagina = 1) {
    mostrarCargando(True);
    ocultarMensajes();

    var categoria = $('#categoryFilter').val();
    var buscar = $('#searchInput').val();
    var precio = $('#priceFilter').val();
    var ordenar = $('#sortFilter').val();

    $.ajax({

    });
}

function mostrarProductos() {
    
}

function crearPaginacion() {
    
}

// CArgar productos desde la pagina 1
function BuscarProductos() {
    cargarCategorias(1);
}

function limpiarFiltros() {
    $('#categoryfilter').val('');
    //$('#marcafilter').val('');
    $('#pricefilter').val('');
    $('#sortfilter').val('');
    $('#searchInput').val('');
    cargarProductos(1);
}

function verProductos(idarticulo) {
    $.ajax({
        
    });
}
function mostrarDetalleProducto(producto) {

}
function cerrarModal() {
    $('#productModal').remove();

}
function agregarAlCarrito(event, idarticulo, nombre, precio){

}

function actualizarContadorCarrito(){

}

function verCarrito(){

}

function verCantidadCarrito(){

}

function cambiarCantidad(idarticulo, cambio){

}

function eliminarDelCarrito(idarticulo){

}

function vaciarCarrito(){
    carrito = [];

    localStorage.removeItem('carrito');
    actualizarContadorCarrito();
    cerrarCarrito();
    mostrarExito('Carrito vacio');
}

function cerrarCarrito() {
    $('"cartModal').remove();
}

function procederAlPago(){
    mostrarExito('Funcion de pago en desarrollo')

}

function mostrarCargando(mostrar){
    if (mostrar){
        $('#loadingMessage').show();
    }else{
        $('#loadingMessage').hide();
    }
}

function mostrarError(mesaje){
    $('#errorMessage').text(mensaje).show();
    setTimeout(()=> $('#errorMessage').hide(), 5000);
}
function mostrarExito(mesaje){
    $('#successMessage').text(mensaje).show();
    setTimeout(()=> $('#successMessage').hide(), 3000);
}
function ocultarMensajes(){

}
function loadProducts(pagina){
    cargarProductos(pagina);

}
function searchProducts(){
    BuscarProductos();
}
function clearFilters(){
    limpiarFiltros();
}
function viewsProduct(idarticulo){
    verProductos(idarticulo);
}

