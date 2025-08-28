# recetario_app


🟢 Fase 1 – MVP (Producto Mínimo Viable)
Objetivo: Tener algo que se pueda abrir en el móvil y usar, aunque sea básico.
•	Pantallas mínimas:
o	Pantalla de inicio / splash con el logo y nombre de la app.
o	Menú principal (por ahora con solo 2 botones funcionales).
o	Listado de recetas cargadas desde un JSON local (assets).
o	Detalle de receta con título, ingredientes y pasos.
👉 Con esto ya puedes ver recetas en tu móvil sin depender de internet ni APIs.

🟡 Fase 2 – Interactividad básica
•	Buscador por nombre/ingrediente (filtrado de la lista local).
•	Favoritos: marcar recetas con un icono de estrella y guardarlas en memoria local (SharedPreferences).
•	**Diseño inicial en modo Dark Theme para motivarte visualmente.
👉 Aquí ya tienes la primera sensación de “app personalizada”.

🔵 Fase 3 – Expansión de funcionalidades
•	Formulario de alta de receta (crear recetas desde la app).
•	Edición y eliminación de recetas (CRUD básico).
•	Persistencia en SQLite o Hive en vez de JSON.
•	Categorías: mostrar filtros por “Tipo de plato”, “Duración”, “Dificultad”.
👉 Ya no dependes de un archivo, la app tiene datos dinámicos.

🟣 Fase 4 – Servicios externos y valor añadido
•	Integrar API de Open Food Facts para información nutricional.
•	Generar lista de la compra según recetas seleccionadas y comensales.
•	Traducción automática de recetas (con LibreTranslate, como ya usaste en tu otro proyecto).
👉 Aquí la app empieza a diferenciarse de una libreta de recetas normal.

🔴 Fase 5 – Optimización y experiencia de usuario
•	Perfil de usuario: preferencias (vegetariano, alergias, intolerancias).
•	Diseño más pulido con Material 3 y animaciones.
•	Backup en la nube (Google Drive o Firebase).
•	Compartir recetas con otros usuarios.
👉 Esta fase ya te da un producto con “sentido social”.

✅ Estrategia motivacional
1.	Divide el trabajo en micro-logros (ejemplo: “hoy hago el buscador”, “hoy creo favoritos”).
2.	Prueba en móvil real después de cada mini-fase → ver el resultado motiva mucho.
3.	Documenta lo que haces (README en GitHub, capturas de pantalla).
4.	Piensa siempre en la siguiente fase, pero disfruta la actual.


📂 Esqueleto inicial del proyecto Flutter
recetario_app/
│
├── android/              # Archivos específicos de Android (generados por Flutter)
├── ios/                  # Archivos específicos de iOS (generados por Flutter)
├── web/                  # Soporte para web
├── linux/                # Soporte escritorio
├── macos/                # Soporte escritorio
├── windows/              # Soporte escritorio
│
├── assets/               # Recursos estáticos
│   ├── images/           # Logos, iconos, banners
│   └── translations/     # Archivos JSON para i18n (ej. ES, EN, FR)
│
├── lib/                  # Código principal en Dart
│   ├── main.dart         # Punto de entrada de la app
│   │
│   ├── core/             # Base y utilidades
│   │   ├── theme/        # Colores, tipografía, estilos
│   │   ├── config/       # Configuración global, constantes
│   │   ├── utils/        # Funciones helper, validaciones
│   │   └── services/     # Conexión API, persistencia local
│   │
│   ├── data/             # Modelos y repositorios
│   │   ├── models/       # Clases Receta, Ingrediente, Usuario, etc.
│   │   └── repositories/ # Interfaces para acceder a datos (API, local)
│   │
│   ├── presentation/     # Interfaz de usuario
│   │   ├── screens/      # Pantallas principales
│   │   │   ├── home/
│   │   │   ├── recetas/
│   │   │   ├── detalle_receta/
│   │   │   ├── favoritos/
│   │   │   └── perfil_usuario/
│   │   ├── widgets/      # Componentes reutilizables (cards, botones, buscador)
│   │   └── navigation/   # Rutas, control de navegación
│   │
│   └── state/            # Manejo de estado
│       ├── providers/    # Providers para Riverpod/Provider/Bloc
│       └── controllers/  # Controladores de cada módulo
│
├── pubspec.yaml          # Configuración de dependencias y assets
└── README.md             # Documentación del proyecto
 

