// Variables globales
var productos = [];
var paginaActual = 1;
var totalPaginas = 1;
var carrito = JSON.parse(localStorage.getItem('carrito')) || [];


// ************************************
// FUNCIONES GLOBALES DEL CARRITO (AÑADIDAS/MOVIDAS PARA RESOLVER EL ReferenceError)
// ************************************

// Función para actualizar el contador del carrito en el ícono (SOLUCIONA EL ERROR 1)
function actualizarContadorCarrito() {
    var totalItems = carrito.reduce((sum, item) => sum + item.cantidad, 0);
    $('#cartCount').text(totalItems);
}

// FUNCIÓN PRINCIPAL PARA AGREGAR AL CARRITO (SOLUCIONA EL ReferenceError PRINCIPAL)
function agregarAlCarrito(idarticulo, nombre, precio) {
    var itemExistente = carrito.find(item => item.idarticulo === idarticulo);
    
    if (itemExistente) {
        itemExistente.cantidad++;
    } else {
        carrito.push({
            idarticulo: idarticulo,
            nombre: nombre,
            precio: precio,
            cantidad: 1
        });
    }
    
    localStorage.setItem('carrito', JSON.stringify(carrito));
    actualizarContadorCarrito();
    mostrarExito(`${nombre} agregado al carrito`);
}

// FUNCIÓN AUXILIAR PARA EL ÍNDICE (SOLUCIONA EL CONFLICTO DE CLIC)
// Esta función se llama desde el botón de la tarjeta y detiene la propagación
// para que no se abra el modal de detalles al mismo tiempo.
function agregarAlCarritoIndex(event, idarticulo, nombre, precio) {
    if (event) {
        event.stopPropagation(); // Detiene que el clic llegue al <div> padre (la tarjeta)
    }
    agregarAlCarrito(idarticulo, nombre, precio); // Llama a la lógica principal
}

// Función para cambiar la cantidad de un producto en el carrito
function cambiarCantidad(idarticulo, cambio) {
    var item = carrito.find(i => i.idarticulo === idarticulo);
    if (item) {
        item.cantidad += cambio;
        if (item.cantidad <= 0) {
            // Eliminar si la cantidad llega a cero o menos
            carrito = carrito.filter(i => i.idarticulo !== idarticulo);
        }
    }
    localStorage.setItem('carrito', JSON.stringify(carrito));
    actualizarContadorCarrito();
    // Vuelve a renderizar el modal del carrito para actualizar la vista
    verCarrito(); 
}

// Función para eliminar un producto del carrito
function eliminarDelCarrito(idarticulo) {
    carrito = carrito.filter(i => i.idarticulo !== idarticulo);
    localStorage.setItem('carrito', JSON.stringify(carrito));
    actualizarContadorCarrito();
    verCarrito(); // Actualiza el modal
    mostrarExito('Producto eliminado del carrito');
}

// Función para vaciar todo el carrito
function vaciarCarrito() {
    carrito = [];
    localStorage.setItem('carrito', JSON.stringify(carrito));
    actualizarContadorCarrito();
    cerrarCarrito(); // Cierra y actualiza la vista
    mostrarExito('Carrito vaciado con éxito');
}


// ************************************
// LÓGICA DE INICIALIZACIÓN Y FILTROS
// ************************************

// Función que se ejecuta al inicio
function init() {
    cargarCategorias();
    cargarMarcas();
    cargarProductos();
    actualizarContadorCarrito(); // Ahora esta función existe y funcionará
    cargarMarcasCarrusel();
}

// Función para cargar categorías dinámicamente
function cargarCategorias() {
    $.ajax({
        url: '../ajax/tienda.php?op=listarCategorias',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            var select = $('#categoryFilter');
            select.html('<option value="">Todas las categorías</option>');
            
            $.each(data, function(index, categoria) {
                select.append('<option value="' + categoria.idcategoria + '">' + categoria.nombre + '</option>');
            });
        },
        error: function(xhr, status, error) {
            console.log('Error al cargar categorías:', error);
            mostrarError('Error al cargar las categorías');
        }
    });
}

