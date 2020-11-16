import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lotto_retrospection/bloc/lotto_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LottoInput extends StatelessWidget {
  LottoInput({
    this.crossed = const []
  });

  final List<int> crossed;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(2),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 9,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: 59,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 2
            ),
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: () {
              context.read<LottoBloc>().add(
                CrossNumber(
                  number: index + 1
                )
              );
            },
            child: _getNumber(index)
          ),
        );
      },
    );
  }

  Stack _getNumber(int index) {
    return Stack(
      children: [
        Center(
          child: Text(
            '${index + 1}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.green,
              fontWeight: FontWeight.bold
            ),
          )
        ),
        Center(
          child: CustomPaint(
            painter: CrossPainter(),
            size: crossed.contains(index + 1) ? Size.infinite : Size.zero
          )
        )
      ]
    );
  }
}

class CrossPainter extends CustomPainter {
  CrossPainter({
    this.strokeWidth = 4,
    this.color = Colors.blueGrey
  });

  int strokeWidth;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    _drawCrosshair(canvas, size);
  }

  void _drawCrosshair(Canvas canvas, Size size) {
    Paint crossPaint = Paint()
      ..strokeWidth = strokeWidth / 2
      ..color = color;

    double crossSize = size.longestSide / 1.8;
    canvas.drawLine(
      size.center(Offset(-crossSize, -crossSize)),
      size.center(Offset(crossSize, crossSize)),
      crossPaint
    );

    canvas.drawLine(
      size.center(Offset(crossSize, -crossSize)),
      size.center(Offset(-crossSize, crossSize)),
      crossPaint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}