⚙️ Funcionalidad mínima (MVP inicial)
El primer objetivo es que la app funcione y muestre algo real desde el inicio. Se recomienda un MVP en 4 fases progresivas:
✅ Fase 1: App básica con navegación
•	Pantalla Home con menú (ej. “Recetas”, “Favoritos”, “Perfil”).
•	Navegación entre pantallas con GoRouter o Navigator.
•	Estilo inicial con tema de colores y tipografía definidos.
✅ Fase 2: Cargar recetas locales (JSON en assets/)
•	Modelo Receta (id, nombre, ingredientes, pasos, dificultad).
•	Cargar recetas desde un archivo recetas.json.
•	Mostrar lista de recetas en cards.
✅ Fase 3: Detalle de receta
•	Pantalla con:
o	Nombre, ingredientes, pasos, tiempo.
o	Botón “Agregar a favoritos”.
✅ Fase 4: Persistencia local
•	Guardar favoritos en SharedPreferences o Hive.
•	Permitir que al cerrar y abrir la app se mantengan.

📡 Flujo de datos simplificado (primeras funciones)
1.	Inicio de la app main.dart carga configuración → inicializa tema y servicios → abre pantalla HomeScreen.
2.	Carga de recetas RecetaRepository lee archivo assets/recetas.json → devuelve lista de objetos Receta.
3.	Mostrar en pantalla HomeScreen obtiene recetas del repositorio → muestra lista con RecetaCard.
4.	Navegación al detalle Usuario pulsa receta → Navigator abre DetalleRecetaScreen con datos de esa receta.
5.	Favoritos
a.	Botón guarda receta en Hive/SharedPreferences.
b.	FavoritosScreen carga los guardados.

📌 Con este esqueleto, en solo la primera semana ya tendrías una app que:
•	Se abre con una pantalla inicial.
•	Carga recetas de un archivo JSON.
•	Te permite navegar y ver detalles.
•	Guarda favoritos de forma persistente.


Informe Técnico del Proyecto “Recetario” – Versión Flutter/Dart
1. Resumen del Proyecto
El proyecto “Recetario” es una aplicación móvil y web multiplataforma desarrollada con Flutter (frontend) y Dart (lógica de negocio y backend interno). La app permitirá gestionar recetas culinarias con información completa (ingredientes, pasos, nutrición, dificultad, tiempo, coste, etc.), realizar búsquedas avanzadas, personalizar perfiles de usuario con intolerancias y tipo de dieta, y generar listas de compra inteligentes.
El enfoque técnico incluye:
•	Frontend Flutter con Material Design.
•	Gestión de estado con provider (o riverpod para mayor escalabilidad).
•	Persistencia local en SQLite o Hive.
•	Servicios externos (API Open Food Facts, traducción Docker/LibreTranslate).
•	Arquitectura limpia con separación de capas: UI, lógica, modelos, servicios, datos.

2. Estructura del Proyecto en Flutter
2.1 Estructura de Directorios
/recetario_app
  /lib
    /main.dart
    /core
      /utils/
      /constants/
      /logging/
    /models
      receta.dart
      usuario.dart
      ingrediente.dart
      nutricion.dart
    /services
      api_service.dart
      open_food_service.dart
      translator_service.dart
      db_service.dart
    /providers
      receta_provider.dart
      usuario_provider.dart
      lista_compra_provider.dart
    /screens
      home_screen.dart
      receta_list_screen.dart
      receta_detail_screen.dart
      buscador_screen.dart
      usuario_screen.dart
      lista_compra_screen.dart
    /widgets
      receta_card.dart
      buscador_form.dart
      lista_compra_item.dart
  /assets
    /images
    /data
      recetas.json
      ingredientes.json
  /test
 

