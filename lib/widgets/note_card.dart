import 'package:flutter/material.dart';
import '../theme/cartoon_theme.dart';

/// Cartoon Network tarzı not kartı widget'ı
class NoteCard extends StatefulWidget {
  final String title;
  final String content;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NoteCard({
    super.key,
    required this.title,
    required this.content,
    required this.color,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          decoration: CartoonTheme.cartoonBox(color: widget.color),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Küçük dekoratif yıldız
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: CartoonTheme.darkOutline,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.title.isEmpty ? 'İsimsiz Not' : widget.title,
                      style: CartoonTheme.cartoonSubtitle.copyWith(fontSize: 17),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Silme butonu - çarpı
                  GestureDetector(
                    onTap: widget.onDelete,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: CartoonTheme.cartoonBoxSmall(
                        color: Colors.white.withValues(alpha: 0.7),
                        borderWidth: 2,
                        radius: 8,
                      ),
                      child: const Center(
                        child: Text(
                          '✕',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: CartoonTheme.darkOutline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Çizgi - cartoon divider
              Container(
                height: 3,
                decoration: BoxDecoration(
                  color: CartoonTheme.darkOutline.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.content.isEmpty ? 'Bir şeyler yaz...' : widget.content,
                style: CartoonTheme.cartoonBody.copyWith(
                  color: CartoonTheme.darkOutline.withValues(alpha: 0.75),
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


