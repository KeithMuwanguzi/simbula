import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarImageWidget extends StatelessWidget {
  const CarImageWidget({
    super.key,
    required this.image,
    this.isExpanded = false,
  });

  final String image;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return isExpanded ? Expanded(child: buildBody()) : buildBody();
  }

  ValueBuilder<int?> buildBody() {
    return ValueBuilder(
      initialValue: 0,
      builder: (currentImage, updateFn) => Column(
        children: [
          isExpanded
              ? Expanded(child: buildImagesPage(updateFn))
              : buildImagesPage(updateFn),
        ],
      ),
    );
  }

  Widget buildImagesPage(ValueBuilderUpdateCallback<int> updateFn) {
    return SizedBox(
      height: 150,
      child: PageView(
          physics: const BouncingScrollPhysics(),
          onPageChanged: updateFn,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Image.network(
                image,
                fit: BoxFit.scaleDown,
              ),
            ),
          ]),
    );
  }
}