3. Módulos y Funcionalidades
3.1 Módulo models (Entidades del dominio)
Define las clases que representan el modelo de datos.
Clase Receta
•	id
•	nombre
•	url
•	ingredientes (lista de objetos Ingrediente)
•	pasos (lista de cadenas)
•	pais, categoria, contexto
•	valoracion, votos
•	comensales, tiempo, dificultad, coste
•	valorNutricional (objeto Nutricion)
•	utensilios
Clase Usuario
•	nombre
•	intolerancias
•	tipoAlimentacion
•	comensales
•	historialRecetas
Clase Ingrediente
•	nombre
•	cantidad
•	unidad
Clase Nutricion
•	calorias
•	grasas
•	proteinas
•	hidratos
•	micronutrientes (mapa dinámico)

3.2 Módulo services
Encapsula la lógica de negocio y la comunicación con fuentes de datos.
•	api_service.dart: Conexión genérica a APIs.
•	open_food_service.dart: Llamadas a Open Food Facts para nutrición.
•	translator_service.dart: Conexión con LibreTranslate (contenedor Docker).
•	db_service.dart: Persistencia local en Hive/SQLite.
•	logging/: Sistema de logging con logger package.

3.3 Módulo providers (Gestión de estado)
Implementa la lógica reactiva con ChangeNotifier (o Riverpod si se escala).
•	RecetaProvider
o	CRUD de recetas.
o	Búsquedas avanzadas por ingredientes, tiempo, dificultad.
•	UsuarioProvider
o	Preferencias de usuario, intolerancias, dieta.
o	Historial de recetas.
•	ListaCompraProvider
o	Generación de lista de compra.
o	Cálculo dinámico de cantidades por comensales.

3.4 Módulo screens (Interfaces gráficas)
Cada pantalla implementa parte de la aplicación.
•	HomeScreen: Menú principal con navegación.
•	RecetaListScreen: Listado de recetas filtrables y buscables.
•	RecetaDetailScreen: Vista detallada con pasos, ingredientes y nutrición.
•	BuscadorScreen: Motor de búsqueda avanzada.
•	UsuarioScreen: Configuración de perfil de usuario, intolerancias, dieta.
•	ListaCompraScreen: Vista interactiva de lista de compra generada.

3.5 Módulo widgets (Componentes reutilizables)
•	RecetaCard: Tarjeta resumida de receta.
•	BuscadorForm: Formulario de filtros de búsqueda.
•	ListaCompraItem: Item individual de lista de compra.
•	Otros componentes UI reutilizables (botones, inputs, modales).

4. Persistencia de Datos
•	Local: Hive/SQLite para recetas, usuarios e historial.
•	Formato de datos: JSON (importación/exportación).
•	Sincronización futura: integración con Firestore o backend REST.

5. Integraciones Externas
•	Open Food Facts API: obtener nutrición.
•	LibreTranslate (Docker): traducción de recetas a múltiples idiomas.
•	APIs de supermercados (planificado): disponibilidad de productos.

6. Roadmap Técnico
1.	Implementar UI básica en Flutter (pantallas y navegación).
2.	Crear modelos en Dart y pruebas unitarias.
3.	Integrar Hive para persistencia local.
4.	Desarrollar buscador avanzado con filtros dinámicos.
5.	Añadir Open Food Facts API.
6.	Incorporar sistema de logging con logger.
7.	Migrar a Riverpod o Bloc si la complejidad crece.
8.	Desplegar versión web con Flutter Web.
9.	Opcional: Backend con Dart Shelf o Firebase Functions.

7. Buenas Prácticas en Flutter
•	Arquitectura limpia (separación UI – Lógica – Datos).
•	Provider/Riverpod para estado.
•	Código modular y reutilizable.
•	Persistencia híbrida: JSON + DB local.
•	Logging centralizado.
•	Preparación para internacionalización (i18n).

8. Conclusión
El proyecto “Recetario” en Flutter/Dart se transforma en una app móvil/web multiplataforma, escalable, modular y mantenible. Con arquitectura basada en modelos, servicios y gestión de estado, ofrece flexibilidad para integrar APIs externas y futuras expansiones como menús semanales, control de calorías y conexión con supermercados.
                

