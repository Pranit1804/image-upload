import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';
import '../../domain/entities/image_entity.dart';
import 'image_grid_item.dart';

class ImageGrid extends StatelessWidget {
  final List<ImageEntity> images;

  const ImageGrid({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = Responsive.getGridCrossAxisCount(context);
    final spacing = Responsive.getGridSpacing(context);
    final padding = Responsive.getHorizontalPadding(context);

    return GridView.builder(
      padding: EdgeInsets.all(padding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1.0,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return ImageGridItem(image: images[index]);
      },
    );
  }
}
