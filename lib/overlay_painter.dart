import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dynamsoft_capture_vision_flutter/dynamsoft_capture_vision_flutter.dart';

Widget createOverlay(List<BarcodeResult> results, int width, int height) {
  return CustomPaint(
    painter: OverlayPainter(results, width, height),
  );
}

class OverlayPainter extends CustomPainter {
  final List<BarcodeResult> results;
  final int width;
  final int height;

  int rotate(int y) {
    return width - y;
  }

  OverlayPainter(this.results, this.width, this.height) {
    results.sort((a, b) {
      List<Point> aPoints = a.barcodeLocation.location.points;
      List<Point> bPoints = b.barcodeLocation.location.points;

      if (((aPoints[0].y + aPoints[1].y + aPoints[2].y + aPoints[3].y) / 4 <
          (bPoints[0].y + bPoints[1].y + bPoints[2].y + bPoints[3].y) / 4)) {
        return -1;
      }
      if (((aPoints[0].y + aPoints[1].y + aPoints[2].y + aPoints[3].y) / 4 >
          (bPoints[0].y + bPoints[1].y + bPoints[2].y + bPoints[3].y) / 4)) {
        return 1;
      }
      return 0;
    });

    List<BarcodeResult> all = [];
    int delta = 0;
    while (results.isNotEmpty) {
      List<BarcodeResult> sortedResults = [];
      BarcodeResult start = results[0];
      sortedResults.add(start);
      results.remove(start);

      List<Point> startPoints = start.barcodeLocation.location.points;
      int maxHeight = [
        startPoints[0].y,
        startPoints[1].y,
        startPoints[2].y,
        startPoints[3].y
      ].reduce(max);
      while (results.isNotEmpty) {
        BarcodeResult tmp = results[0];
        List<Point> tmpPoints = tmp.barcodeLocation.location.points;
        if ([tmpPoints[0].y, tmpPoints[1].y, tmpPoints[2].y, tmpPoints[3].y]
                .reduce(min) <
            maxHeight + delta) {
          sortedResults.add(tmp);
          results.remove(tmp);
        } else {
          break;
        }
      }

      sortedResults.sort(((a, b) {
        List<Point> aPoints = a.barcodeLocation.location.points;
        List<Point> bPoints = b.barcodeLocation.location.points;
        if (((aPoints[0].x + aPoints[1].x + aPoints[2].x + aPoints[3].x) / 4 <
            (bPoints[0].x + bPoints[1].x + bPoints[2].x + bPoints[3].x) / 4)) {
          return -1;
        }
        if (((aPoints[0].x + aPoints[1].x + aPoints[2].x + aPoints[3].x) / 4 >
            (bPoints[0].x + bPoints[1].x + bPoints[2].x + bPoints[3].x) / 4)) {
          return 1;
        }
        return 0;
      }));

      all += sortedResults;
    }
    results.addAll(all);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 30
      ..style = PaintingStyle.stroke;

    int index = 0;

    for (var result in results) {
      List<Point> points = result.barcodeLocation.location.points;
      double minX = points[0].x.toDouble();
      double minY = points[0].y.toDouble();
      if (points[1].x < minX) minX = points[1].x.toDouble();
      if (points[2].x < minX) minX = points[2].x.toDouble();
      if (points[3].x < minX) minX = points[3].x.toDouble();
      if (points[1].y < minY) minY = points[1].y.toDouble();
      if (points[2].y < minY) minY = points[2].y.toDouble();
      if (points[3].y < minY) minY = points[3].y.toDouble();

      if (Platform.isIOS) {
        canvas.drawLine(
            Offset(rotate(points[0].y).toDouble(), points[0].x.toDouble()),
            Offset(rotate(points[1].y).toDouble(), points[1].x.toDouble()),
            paint);
        canvas.drawLine(
            Offset(rotate(points[1].y).toDouble(), points[1].x.toDouble()),
            Offset(rotate(points[2].y).toDouble(), points[2].x.toDouble()),
            paint);
        canvas.drawLine(
            Offset(rotate(points[2].y).toDouble(), points[2].x.toDouble()),
            Offset(rotate(points[3].y).toDouble(), points[3].x.toDouble()),
            paint);
        canvas.drawLine(
            Offset(rotate(points[3].y).toDouble(), points[3].x.toDouble()),
            Offset(rotate(points[0].y).toDouble(), points[0].x.toDouble()),
            paint);
      } else {
        canvas.drawLine(Offset(points[0].x.toDouble(), points[0].y.toDouble()),
            Offset(points[1].x.toDouble(), points[1].y.toDouble()), paint);
        canvas.drawLine(Offset(points[1].x.toDouble(), points[1].y.toDouble()),
            Offset(points[2].x.toDouble(), points[2].y.toDouble()), paint);
        canvas.drawLine(Offset(points[2].x.toDouble(), points[2].y.toDouble()),
            Offset(points[3].x.toDouble(), points[3].y.toDouble()), paint);
        canvas.drawLine(Offset(points[3].x.toDouble(), points[3].y.toDouble()),
            Offset(points[0].x.toDouble(), points[0].y.toDouble()), paint);
      }

      TextPainter numberPainter = TextPainter(
        text: TextSpan(
          text: index.toString(),
          style: const TextStyle(
            color: Colors.red,
            fontSize: 100.0,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      numberPainter.layout(minWidth: 0, maxWidth: size.width);
      numberPainter.paint(canvas, Offset(minX, minY));

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: result.barcodeText,
          style: const TextStyle(
            color: Colors.yellow,
            fontSize: 100.0,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: size.width);
      textPainter.paint(canvas, Offset(minX, minY));

      index += 1;
    }
  }

  @override
  bool shouldRepaint(OverlayPainter oldDelegate) =>
      results != oldDelegate.results;
}
