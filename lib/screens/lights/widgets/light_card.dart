import 'package:flutter/material.dart';

import '../../../models/light_model.dart';

class LightCard extends StatelessWidget {
  final Light light;
  final VoidCallback onToggle;
  final ValueChanged<double> onBrightnessChanged;
  final ValueChanged<Color>? onColorChanged;

  const LightCard({
    super.key,
    required this.light,
    required this.onToggle,
    required this.onBrightnessChanged,
    this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: SizedBox(
        height: 136, // Fixed height to match constraints
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with name and switch
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          light.name,
                          style: Theme.of(context).textTheme.titleSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          light.room,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: light.isOn,
                    onChanged: light.isOnline ? (_) => onToggle() : null,
                  ),
                ],
              ),

              if (light.isOn) ...[
                // Brightness slider
                Row(
                  children: [
                    const Icon(Icons.brightness_6, size: 16),
                    Expanded(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 2,
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 6,
                          ),
                        ),
                        child: Slider(
                          value: light.brightness,
                          onChanged: light.isOnline ? onBrightnessChanged : null,
                        ),
                      ),
                    ),
                  ],
                ),

                // Color buttons (if supported)
                if (light.supportsColors)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ColorButton(
                        color: Colors.white,
                        isSelected: light.color == Colors.white,
                        onTap: () => onColorChanged?.call(Colors.white),
                        size: 24,
                      ),
                      _ColorButton(
                        color: Colors.amber,
                        isSelected: light.color == Colors.amber,
                        onTap: () => onColorChanged?.call(Colors.amber),
                        size: 24,
                      ),
                      _ColorButton(
                        color: Colors.blue,
                        isSelected: light.color == Colors.blue,
                        onTap: () => onColorChanged?.call(Colors.blue),
                        size: 24,
                      ),
                      _ColorButton(
                        color: Colors.purple,
                        isSelected: light.color == Colors.purple,
                        onTap: () => onColorChanged?.call(Colors.purple),
                        size: 24,
                      ),
                    ],
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorButton extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final double size;

  const _ColorButton({
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
            width: 2,
          ),
        ),
      ),
    );
  }
}