Esquema Arquitectura Proyecto “Recetario” (Flutter/Dart)
                          ┌───────────────────────┐
                          │       main.dart       │
                          │ Inicialización App    │
                          │ - runApp(MyApp)       │
                          │ - Config Providers    │
                          │ - Routing/Navegación  │
                          └─────────┬─────────────┘
                                    │
               ┌────────────────────┴──────────────────────┐
               │                                           │
        ┌──────▼───────┐                           ┌───────▼────────┐
        │   /screens   │                           │   /providers   │
        │ UI Flutter   │                           │ State Mgmt     │
        └──────┬───────┘                           └───────┬────────┘
               │                                           │
───────────────┼───────────────────────────────────────────┼───────────────
               │                                           │
     ┌─────────▼─────────┐                       ┌─────────▼─────────┐
     │ HomeScreen        │                       │ RecetaProvider     │
     │ Menú principal    │                       │ - CRUD recetas     │
     ├───────────────────┤                       │ - búsqueda         │
     │ RecetaListScreen  │                       └─────────┬─────────┘
     │ Listado recetas   │                                 │
     ├───────────────────┤                       ┌─────────▼─────────┐
     │ RecetaDetailScreen│                       │ UsuarioProvider    │
     │ Vista detallada   │                       │ - perfil usuario   │
     ├───────────────────┤                       │ - intolerancias    │
     │ BuscadorScreen    │                       │ - dieta/comensales │
     │ Filtros avanzados │                       └─────────┬─────────┘
     ├───────────────────┤                                 │
     │ UsuarioScreen     │                       ┌─────────▼─────────┐
     │ Perfil usuario    │                       │ ListaCompraProvider│
     ├───────────────────┤                       │ - lista ingredientes│
     │ ListaCompraScreen │                       │ - cálculo dinámico  │
     │ Ingredientes      │                       └─────────────────────┘
     └───────────────────┘
 
──────────────────────────────────────────────────────────────────────────────
 
                   ┌────────────────────────────────────┐
                   │              /models               │
                   │  Definición de entidades (POJO)    │
                   └───────────┬────────────────────────┘
                               │
          ┌────────────────────┼──────────────────────┐
          │                    │                      │
  ┌───────▼───────┐     ┌──────▼───────┐       ┌──────▼───────┐
  │   Receta       │     │   Usuario    │       │ Ingrediente  │
  │ id, nombre     │     │ nombre       │       │ nombre       │
  │ ingredientes[] │     │ intolerancias│       │ cantidad     │
  │ pasos[]        │     │ tipoAlim.    │       │ unidad       │
  │ pais, cat, ctx │     │ comensales   │       └──────────────┘
  │ nutricion      │     │ historial    │
  └───────┬────────┘     └──────┬──────┘
          │                     │
  ┌───────▼─────────┐   ┌───────▼─────────┐
  │   Nutricion     │   │   Historial     │
  │ calorias        │   │ recetas usadas  │
  │ grasas, prot, HC│   └─────────────────┘
  └─────────────────┘
 
──────────────────────────────────────────────────────────────────────────────
 
                          ┌────────────────────────┐
                          │        /services       │
                          │  Lógica de negocio     │
                          └──────────┬─────────────┘
                                     │
       ┌─────────────────────────────┼──────────────────────────────┐
       │                             │                              │
┌──────▼─────────┐           ┌───────▼──────────┐           ┌───────▼──────────┐
│ ApiService     │           │ DbService        │           │ OpenFoodService  │
│ Cliente genérico│          │ Persistencia     │           │ API Nutrición    │
│ REST, GET/POST │           │ SQLite / Hive    │           │ kcal, macros     │
└──────┬─────────┘           └───────┬──────────┘           └───────┬──────────┘
       │                              │                              │
┌──────▼─────────────┐        ┌───────▼──────────┐          ┌───────▼──────────┐
│ TranslatorService  │        │ LoggingService   │          │ SupermercadoAPI* │
│ Docker LibreTransl │        │ logger package   │          │ Disponibilidad   │
│ i18n recetas       │        │ errores/eventos  │          │ productos        │
└────────────────────┘        └─────────────────┘          └───────────────────┘
*(planificado)
 