// Función para cargar categorías dinámicamente
function cargarMarcas() {
    $.ajax({
        url: '../ajax/tienda.php?op=listarMarcas',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            var select = $('#marcaFilter');
            select.html('<option value="">Todas las marcas</option>');
            
            $.each(data, function(index, marca) {
                select.append('<option value="' + marca.idmarca + '">' + marca.nombre + '</option>');
            });
        },
        error: function(xhr, status, error) {
            console.log('Error al cargar marcas:', error);
            mostrarError('Error al cargar las marcas');
        }
    });
}

// Función principal para cargar productos
function cargarProductos(pagina = 1) {
    mostrarCargando(true);
    ocultarMensajes();
    
    var categoria = $('#categoryFilter').val();
    var marca = $('#marcaFilter').val();
    var buscar = $('#searchInput').val();
    var precio = $('#priceFilter').val();
    var ordenar = $('#sortFilter').val();
    
    $.ajax({
        url: '../ajax/tienda.php?op=listarProductos',
        type: 'GET',
        data: {
            categoria: categoria,
            marca: marca,
            buscar: buscar,
            precio: precio,
            ordenar: ordenar,
            pagina: pagina
        },
        dataType: 'json',
        success: function(response) {
            productos = response.productos;
            paginaActual = response.pagina_actual;
            totalPaginas = response.total_paginas;
            
            mostrarProductos();
            crearPaginacion();
            mostrarCargando(false);
            
            if (productos.length === 0) {
                mostrarError('No se encontraron productos con los filtros seleccionados');
            }
        },
        error: function(xhr, status, error) {
            console.log('Error al cargar productos:', error);
            mostrarError('Error al cargar los productos. Intente nuevamente.');
            mostrarCargando(false);
        }
    });
}

// Función para mostrar productos en el DOM (CORRECCIÓN EN EL BOTÓN)
function mostrarProductos() {
    var container = $('#productsContainer');
    container.empty();
    
    if (productos.length === 0) {
        container.html('<div class="no-products">No se encontraron productos</div>');
        return;
    }
    
    $.each(productos, function(index, producto) {
        var imagePath = producto.imagen !== 'default.jpg' 
            ? '../files/articulos/' + producto.imagen 
            : '../public2/default-product.jpg';
        
        // CORRECCIÓN CLAVE AQUÍ: Se usa agregarAlCarritoIndex(event, ...)
        var productCard = `
            <div class="product-card" onclick="verProducto(${producto.idarticulo})">
                <div class="product-image">
                    <img src="${imagePath}" alt="${producto.nombre}" onerror="this.src='../public2/default-product.jpg'">
                </div>
                <div class="product-info">
                    <div class="product-name">${producto.nombre}</div>
                    <div class="product-marca">${producto.marca}</div>
                    <div class="product-description">${producto.descripcion}</div>
                    <div class="product-price">${producto.precio_formateado}</div>
                    <div class="product-stock">Stock: ${producto.stock} unidades</div>
                    <button class="add-to-cart" onclick="agregarAlCarritoIndex(event, ${producto.idarticulo}, '${producto.nombre}', ${producto.precio_venta})">
                        Agregar al carrito
                    </button>
                </div>
            </div>
        `;
        
        container.append(productCard);
    });
}

// Función para crear paginación
function crearPaginacion() {

    var paginationContainer = $('#pagination');
    paginationContainer.empty();
    
    if (totalPaginas < 1) {
        return;
    }
    
    // Botón anterior
    if (paginaActual > 1) {
        paginationContainer.append(`<button class="page-btn" onclick="cargarProductos(${paginaActual - 1})">‹ Anterior</button>`);
    }
    
    // Números de página
    var inicio = Math.max(1, paginaActual - 2);
    var fin = Math.min(totalPaginas, paginaActual + 2);
    
    
    for (var i = inicio; i <= fin; i++) {
        var activeClass = i === paginaActual ? 'active' : '';
        paginationContainer.append(`<button class="page-btn ${activeClass}" onclick="cargarProductos(${i})">${i}</button>`);
    }
    
    // Botón siguiente
    if (paginaActual < totalPaginas) {
        paginationContainer.append(`<button class="page-btn" onclick="cargarProductos(${paginaActual + 1})">Siguiente ›</button>`);
    }
}

// Función de búsqueda
function buscarProductos() {
    cargarProductos(1);
}

