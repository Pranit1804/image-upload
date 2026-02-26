import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/image_entity.dart';

class ImageGridItem extends ConsumerWidget {
  final ImageEntity image;

  const ImageGridItem({super.key, required this.image});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showImagePreview(context),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                image.url,
                fit: BoxFit.cover,
                webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 48,
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  ),
                ),
                child: Text(
                  _formatTimestamp(image.timestamp),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePreview(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Image.network(
                    image.url,
                    fit: BoxFit.contain,
                    webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                    errorBuilder: (context, error, stackTrace) => SizedBox(
                      height: 320,
                      child: Center(
                        child: Text(
                          'Unable to load image',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton.filledTonal(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return DateFormat('MMM d, y').format(timestamp);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
