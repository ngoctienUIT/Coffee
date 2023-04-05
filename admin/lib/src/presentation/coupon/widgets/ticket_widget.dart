import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  final double margin;
  final double borderRadius;
  final double clipRadius;
  final double smallClipRadius;
  final int numberOfSmallClips;
  final String image;
  final String title;
  final String content;
  final String date;
  final VoidCallback onPress;

  const TicketWidget({
    Key? key,
    this.margin = 20,
    this.borderRadius = 10,
    this.clipRadius = 7,
    this.smallClipRadius = 2,
    this.numberOfSmallClips = 8,
    required this.image,
    required this.title,
    required this.date,
    required this.content,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final ticketWidth = screenSize.width;
    double ticketHeight = 130;

    return InkWell(
      onTap: onPress,
      child: Container(
        width: ticketWidth,
        height: ticketHeight,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 8),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 37,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipPath(
              clipper: TicketClipper(
                borderRadius: borderRadius,
                clipRadius: clipRadius,
                smallClipRadius: smallClipRadius,
                numberOfSmallClips: numberOfSmallClips,
              ),
              child: Container(color: Colors.white),
            ),
            SizedBox(
              height: 130,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Image.asset(image, height: 100, width: 100),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(content),
                          const Spacer(),
                          Text(
                            "${"expired".translate(context)} $date",
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  static const double clipPadding = 18;

  final double borderRadius;
  final double clipRadius;
  final double smallClipRadius;
  final int numberOfSmallClips;

  const TicketClipper({
    required this.borderRadius,
    required this.clipRadius,
    required this.smallClipRadius,
    required this.numberOfSmallClips,
  });

  @override
  Path getClip(Size size) {
    var path = Path();

    // draw rect
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    ));

    final clipPath = Path();
    double centerX = 130;

    // circle on the left
    clipPath.addOval(Rect.fromCircle(
      center: Offset(centerX, 0),
      radius: clipRadius,
    ));

    // circle on the right
    clipPath.addOval(Rect.fromCircle(
      center: Offset(centerX, size.height),
      radius: clipRadius,
    ));

    int smallClipBoxSize = 12;

    final smallClipCenterOffsets = List.generate(numberOfSmallClips, (index) {
      final centerY = clipPadding + smallClipBoxSize * index;

      return Offset(centerX, centerY);
    });

    for (var centerOffset in smallClipCenterOffsets) {
      clipPath.addOval(Rect.fromCircle(
        center: centerOffset,
        radius: smallClipRadius,
      ));
    }

    // combine two path together
    final ticketPath = Path.combine(
      PathOperation.reverseDifference,
      clipPath,
      path,
    );

    return ticketPath;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) =>
      oldClipper.borderRadius != borderRadius ||
      oldClipper.clipRadius != clipRadius ||
      oldClipper.smallClipRadius != smallClipRadius ||
      oldClipper.numberOfSmallClips != numberOfSmallClips;
}
