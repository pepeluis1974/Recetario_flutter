import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetario_app/data/providers/receta_provider.dart';
import 'package:recetario_app/data/providers/usuario_provider.dart';
import 'package:recetario_app/data/services/logging_service.dart';
import 'package:recetario_app/presentation/screen/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await LoggingService.init();
    LoggingService.info('Aplicación inicializada correctamente');
    
    runApp(MyApp());
  } catch (e) {
    debugPrint('Error durante la inicialización: $e');
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecetaProvider()),
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        // ListaCompraProvider puede comentarse temporalmente para Fase 1
        // ChangeNotifierProvider(create: (_) => ListaCompraProvider()),
      ],
      child: MaterialApp(
        title: 'Recetario App - Fase 1',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}