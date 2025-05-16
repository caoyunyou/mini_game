import 'package:flutter/material.dart';
import 'package:mini_game/views/muyu/models/image_option.dart';

class ImageOptionItem extends StatelessWidget {
  final ImageOption option;
  final bool active;

  const ImageOptionItem({
    super.key,
    required this.option,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    const Border activeBorder = Border.fromBorderSide(
      BorderSide(color: Colors.blue),
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: !active ? null : activeBorder,
      ),
      child: Column(
        children: [
          Text(option.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(option.src),
            ),
          ),
          Text(
            "每次功德 + ${option.min}~${option.max}",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class ImageOptionPanel extends StatelessWidget {
  final List<ImageOption> imageOptions;
  final ValueChanged<int> onSelect;
  final int activeIndex;

  const ImageOptionPanel({
    super.key,
    required this.imageOptions,
    required this.onSelect,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    const EdgeInsets padding = EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 16,
    );
    return Material(
      color: Colors.black38,
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              height: 46,
              alignment: Alignment.center,
              child: const Text('选择木鱼', style: labelStyle),
            ),
            Expanded(
              child: Padding(
                padding: padding,
                child: Row(
                  children: [
                    Expanded(child: _buildByIndex(0)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildByIndex(1)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildByIndex(2)),
                    // ...List.generate(imageOptions.length, _buildByIndex),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool active = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: ImageOptionItem(option: imageOptions[index], active: active),
    );
  }
}
