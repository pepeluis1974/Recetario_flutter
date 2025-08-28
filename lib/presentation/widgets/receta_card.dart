// presentation/widgets/receta_card.dart - Widget para mostrar receta en lista
import 'package:flutter/material.dart';
import 'package:recetario_app/data/models/receta.dart';

class RecetaCard extends StatelessWidget {
  final Receta receta;
  final VoidCallback onTap;
  final Function(bool)? onFavorite; // Añadir este parámetro

  const RecetaCard({
    super.key,
    required this.receta,
    required this.onTap,
    this.onFavorite, // Hacerlo opcional para compatibilidad
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen de la receta (si existe)
              if (receta.urlImagen != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    receta.urlImagen!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => 
                      Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: const Icon(Icons.fastfood, size: 50),
                      ),
                  ),
                )
              else
                Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Icon(Icons.fastfood, size: 50),
                ),
              
              const SizedBox(height: 12),
              
              // Nombre de la receta
              Text(
                receta.nombre,
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: 8),
              
              // Información adicional
              Row(
                children: [
                  // Tiempo de preparación
                  _buildInfoChip(
                    icon: Icons.timer,
                    text: '${receta.tiempo} min',
                  ),
                  
                  const SizedBox(width: 8),
                  
                  // Dificultad
                  _buildInfoChip(
                    icon: Icons.leaderboard,
                    text: receta.dificultad,
                  ),
                  
                  const SizedBox(width: 8),
                  
                  // Comensales
                  _buildInfoChip(
                    icon: Icons.people,
                    text: '${receta.comensales}',
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Valoración (si existe)
              if (receta.valoracion != null)
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${receta.valoracion!.toStringAsFixed(1)} (${receta.votos ?? 0})',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text}) {
    return Chip(
      label: Text(text),
      avatar: Icon(icon, size: 16),
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}