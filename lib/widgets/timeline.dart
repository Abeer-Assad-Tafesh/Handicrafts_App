import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handcrafts/constants.dart';
import 'package:timeline_tile/timeline_tile.dart';

const deliverySteps = [
  "قيد المراجعة",
  "قيد التجهيز",
  " قيد التوصيل",
  "مكتملة",
];

class DeliveryTimeline extends StatefulWidget {
  @override
  DeliveryTimelineState createState() => DeliveryTimelineState();
  int currentStep = 1;

  DeliveryTimeline({this.currentStep = 1});
}

class DeliveryTimelineState extends State<DeliveryTimeline> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Spacer(),
        // SizedBox(width: 20,),
        Expanded(
          child: Container(
            height: 40,
            // width: double.maxFinite,
            // color: Colors.green,
            // alignment: Alignment.centerRight,
            // padding:  EdgeInsets.only(right: 0,left: 50),
            child: ListView.builder(
              // padding: EdgeInsets.only(right: 0,left: 200),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: deliverySteps.length,
              itemBuilder: (BuildContext context, int index) {
                // final step = deliverySteps[index];
                var indicatorSize = 20.0;
                var beforeLineStyle =
                    LineStyle(color: kPrimaryColor, thickness: 3);

                _DeliveryStatus status;
                LineStyle? afterLineStyle;
                if (index < widget.currentStep) {
                  status = _DeliveryStatus.done;
                } else if (index > widget.currentStep) {
                  status = _DeliveryStatus.todo;
                  indicatorSize = 20;
                  beforeLineStyle =
                      LineStyle(color: Colors.grey.shade300, thickness: 3);
                } else {
                  afterLineStyle =
                      LineStyle(color: kPrimaryColor, thickness: 3);
                  status = _DeliveryStatus.doing;
                }

                return TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                  // lineXY: 0.2,
                  isFirst: index == 3,
                  isLast: index == 0,
                  beforeLineStyle: beforeLineStyle,
                  afterLineStyle: afterLineStyle,
                  indicatorStyle: IndicatorStyle(
                    width: indicatorSize,
                    height: indicatorSize,
                    padding: index == 0
                        ? EdgeInsets.only(right: 0)
                        : EdgeInsets.all(0),
                    indicator: _IndicatorDelivery(
                        status: status, currentStep: widget.currentStep),
                  ),
                  // startChild: _EndChildDelivery(
                  //   text: step,
                  //   current: index == currentStep,
                  // ),
                  // endChild: _StartChildDelivery(index: index),
                );
              },
            ),
          ),
        ),

        // SizedBox(width: 130,),
      ],
    );
  }
}

enum _DeliveryStatus { done, doing, todo }

/*
class _StartChildDelivery extends StatelessWidget {
  const _StartChildDelivery({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:Text('hiii'),
      ),
    );
  }
}
*/

// class _EndChildDelivery extends StatelessWidget {
//   const _EndChildDelivery({
//     required this.text,
//     required this.current,
//   });
//
//   final String text;
//   final bool current;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(minWidth: 40),
//       child: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 18),
//           // child: Row(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: [
//           //     Flexible(
//           //       child: Text(
//           //         text,
//           //         textAlign: TextAlign.center,
//           //         style: TextStyle(
//           //           fontSize: 9,
//           //           color: current ? kPrimaryColor : Colors.grey.shade300,
//           //         ),
//           //       ),
//           //     ),
//           //   ],
//           // ),
//         ),
//       ),
//     );
//   }
// }

class _IndicatorDelivery extends StatelessWidget {
  const _IndicatorDelivery({required this.status, required this.currentStep});

  final _DeliveryStatus status;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case _DeliveryStatus.done:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimaryColor,
          ),
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 18,
            ),
          ),
        );
      case _DeliveryStatus.doing:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimaryColor,
          ),
          child: Center(
            child: currentStep == 3
                ? const Center(
                    child: Icon(Icons.check, color: Colors.white, size: 18))
                : SvgPicture.asset('assets/icons/loading.svg'),
          ),
        );
      case _DeliveryStatus.todo:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade300,
          ),
          child: Center(
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ),
        );
    }
    return Container();
  }
}
