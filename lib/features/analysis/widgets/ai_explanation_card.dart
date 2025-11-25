import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Card con la explicación generada por IA
class AIExplanationCard extends StatefulWidget {
  final String text;

  const AIExplanationCard({super.key, required this.text});

  @override
  State<AIExplanationCard> createState() => _AIExplanationCardState();
}

class _AIExplanationCardState extends State<AIExplanationCard> {
  bool _expanded = false;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.blueClassic.withOpacity(0.08),
            AppColors.blueClassic.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.blueClassic.withOpacity(0.25),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.blueClassic,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Análisis de IA',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueClassic,
                  ),
                ),
              ),
              // Toggle button
              TextButton.icon(
                onPressed: _toggle,
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.blueClassic,
                ),
                label: Text(
                  _expanded ? 'Ocultar' : 'Mostrar',
                  style: TextStyle(color: AppColors.blueClassic),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Collapsible content
          AnimatedCrossFade(
            firstChild: Text(
              widget.text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: AppColors.blackGrey,
                  ),
            ),
            secondChild: Text(
              widget.text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: AppColors.blackGrey,
                  ),
            ),
            crossFadeState:
                _expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}