// Función para limpiar filtros
function limpiarFiltros() {
    $('#categoryFilter').val('');
    $('#marcaFilter').val('');
    $('#priceFilter').val('');
    $('#sortFilter').val('');
    $('#searchInput').val('');
    cargarProductos(1);
}

// ************************************
// LÓGICA DE MODALES
// ************************************

// Función para ver detalles del producto
function verProducto(idarticulo) {
    $.ajax({
        url: '../ajax/tienda.php?op=mostrarProducto',
        type: 'GET',
        data: { idarticulo: idarticulo },
        dataType: 'json',
        success: function(producto) {
            if (producto.error) {
                mostrarError('Producto no encontrado');
                return;
            }
            
            mostrarDetalleProducto(producto);
        },
        error: function() {
            mostrarError('Error al cargar el producto');
        }
    });
}

// Función para mostrar modal con detalles del producto (CORRECCIÓN EN EL BOTÓN)
function mostrarDetalleProducto(producto) {
    var imagePath = producto.imagen !== 'default.jpg' 
        ? `<img src="../files/articulos/${producto.imagen}" alt="${producto.nombre}" onerror="this.src='../public2/default-product.jpg'">`
        : '📦'; 
    
    // **1. Rellenar los campos del modal existente**
    $('#modalProductName').text(producto.nombre);
    $('#modalProductImage').html(imagePath); 
    $('#modalProductCategory').text(`Categoría: ${producto.categoria}`);
    $('#modalProductMarca').text(`Marca: ${producto.marca}`);
    $('#modalProductDescription').text(producto.descripcion);
    $('#modalProductPrice').text(producto.precio_formateado); 
    $('#modalProductStock').text(`Stock disponible: ${producto.stock} unidades`);
    
    // **2. Actualizar el botón de "Agregar al Carrito"**
    // CORRECCIÓN CLAVE AQUÍ: Se llama a la función principal SIN 'event'
    var addToCartFunc = `agregarAlCarrito(${producto.idarticulo}, '${producto.nombre}', ${producto.precio_venta})`;
    $('#modalAddToCartBtn').attr('onclick', addToCartFunc);
    
    // **3. Mostrar el modal (usando la clase 'show' del CSS)**
    $('#productModal').addClass('show');
}

// Función para cerrar modal de detalles
function cerrarModal() {
    $('#productModal').removeClass('show');
}