──────────────────────────────────────────────────────────────────────────────
 
                           ┌──────────────────────────┐
                           │        /widgets          │
                           │ UI Reutilizable          │
                           └──────────┬───────────────┘
                                      │
             ┌────────────────────────┼───────────────────────────┐
             │                        │                           │
   ┌─────────▼─────────┐    ┌─────────▼─────────┐       ┌─────────▼─────────┐
   │ RecetaCard         │    │ BuscadorForm      │       │ ListaCompraItem   │
   │ Muestra resumen    │    │ filtros dinámicos │       │ item ingrediente  │
   │ img, título, tags  │    │ input avanzado    │       │ qty + unidad      │
   └────────────────────┘    └───────────────────┘       └───────────────────┘


🔑 Explicación del Esquema
•	main.dart: punto de entrada, configura proveedores y navegación.
•	screens: vistas principales, cada una corresponde a una función de la app.
•	providers: controlan el estado y la lógica que conecta UI ↔ servicios.
•	models: definen entidades del dominio (receta, usuario, ingredientes, nutrición).
•	services: encapsulan lógica de negocio y acceso a datos (APIs, DB local, traducción).
•	widgets: componentes reutilizables de UI.

Perfecto, Jose Luis. Aquí tienes el flujo de datos paso a paso (end-to-end) de todas las funciones y servicios que intervienen en la app Flutter/Dart “Recetario”. Está en texto plano, técnico y estructurado para copiar/pegar.

Flujo de Datos Paso a Paso — Proyecto “Recetario” (Flutter/Dart)
0) Convenciones
•	UI = screens + widgets
•	Estado = providers (ChangeNotifier/Riverpod)
•	Servicios = services (APIs, DB, utilidades)
•	Modelos = models (POJOs con fromJson/toJson)
•	Todo I/O es asíncrono (Future, Stream).
•	Logging centralizado en LoggingService.

1) Arranque de la app (bootstrap)
1.	main.dart
a.	WidgetsFlutterBinding.ensureInitialized()
b.	LoggingService.init()
c.	DbService.init() (Hive/SQLite, apertura de cajas/tablas)
d.	EnvService.load() (claves API, endpoints)
e.	RecetaProvider.init() → DbService.getAllRecetas() (cache local)
f.	UsuarioProvider.init() → DbService.getUsuarioActivo()
g.	ListaCompraProvider.init() → DbService.getListaCompra()
2.	Estado notifica (notifyListeners) y UI inicial (Home) se construye.
3.	Si no hay datos locales, SeedService.loadAssetsJSON() y persistencia inicial.
4.	Errores: try/catch → LoggingService.error() → UI banner offline.
Funciones implicadas:
•	DbService.init/openBox/openDB
•	RecetaProvider.init, UsuarioProvider.init, ListaCompraProvider.init
•	SeedService.loadAssetsJSON
•	LoggingService.init/error/info

2) Listado de recetas (Home/RecetaListScreen)
Flujo:
1.	UI solicita lista paginada/filtrada: RecetaProvider.fetch({page, pageSize, sort, filters}).
2.	Provider decide origen:
a.	Local: DbService.queryRecetas(spec) (con índice, sort)
b.	(Opcional futuro) Remoto: ApiService.get('/recetas', query)
3.	Normalización y mapeo: TextNormalizer.normalize() en campos clave para búsqueda.
4.	Caching in-memory del último QuerySpec.
5.	Devuelve List<Receta> → notifyListeners → UI renderiza.
Funciones:
•	RecetaProvider.fetch/query/refresh
•	DbService.queryRecetas
•	ApiService.get (si aplica)
•	TextNormalizer.normalize

3) Búsqueda avanzada (BuscadorScreen)
Flujo:
1.	Usuario cambia filtros → BuscadorForm.onChanged con debounce(300ms).
2.	RecetaProvider.search(filters):
a.	Construye QuerySpec (ingredientesIncluidos/excluidos, dificultad, tiempo, valoración, país, categoría, dieta).
b.	DbService.searchRecetas(QuerySpec) devuelve candidatos.
c.	Ranking: SearchRanker.score(receta, filters) (peso por coincidencia de ingredientes, penalización por intolerancias, tiempo, dificultad, rating).
3.	Aplica UserConstraints de UsuarioProvider (intolerancias/tipo dieta).
4.	Entrega results ordenados → UI.
Funciones:
•	RecetaProvider.search
•	DbService.searchRecetas
•	SearchRanker.score
•	UsuarioProvider.getConstraints
•	TextNormalizer.tokens/containsAll

