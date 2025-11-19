<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Esencia Real</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Estilos -->
    <link rel="stylesheet" href="../public/css/landing.css">
    <!-- jQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&family=Poppins:wght@500&display=swap" rel="stylesheet">

</head>
<body>
    <div class="container">
        <header>
            <div class="header-content">
                <div class="logo-img">
                    <img src="../files/logo5.jpg">
                    <h2 class="logo-text">Esencia Real</h2>
                </div>
                <div class="right-section">
                    <div class="search-bar">
                        <input type="text" id="searchInput" class="search-input" placeholder="Buscar productos...">
                        <button onclick="searchProducts()" class="btn">
                            <i class="fa fa-search"></i>
                        </button>
                    </div>
                    <!-- Iniciar sesión -->
                    <div class="login-icon" onclick="openLoginModal()">
                        <i class="fa fa-user"></i>
                    </div>
                </div>
            </div>
        </header>

        <!-- ==== CARRUSEL PRINCIPAL ==== -->
        <div id="carouselPrincipal" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
            <div class="carousel-inner">

                <div class="carousel-item active">
                <img src="../files/banner1.jpg" class="d-block w-100" alt="Perfume 1">
                </div>

                <div class="carousel-item">
                <img src="../files/banner2.jpg" class="d-block w-100" alt="Perfume 2">
                </div>

                <div class="carousel-item">
                <img src="../files/banner3.jpg" class="d-block w-100" alt="Perfume 3">
                </div>

                <div class="carousel-item">
                <img src="../files/banner4.jpg" class="d-block w-100" alt="Perfume 4">
                </div>

            </div>

            <!-- Controles -->
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselPrincipal" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </button>

            <button class="carousel-control-next" type="button" data-bs-target="#carouselPrincipal" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Siguiente</span>
            </button>

            <!-- Indicadores -->
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselPrincipal" data-bs-slide-to="0" class="active" aria-current="true"></button>
                <button type="button" data-bs-target="#carouselPrincipal" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#carouselPrincipal" data-bs-slide-to="2"></button>
                <button type="button" data-bs-target="#carouselPrincipal" data-bs-slide-to="3"></button>
            </div>
        </div>



        <div class="filters">
            <h3>Filtros</h3>
            <div class="filter-group">
                <select id="categoryFilter" class="filter-select" onchange="loadProducts()">
                    <option value="">Todas las categorías</option>
                    <!-- Las categorías se cargan dinámicamente -->
                </select>
                <select id="marcaFilter" class="filter-select" onchange="loadProducts()">
                    <option value="">Todas las marcas</option>
                    <!-- Filtro de marcas - se puede implementar más adelante -->
                </select>
                <select id="priceFilter" class="filter-select" onchange="loadProducts()">
                    <option value="">Filtrar por Precios</option>
                    <option value="1000-50000">$0 - $50.000</option>
                    <option value="50000-100000">$50.000 - $100.000</option>
                    <option value="100000-200000">$100.000 - $200.000</option>
                    <option value="200000+">+ $200.000</option>
                </select>
                <select id="sortFilter" class="filter-select" onchange="loadProducts()">
                    <option value="">Ordenar por</option>
                    <option value="name_asc">Nombre A-Z</option>
                    <option value="name_desc">Nombre Z-A</option>
                    <option value="price_asc">Precio menor a mayor</option>
                    <option value="price_desc">Precio mayor a menor</option>
                </select>
                <button onclick="clearFilters()" class="btn">Limpiar filtros</button>
            </div>
        </div>

        <!-- Mensajes de estado -->
        <div id="loadingMessage" class="loading" style="display: none;">
            Cargando productos... ⏳
        </div>

        <div id="errorMessage" class="error-message" style="display: none;"></div>
        <div id="successMessage" class="success-message" style="display: none;"></div>

        <!-- Contenedor de productos - se llena dinámicamente -->
        <div id="productsContainer" class="products-grid">
            <!-- Los productos se cargan aquí dinámicamente -->
        </div>

        <!-- Paginación -->
        <div id="pagination" class="pagination">
            <!-- La paginación se genera dinámicamente -->
        </div>
    </div>

    <!-- Icono del carrito -->
    <div class="cart-icon" onclick="viewCart()">
        🛒 Carrito <span id="cartCount" class="cart-count">0</span>
    </div>

    <div id="productModal" class="product-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modalProductName"></h2>
                <button class="modal-close" onclick="cerrarModal()">&times;</button>
            </div>
            <div class="modal-body">
                <div class="product-image-large" id="modalProductImage"></div>
                <div class="product-details">
                    <p class="product-category" id="modalProductCategory"></p>
                    <p class="product-marca" id="modalProductMarca"></p>
                    <p class="product-description" id="modalProductDescription"></p>
                    <p class="product-price" id="modalProductPrice"></p>
                    <p class="product-stock" id="modalProductStock"></p>
                    <button id="modalAddToCartBtn" class="add-to-cart" onclick="">
                        Agregar al Carrito
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de inicio de sesión -->
    <div id="loginModal" class="login-modal">
        <div class="login-modal-content">
            <div class="login-modal-header">
                <h2>Iniciar sesión</h2>
                <button class="modal-close" onclick="closeLoginModal()">&times;</button>
            </div>
            <form id="loginForm">
                <div class="input-group">
                    <label for="loginEmail">Email</label>
                    <input type="email" id="loginEmail" name="email" required>
                </div>
                <div class="input-group">
                    <label for="loginPassword">Contraseña</label>
                    <input type="password" id="loginPassword" name="password" required>
                </div>
                <button type="submit" class="btn">Ingresar</button>
                <p id="loginMessage" class="login-message"></p>
                <div style="text-align: center; margin-top: 10px;">
                    <button class="btn secondary" onclick="openRegisterModal()">Registrarse</button>
                </div>

            </form>
        </div>
    </div>

    <!-- ==== MODAL REGISTRO ==== -->
    <div id="registerModal" class="login-modal">
        <div class="login-modal-content">
            <div class="login-modal-header">
                <h2>Crear cuenta</h2>
                <button class="modal-close" onclick="closeRegisterModal()">&times;</button>
            </div>

            <!-- Contenedor grid -->
            <div class="form-grid">
                <div class="input-group">
                    <label>Nombre completo</label>
                    <input type="text" id="regNombre" required>
                </div>
                <div class="input-group">
                    <label>Tipo de documento</label>
                    <input type="text" id="regTipoDoc">
                </div>
                <div class="input-group">
                    <label>N° de documento</label>
                    <input type="text" id="regNumDoc">
                </div>
                <div class="input-group">
                    <label>Dirección</label>
                    <input type="text" id="regDireccion">
                </div>
                <div class="input-group">
                    <label>Teléfono</label>
                    <input type="text" id="regTelefono">
                </div>
                <div class="input-group">
                    <label>Email</label>
                    <input type="email" id="regEmail" required>
                </div>
                <div class="input-group">
                    <label>Contraseña</label>
                    <input type="password" id="regClave" required>
                </div>
                <div class="input-group">
                    <label>Confirmar contraseña</label>
                    <input type="password" id="regClave2" required>
                </div>
            </div>

            <button class="btn" onclick="registrarUsuario()">Registrarse</button>
            <div class="login-message" id="regMessage"></div>
        </div>
    </div>
    <!-- ==== MODAL PERFIL CLIENTE ==== -->
    <div id="perfilModal" class="login-modal">
        <div class="login-modal-content">
            <div class="login-modal-header">
            <h2>👤 Mi Perfil</h2>
            <button class="modal-close" onclick="cerrarPerfilModal()">&times;</button>
            </div>
            <div class="perfil-info">
            <p><strong>Nombre:</strong> <span id="perfilNombre"></span></p>
            <p><strong>Email:</strong> <span id="perfilEmail"></span></p>
            <p><strong>Teléfono:</strong> <span id="perfilTelefono"></span></p>
            <p><strong>Dirección:</strong> <span id="perfilDireccion"></span></p>
            </div>

            <h3>🛍️ Mis compras</h3>
            <div id="perfilCompras">
            <p>Cargando compras...</p>
            </div>

            <button class="btn" onclick="cerrarSesion()">Cerrar sesión</button>
        </div>
    </div>

    <section class="container my-5">
  <h2 class="text-center mb-4">Nuestras Marcas</h2>
  <hr>

  <div id="carouselMarcas" class="carousel slide" data-bs-ride="carousel" data-bs-interval="4000">
    <div class="carousel-inner">
      <!-- Las marcas se cargan dinámicamente por Ajax -->
    </div>

    <!-- Indicadores -->
    <div class="carousel-indicators" id="carousel-indicators-marcas"></div>

    <!-- Controles -->
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselMarcas" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Anterior</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselMarcas" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Siguiente</span>
    </button>
  </div>