// Función para ver carrito (Genera el modal del carrito dinámicamente)
function verCarrito() {
    
    var total = 0;
    var cartItemsHTML = '';

    if (carrito.length === 0) {
        cartItemsHTML = '<div class="no-products" style="grid-column: 1/-1;"><h3>El carrito está vacío 😔</h3><p>¡Añade algunos productos para empezar a comprar!</p></div>';
        total = 0;
    } else {
        carrito.forEach(function(item) {
            var subtotal = item.precio * item.cantidad;
            total += subtotal;
            
            cartItemsHTML += `
                <div class="cart-item">
                    <div class="item-info">
                        <h4>${item.nombre}</h4>
                        <p>Precio: $${item.precio.toFixed(2)}</p>
                    </div>
                    <div class="item-controls">
                        <button onclick="cambiarCantidad(${item.idarticulo}, -1)">-</button>
                        <span class="quantity">${item.cantidad}</span>
                        <button onclick="cambiarCantidad(${item.idarticulo}, 1)">+</button>
                    </div>
                    <div class="item-total">
                        $${subtotal.toFixed(2)}
                    </div>
                    <button class="remove-btn" onclick="eliminarDelCarrito(${item.idarticulo})">X</button>
                </div>
            `;
        });
    }

    var cartModalHTML = `
        <div id="tempCartModal" class="product-modal show" onclick="cerrarCarrito()">
            <div class="modal-content cart-modal" onclick="event.stopPropagation()">
                <div class="modal-header">
                    <h2>🛒 Carrito de Compras</h2>
                    <button class="modal-close" onclick="cerrarCarrito()">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="cart-items">
                        ${cartItemsHTML}
                    </div>
                    <div class="cart-total">
                        <h3>Total: $${total.toFixed(2)}</h3>
                        <div class="cart-actions">
                            <button class="btn" onclick="procederAlPago()">Proceder al Pago</button>
                            <button class="btn btn-primary" onclick="vaciarCarrito()">Vaciar Carrito</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    // Remover modal temporal anterior y adjuntar el nuevo
    $('#tempCartModal').remove();
    $('body').append(cartModalHTML);
}

// Función para cerrar carrito (quita el modal generado dinámicamente)
function cerrarCarrito() {
    $('#tempCartModal').remove();
}

// Función para proceder al pago (placeholder)
function procederAlPago() {
    mostrarExito('Función de pago en desarrollo');
}

// ************************************
// FUNCIONES DE UTILIDAD Y EVENT LISTENERS
// ************************************

// Funciones de utilidad para mostrar mensajes
function mostrarCargando(mostrar) {
    if (mostrar) {
        $('#loadingMessage').show();
    } else {
        $('#loadingMessage').hide();
    }
}

function mostrarError(mensaje) {
    $('#errorMessage').text(mensaje).show();
    setTimeout(() => $('#errorMessage').hide(), 5000);
}

function mostrarExito(mensaje) {
    $('#successMessage').text(mensaje).show();
    setTimeout(() => $('#successMessage').hide(), 3000);
}

function ocultarMensajes() {
    $('#errorMessage').hide();
    $('#successMessage').hide();
}

// Event listeners
$(document).ready(function() {
    init();
    
    // Buscar al presionar Enter
    $('#searchInput').keypress(function(e) {
        if (e.which === 13) {
            buscarProductos();
        }
    });
    
    // Filtros en tiempo real
    $('#categoryFilter, #marcaFilter #priceFilter, #sortFilter').change(function() {
        cargarProductos(1);
    });
});

// Funciones de compatibilidad con el HTML existente (asegura el acceso global)
function loadProducts(pagina) {
    cargarProductos(pagina);
}

function searchProducts() {
    buscarProductos();
}

function clearFilters() {
    limpiarFiltros();
}

function viewProduct(idarticulo) {
    verProducto(idarticulo);
}

// Asegurar que las llamadas desde el HTML funcionen
function addToCart(event, idarticulo, nombre, precio) {
    agregarAlCarritoIndex(event, idarticulo, nombre, precio);
}

function viewCart() {
    verCarrito();
}

function openLoginModal() {
    document.getElementById('loginModal').style.display = 'flex';
}

function closeLoginModal() {
    document.getElementById('loginModal').style.display = 'none';
}

// Abrir y cerrar modales
function openRegisterModal() {
  document.getElementById('loginModal').style.display = 'none';
  document.getElementById('registerModal').style.display = 'flex';
}

function closeRegisterModal() {
  document.getElementById('registerModal').style.display = 'none';
}

// Cerrar modal haciendo clic afuera
window.onclick = function (e) {
    const login = document.getElementById('loginModal');
    const register = document.getElementById('registerModal');
    if (e.target === login) login.style.display = 'none';
    if (e.target === register) register.style.display = 'none';
};

// Enviar datos de registro
function registrarUsuario() {
  const nombre = $("#regNombre").val();
  const tipoDoc = $("#regTipoDoc").val();
  const numDoc = $("#regNumDoc").val();
  const direccion = $("#regDireccion").val();
  const telefono = $("#regTelefono").val();
  const email = $("#regEmail").val();
  const clave = $("#regClave").val();
  const clave2 = $("#regClave2").val();

  if (!nombre || !email || !clave) {
    $("#regMessage").text("Por favor completá los campos obligatorios.");
    return;
  }
  if (clave !== clave2) {
    $("#regMessage").text("Las contraseñas no coinciden.");
    return;
  }

  $.ajax({
    url: "../ajax/registrar_landing.php",
    type: "POST",
    data: { nombre, tipoDoc, numDoc, direccion, telefono, email, clave },
    success: function (resp) {
      if (resp.trim() === "ok") {
        $("#regMessage").css("color", "green").text("¡Registro exitoso!");
        setTimeout(() => closeRegisterModal(), 1500);
      } else {
        $("#regMessage").text(resp);
      }
    },
    error: function () {
      $("#regMessage").text("Error al conectar con el servidor.");
    }
  });
}

// =============================
// LOGIN + PERFIL DE CLIENTE
// =============================

// Manejo de login
$(document).on("submit", "#loginForm", function (e) {
  e.preventDefault();
  const email = $("#loginEmail").val();
  const password = $("#loginPassword").val();

  $.ajax({
    url: "../ajax/registrar_landing.php",
    type: "POST",
    data: { email, password },
    dataType: "json",
    success: function (resp) {
      if (resp.success) {
        // Guardar sesión en localStorage
        localStorage.setItem("cliente", JSON.stringify(resp.data));

        // Cerrar modal login y mostrar perfil
        closeLoginModal();
        mostrarPerfil();

        $("#loginMessage").text("");
      } else {
        $("#loginMessage").css("color", "red").text(resp.message);
      }
    },
    error: function () {
      $("#loginMessage").css("color", "red").text("Error al conectar con el servidor.");
    }
  });
});

// Mostrar modal de perfil
function mostrarPerfil() {
  const cliente = JSON.parse(localStorage.getItem("cliente"));
  if (!cliente) return;

  $("#perfilNombre").text(cliente.nombre);
  $("#perfilEmail").text(cliente.email);
  $("#perfilTelefono").text(cliente.telefono || "—");
  $("#perfilDireccion").text(cliente.direccion || "—");

  // Mostrar compras
  $.ajax({
    url: "../ajax/tienda.php?op=misCompras",
    type: "GET",
    data: { idcliente: cliente.idcliente },
    dataType: "json",
    success: function (compras) {
      let html = "";
      if (compras.length === 0) {
        html = "<p>No tenés compras registradas aún.</p>";
      } else {
        html = "<ul>";
        compras.forEach(c => {
          html += `<li>🧾 Compra #${c.idventa} - ${c.fecha} - Total: $${c.total}</li>`;
        });
        html += "</ul>";
      }
      $("#perfilCompras").html(html);
    },
    error: function () {
      $("#perfilCompras").html("<p>Error al cargar compras.</p>");
    }
  });

  $("#perfilModal").css("display", "flex");
}