4) Detalle de receta (RecetaDetailScreen)
Flujo:
1.	UI navega con recetaId.
2.	RecetaProvider.getById(id):
a.	Busca en cache → si no, DbService.getReceta(id).
3.	Si falta nutrición o está desactualizada:
a.	OpenFoodService.enrichNutrition(receta.ingredientes):
i.	Normaliza ingredientes (IngredientNormalizer).
ii.	Consulta Open Food Facts por ingrediente (con fallback a equivalencias).
iii.	Calcula macros totales/unidad/ración (NutritionMath.scaling).
b.	Actualiza receta → DbService.upsertReceta(recetaAct) → notifyListeners.
4.	UI muestra ficha: pasos, ingredientes, nutrición, tiempo, dificultad.
Funciones:
•	RecetaProvider.getById/updateNutritionIfNeeded
•	DbService.getReceta/upsertReceta
•	OpenFoodService.lookup(...) / enrichNutrition(...)
•	IngredientNormalizer, NutritionMath.scaling

5) Generación de lista de la compra (ListaCompraScreen)
Flujo:
1.	Usuario selecciona recetas y comensales (del perfil): ListaCompraProvider.generate(selectedRecetas, comensales).
2.	Para cada receta:
a.	UnitConverter.scale(ingrediente, factor = comensales / receta.comensales)
b.	IngredientNormalizer.normalizeName(unificado)
3.	Agrupación por ingrediente:
a.	Aggregate.byNameAndUnit (suma cantidades; conversión kg/g, l/ml…).
4.	(Opcional) Disponibilidad:
a.	SupermercadoAPI.checkAvailability(items) (planificado).
5.	Guarda lista:
a.	DbService.saveListaCompra(lista) → notifyListeners.
6.	UI permite marcar comprado, notas, exportar.
Funciones:
•	ListaCompraProvider.generate/toggleChecked/save/export
•	UnitConverter.scale/convert
•	Aggregate.merge
•	DbService.saveListaCompra/getListaCompra
•	SupermercadoAPI.checkAvailability (plan)

6) Perfil de usuario (UsuarioScreen)
Flujo:
1.	Usuario cambia intolerancias, tipoAlimentacion, comensales.
2.	UsuarioProvider.updatePerfil(update):
a.	Valida (UserValidator).
b.	DbService.saveUsuario(usuario) → notifyListeners.
3.	RecetaProvider.applyUserConstraints():
a.	Recalcula filtros activos y fuerza re-búsqueda si procede.
4.	UI refresca listados con restricciones activas.
Funciones:
•	UsuarioProvider.updatePerfil/getConstraints
•	UserValidator.validate
•	DbService.saveUsuario/getUsuarioActivo
•	RecetaProvider.applyUserConstraints

7) CRUD de recetas (alta/edición/baja)
Alta/Edición
1.	Formulario envía RecetaDraft.
2.	RecetaProvider.upsert(recetaDraft):
a.	RecetaValidator.validate(recetaDraft)
b.	RecetaMapper.fromDraft(draft) → Receta
c.	DbService.upsertReceta(receta)
d.	SearchIndexer.index(receta) (tokens, campos clave)
e.	notifyListeners
3.	UI confirma y retorna a listado/detalle.
Baja
1.	RecetaProvider.delete(id):
a.	DbService.deleteReceta(id)
b.	SearchIndexer.remove(id)
c.	ListaCompraProvider.removeItemsFromReceta(id) (consistencia)
d.	notifyListeners
Funciones:
•	RecetaProvider.upsert/delete
•	RecetaValidator, RecetaMapper
•	DbService.upsertReceta/deleteReceta
•	SearchIndexer.index/remove
•	ListaCompraProvider.removeItemsFromReceta

