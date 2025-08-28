// presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetario_app/data/providers/receta_provider.dart';
import 'package:recetario_app/data/providers/usuario_provider.dart';
import 'package:recetario_app/presentation/widgets/receta_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    try {
      await context.read<RecetaProvider>().init();
      await context.read<UsuarioProvider>().init();
    } catch (e) {
      // El error se maneja en los providers individualmente
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recetaProvider = context.watch<RecetaProvider>();
    final usuarioProvider = context.watch<UsuarioProvider>();

    return Scaffold(
      appBar: _buildAppBar(usuarioProvider),
      body: _buildBody(recetaProvider, usuarioProvider),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  AppBar _buildAppBar(UsuarioProvider usuarioProvider) {
    return AppBar(
      title: Text(
        'Recetario App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        // Botón de perfil de usuario
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () => _showUserProfile(usuarioProvider),
          tooltip: 'Perfil de usuario',
        ),
        // Botón de búsqueda (placeholder para Fase 2)
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _showSearchPlaceholder(),
          tooltip: 'Buscar recetas',
        ),
        // Menú de opciones
        PopupMenuButton<String>(
          onSelected: (value) => _handleMenuSelection(value, usuarioProvider),
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem(
              value: 'favorites',
              child: ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Favoritos'),
              ),
            ),
            const PopupMenuItem(
              value: 'shopping_list',
              child: ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Lista de compra'),
              ),
            ),
            const PopupMenuItem(
              value: 'settings',
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configuración'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBody(RecetaProvider recetaProvider, UsuarioProvider usuarioProvider) {
    if (recetaProvider.isLoading || usuarioProvider.isLoading) {
      return _buildLoadingState();
    }

    if (recetaProvider.error != null) {
      return _buildErrorState(recetaProvider);
    }

    if (recetaProvider.recetas.isEmpty) {
      return _buildEmptyState();
    }

    return _buildRecipesList(recetaProvider);
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Cargando recetas...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(RecetaProvider recetaProvider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error al cargar recetas',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              recetaProvider.error ?? 'Error desconocido',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => recetaProvider.init(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay recetas disponibles',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Añade algunas recetas para comenzar',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.read<RecetaProvider>().init(),
              child: const Text('Cargar recetas de ejemplo'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipesList(RecetaProvider recetaProvider) {
    return RefreshIndicator(
      onRefresh: () async {
        await recetaProvider.init();
      },
      child: Column(
        children: [
          // Header con información
          _buildListHeader(recetaProvider),
          // Lista de recetas
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: recetaProvider.recetas.length,
              itemBuilder: (context, index) {
                final receta = recetaProvider.recetas[index];
                return RecetaCard(
                  receta: receta,
                  onTap: () => _showRecipeDetails(receta),
                  onFavorite: (isFavorite) => _toggleFavorite(receta.id, isFavorite),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader(RecetaProvider recetaProvider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${recetaProvider.recetas.length} recetas disponibles',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          // Filtros simples (placeholder para Fase 2)
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFiltersPlaceholder(),
            tooltip: 'Filtrar recetas',
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => _onItemTapped(index),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Descubrir',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: 'Favoritos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'Compra',
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _addNewRecipe,
      tooltip: 'Añadir nueva receta',
      child: const Icon(Icons.add),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navegación placeholder para otras secciones
    switch (index) {
      case 1:
        _showDiscoverPlaceholder();
        break;
      case 2:
        _showFavoritesPlaceholder();
        break;
      case 3:
        _showShoppingListPlaceholder();
        break;
    }
  }

  void _showRecipeDetails(receta) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(receta.nombre),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (receta.urlImagen != null)
                Image.network(
                  receta.urlImagen!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              Text(
                'Ingredientes:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ...receta.ingredientes.map((ingrediente) => Text(
                    '• ${ingrediente.nombre}: ${ingrediente.cantidad} ${ingrediente.unidad}',
                  )),
              const SizedBox(height: 16),
              Text(
                'Preparación:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              ...receta.pasos.map((paso) => Text('• $paso')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<UsuarioProvider>().addToHistorial(receta.id);
              Navigator.pop(context);
            },
            child: const Text('Añadir al historial'),
          ),
        ],
      ),
    );
  }

  void _toggleFavorite(String recipeId, bool isFavorite) {
    // Placeholder para funcionalidad de favoritos (Fase 2)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFavorite ? 'Añadido a favoritos' : 'Eliminado de favoritos'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showUserProfile(UsuarioProvider usuarioProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Perfil de Usuario'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${usuarioProvider.usuario.nombre}'),
            Text('Tipo alimentación: ${usuarioProvider.usuario.tipoAlimentacion}'),
            Text('Comensales: ${usuarioProvider.usuario.comensales}'),
            const SizedBox(height: 16),
            const Text('Intolerancias:'),
            ...usuarioProvider.usuario.intolerancias.map((intol) => Text('• $intol')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _addNewRecipe() {
    // Placeholder para añadir receta (Fase 3)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Añadir Receta'),
        content: const Text('Funcionalidad disponible en la Fase 3'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleMenuSelection(String value, UsuarioProvider usuarioProvider) {
    switch (value) {
      case 'favorites':
        _showFavoritesPlaceholder();
        break;
      case 'shopping_list':
        _showShoppingListPlaceholder();
        break;
      case 'settings':
        _showSettings(usuarioProvider);
        break;
    }
  }

  void _showSearchPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Buscador disponible en la Fase 2'),
      ),
    );
  }

  void _showFiltersPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filtros disponibles en la Fase 2'),
      ),
    );
  }

  void _showDiscoverPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Descubrir disponible en la Fase 2'),
      ),
    );
  }

  void _showFavoritesPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Favoritos disponibles en la Fase 2'),
      ),
    );
  }

  void _showShoppingListPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lista de compra disponible en la Fase 3'),
      ),
    );
  }

  void _showSettings(UsuarioProvider usuarioProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configuración'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Editar perfil'),
              onTap: () {
                Navigator.pop(context);
                _editProfile(usuarioProvider);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificaciones'),
              onTap: () => _showNotificationsPlaceholder(),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Acerca de'),
              onTap: () => _showAboutDialog(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _editProfile(UsuarioProvider usuarioProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Perfil'),
        content: const Text('Editor de perfil disponible en la Fase 3'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showNotificationsPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notificaciones disponibles en la Fase 5'),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Acerca de Recetario App'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Versión: 1.0.0 (Fase 1 - MVP)'),
            SizedBox(height: 8),
            Text('Desarrollado con Flutter & Dart'),
            SizedBox(height: 8),
            Text('¡Bienvenido a la primera fase de la aplicación!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}