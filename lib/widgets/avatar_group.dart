import 'package:flutter/material.dart';

class UAvatarGroup extends StatelessWidget {
  final List<String> avatarUrls;
  final int maxVisible;
  final double avatarSize;
  final double overlap;
  final double borderWidth;

  const UAvatarGroup({
    super.key,
    required this.avatarUrls,
    this.maxVisible = 3,
    this.avatarSize = 40,
    this.overlap = 0.3,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    int visibleCount = avatarUrls.length > maxVisible ? maxVisible : avatarUrls.length;
    int overflow = avatarUrls.length - maxVisible;

    // Calculate the correct width, including space for the overflow indicator
    double stackWidth = 0;
    if (maxVisible > 0) {
      stackWidth = avatarSize + borderWidth * 2;
      if (visibleCount > 1) {
        stackWidth += (avatarSize + borderWidth * 2) * (1 - overlap) * (visibleCount - 1);
      }
      if (overflow > 0) {
        stackWidth += (avatarSize + borderWidth * 2) * (1 - overlap);
      }
    } else if (overflow > 0) {
      stackWidth = avatarSize + borderWidth * 2;
    }

    return Container(
      width: stackWidth,
      height: avatarSize + borderWidth * 2,
      child: Stack(
        children: [
          if (maxVisible > 0)
            ...avatarUrls.take(visibleCount).toList().asMap().entries.map((entry) {
              int idx = entry.key;
              String url = entry.value;
              return Positioned(
                left: idx * (avatarSize + borderWidth * 2) * (1 - overlap),
                child: Container(
                  width: avatarSize + borderWidth * 2,
                  height: avatarSize + borderWidth * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: borderWidth),
                  ),
                  child: CircleAvatar(
                    radius: avatarSize / 2,
                    backgroundImage: NetworkImage(url),
                  ),
                ),
              );
            }),
          if (overflow > 0)
            Positioned(
              left: (maxVisible > 0 ? visibleCount : 0) * (avatarSize + borderWidth * 2) * (1 - overlap),
              child: Container(
                width: avatarSize + borderWidth * 2,
                height: avatarSize + borderWidth * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: borderWidth),
                ),
                child: CircleAvatar(
                  radius: avatarSize / 2,
                  backgroundColor: Colors.grey,
                  child: Text(
                    '+$overflow',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