8) Importación/Exportación (JSON/CSV)
Importar
1.	UI selecciona archivo.
2.	ImportService.parse(file):
a.	Detecta formato (CSV/JSON), mapea columnas (SchemaMapper), normaliza textos.
b.	Devuelve List<Receta>.
3.	RecetaProvider.bulkUpsert(recetas):
a.	Transacción: DbService.transaction(() => upsert*)
b.	Indexado en lote.
4.	Reporte de incidencias a LoggingService.
Exportar
1.	UI → ExportService.toJSON(recetasSeleccionadas | all).
2.	Guarda en almacenamiento local/compartir.
Funciones:
•	ImportService.parse/map/normalize
•	DbService.transaction
•	RecetaProvider.bulkUpsert
•	ExportService.toJSON/toCSV

9) Traducción (LibreTranslate en Docker)
Flujo:
1.	Usuario activa traducción de una receta: TranslatorService.translateReceta(receta, toLocale).
2.	Segmentación: título, pasos, ingredientes → lotes (Batcher).
3.	Llamadas POST al endpoint local: TranslatorService.post(texts, from, to).
4.	Reintentos con backoff exponencial y control de cuota.
5.	Unión de resultados y guardado en receta.traducciones[toLocale].
6.	DbService.upsertReceta → notifyListeners.
Funciones:
•	TranslatorService.translateText/translateReceta
•	Batcher.split/join
•	DbService.upsertReceta
•	LoggingService.warn/error en fallos

10) Enriquecimiento nutricional (Open Food Facts)
Flujo:
1.	OpenFoodService.enrichNutrition(ingredientes):
a.	Normaliza nombres → IngredientNormalizer.
b.	Consulta por ingrediente/código (si disponible).
c.	Mapea 100g → porción usando UnitConverter.
d.	Agrega macros a nivel receta (NutritionMath.sum).
2.	Guarda en receta.valorNutricional + timestamp updatedAt.
3.	Persistencia y notificación al UI.
Funciones:
•	OpenFoodService.lookup/byName/byBarcode
•	NutritionMath.sum/scaling
•	DbService.upsertReceta

11) Cache, offline y sincronización
1.	Toda lectura prioriza cache local (DbService).
2.	Si API falla → fallback a datos previos, UIBanner.offline = true.
3.	Marcadores de “desincronizado” en registros modificados (syncPending = true).
4.	Worker de sincronización: SyncService.flush() cuando hay red.
Funciones:
•	SyncService.flush
•	ConnectivityService.onStatusChange
•	DbService.markSyncPending/clearPending

12) Logging, métricas y trazabilidad
1.	LoggingService intercepta:
a.	Entradas/salidas de services (nivel DEBUG).
b.	Errores de validación e I/O (nivel ERROR).
c.	Métricas (duración de búsquedas, llamadas API).
2.	Logs persistidos en archivo local + consola debug.
Funciones:
•	LoggingService.debug/info/warn/error
•	PerformanceTimer.track(label, fn)

13) Configuración y parámetros (Settings/i18n)
1.	SettingsProvider:
a.	Tema, idioma, unidades (métricas/imperiales), flags.
b.	DbService.saveSettings/getSettings.
2.	I18nService:
a.	Carga ARB/JSON de localizaciones.
b.	Interfaz con TranslatorService para contenidos dinámicos.
Funciones:
•	SettingsProvider.update/get
•	DbService.saveSettings
•	I18nService.t/locale

14) Seguridad y privacidad (si hay backend remoto—opcional)
1.	AuthService (JWT/OAuth) obtiene token.
2.	ApiService añade Authorization header.
3.	SecureStorage guarda tokens cifrados.
Funciones:
•	AuthService.login/refresh/logout
•	ApiService.setAuthHeader
•	SecureStorage.write/read/delete

15) Pruebas (unitarias/integración)
•	Modelos: fromJson/toJson, validadores, normalizadores.
•	Services: DbService, OpenFoodService (con HttpClient mock), TranslatorService.
•	Providers: lógica de filtros, ranking, escalado comensales.
•	Golden tests de widgets críticos.