// Cerrar perfil
function cerrarPerfilModal() {
  $("#perfilModal").hide();
}

// Cerrar sesión
function cerrarSesion() {
  localStorage.removeItem("cliente");
  $("#perfilModal").hide();
  mostrarExito("Sesión cerrada.");
}

// Si ya hay sesión, no mostrar login
$(document).ready(function () {
  const cliente = JSON.parse(localStorage.getItem("cliente"));
  if (cliente) {
    mostrarPerfil();
  }
});

let slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("carousel-slide");
  let dots = document.getElementsByClassName("dot");
  if (n > slides.length) { slideIndex = 1 }
  if (n < 1) { slideIndex = slides.length }
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex - 1].style.display = "block";
  dots[slideIndex - 1].className += " active";
}

// Reproducción automática cada 5s
setInterval(() => { plusSlides(1); }, 5000);


function cargarMarcasCarrusel() {
    $.ajax({
        url: "../ajax/marca.php?op=listar_home",
        type: "GET",
        dataType: "json",
        success: function(data) {
            if (!data || data.length === 0) return;

            const carouselInner = $("#carouselMarcas .carousel-inner");
            const indicadores = $("#carousel-indicators-marcas");
            carouselInner.empty();
            indicadores.empty();

            const totalSlides = Math.ceil(data.length / 4);

            for (let i = 0; i < totalSlides; i++) {
                const grupo = data.slice(i * 4, i * 4 + 4);
                const activeClass = (i === 0) ? "active" : "";

                const slide = `
                    <div class="carousel-item ${activeClass}">
                        <div class="row justify-content-center align-items-center flex-nowrap">
                            ${grupo.map(m => `
                                <div class="col-6 col-md-3 text-center">
                                    <img src="../files/marca/${m.imagen}" class="img-fluid marca-logo" alt="${m.nombre}">
                                    <p class="mt-2">${m.nombre}</p>
                                </div>
                            `).join("")}
                        </div>
                    </div>
                `;
                carouselInner.append(slide);

                // Generar indicador
                indicadores.append(`
                    <button type="button" data-bs-target="#carouselMarcas" data-bs-slide-to="${i}" 
                        ${i === 0 ? 'class="active" aria-current="true"' : ''} aria-label="Slide ${i + 1}">
                    </button>
                `);
            }
        },
        error: function(err) {
            console.error("Error cargando marcas:", err);
        }
    });
}

$(document).ready(function() {
    cargarMarcasCarrusel();
});