</section>

    <footer class="footer-premium">
        <div class="footer-container">
            <!-- Sobre nosotros -->
            <div class="footer-section about">
                <h3>ITVentas</h3>
                <p>Perfumes exclusivos y elegantes para cada momento. La fragancia perfecta que habla por ti.</p>
            </div>

            <!-- Enlaces rápidos -->
            <div class="footer-section links">
                <h3>Enlaces rápidos</h3>
                <ul>
                    <li><a href="#">Inicio</a></li>
                    <li><a href="#">Productos</a></li>
                    <li><a href="#">Promociones</a></li>
                    <li><a href="#">Contacto</a></li>
                </ul>
            </div>

            <!-- Redes sociales -->
            <div class="footer-section social">
                <h3>Síguenos</h3>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-whatsapp"></i></a>
                </div>
            </div>

            <!-- Newsletter -->
            <div class="footer-section newsletter">
                <h3>Suscríbete</h3>
                <p>Recibe promociones exclusivas y novedades de fragancias premium:</p>
                <form id="newsletterForm">
                    <input type="email" placeholder="Tu email" required>
                    <button type="submit">Suscribirse</button>
                </form>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; 2025 ITVentas. Todos los derechos reservados.</p>
        </div>
    </footer>


    <a href="https://wa.me/5493644565925?text=Hola!%20Quiero%20hacer%20una%20consulta"
        class="whatsapp-float" target="_blank">
    <img src="https://upload.wikimedia.org/wikipedia/commons/6/6b/WhatsApp.svg" alt="WhatsApp Logo">

    </a>
    <script>
     // Animación fade-up al aparecer en pantalla
    const observer = new IntersectionObserver(entries => {
    entries.forEach(e => {
    if (e.isIntersecting) e.target.classList.add('visible');
    });
    }, { threshold: 0.2 });


    document.querySelectorAll('.fade-up').forEach(el => observer.observe(el));
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


    <!-- Scripts -->
    <script type="text/javascript" src="scripts/tienda.js"></script>
    
</body>

</html>