Catálogo de Interfaces (resumen funcional)
Providers
•	RecetaProvider
o	Future<void> init()
o	Future<List<Receta>> fetch({QuerySpec spec})
o	Future<List<Receta>> search(Filters filters)
o	Future<Receta?> getById(String id)
o	Future<void> upsert(RecetaDraft draft)
o	Future<void> delete(String id)
o	Future<void> bulkUpsert(List<Receta> recetas)
o	void applyUserConstraints(UserConstraints c)
•	UsuarioProvider
o	Future<void> init()
o	User get usuario
o	Future<void> updatePerfil(UserUpdate update)
o	UserConstraints getConstraints()
•	ListaCompraProvider
o	Future<void> init()
o	Future<ListaCompra> generate(List<Receta> recetas, int comensales)
o	Future<void> save(ListaCompra lista)
o	void toggleChecked(ItemId id)
o	void removeItemsFromReceta(String recetaId)
•	SettingsProvider
o	Future<void> load()
o	Future<void> update(Settings s)
Services
•	DbService
o	Future<void> init()/transaction(...)
o	Future<List<Receta>> queryRecetas(QuerySpec q)
o	Future<List<Receta>> searchRecetas(QuerySpec q)
o	Future<void> upsertReceta(Receta r)
o	Future<void> deleteReceta(String id)
o	Future<User> getUsuarioActivo()/saveUsuario(User u)
o	Future<ListaCompra> getListaCompra()/saveListaCompra(ListaCompra l)
o	Future<Settings> getSettings()/saveSettings(Settings s)
•	ApiService
o	Future<HttpResponse> get/post/put/delete(String path, {Map query, body})
•	OpenFoodService
o	Future<Nutricion> enrichNutrition(List<Ingrediente> ing)
o	Future<Nutriente?> lookupByName(String q)
o	Future<Nutriente?> lookupByBarcode(String code)
•	TranslatorService
o	Future<String> translateText(String text, {String from, String to})
o	Future<Receta> translateReceta(Receta r, String toLocale)
•	SearchRanker
o	double score(Receta r, Filters f)
•	UnitConverter
o	Cantidad scale(Cantidad c, double factor)
o	Cantidad convert(Cantidad c, Unidad to)
•	TextNormalizer/IngredientNormalizer
o	String normalize(String s)
o	String canonicalName(String ingrediente)
•	ImportService/ExportService
o	List<Receta> parse(File f)
o	File toJSON(List<Receta> rs)
o	File toCSV(List<Receta> rs)
•	SyncService, ConnectivityService, LoggingService, PerformanceTimer

Secuencias Textuales (resumen por caso de uso)
1.	Buscar por ingredientes
•	UI(BuscadorForm) → RecetaProvider.search(filters) → DbService.searchRecetas → SearchRanker.score → UsuarioProvider.getConstraints → RecetaProvider emite estado → UI renderiza.
2.	Abrir detalle y enriquecer nutrición
•	UI(RecetaDetail) → RecetaProvider.getById → (faltan macros) → OpenFoodService.enrichNutrition → DbService.upsertReceta → RecetaProvider notifica → UI actualiza.
3.	Generar lista de compra
•	UI(ListaCompra) → ListaCompraProvider.generate(recetas, comensales) → UnitConverter.scale/convert → Aggregate.merge → DbService.saveListaCompra → UI muestra lista.
4.	Actualizar perfil usuario
•	UI(UsuarioScreen) → UsuarioProvider.updatePerfil → DbService.saveUsuario → RecetaProvider.applyUserConstraints → UI refresca listados.
5.	Importar recetas
•	UI(Import) → ImportService.parse → RecetaProvider.bulkUpsert (→ DbService.transaction + indexer) → UI confirma.
6.	Traducir receta
•	UI(Detalle → Traducir) → TranslatorService.translateReceta (batch + backoff) → DbService.upsertReceta → UI muestra pestaña idioma.
7.	Modo offline
•	ConnectivityService.onStatusChange(false) → UI banner offline → todas las lecturas contra DbService → SyncService.flush() al recuperar conexión.

Reglas de negocio clave (resumen)
•	Filtros siempre respetan UserConstraints (intolerancias/dieta).
•	Búsqueda pondera coincidencia de ingredientes > tiempo/dificultad > rating.
•	Lista de compra agrupa por nombre canónico + unidad canónica.
•	Nutrición se calcula a partir de 100g/ml y se escala por ración/comensal.
•	Logs para toda operación I/O y errores de validación.



