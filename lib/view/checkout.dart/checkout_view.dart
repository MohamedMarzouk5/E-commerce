import 'package:ecommerce/constant.dart';
// import 'package:ecommerce/core/view_model/checkout_viewmodel.dart';
import 'package:ecommerce/view/checkout.dart/add_address_widget.dart';
import 'package:ecommerce/view/checkout.dart/delivery_time_widget.dart';
import 'package:ecommerce/view/checkout.dart/summary_widget.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:status_change/status_change.dart';

class CheckoutView extends StatefulWidget {
  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  int _processIndex;
  Pages pages = Pages.DeliveryTime;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return Colors.green;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "CheckOut",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 100,
            child: StatusChange.tileBuilder(
              theme: StatusChangeThemeData(
                direction: Axis.horizontal,
                connectorTheme: ConnectorThemeData(space: 1.0, thickness: 1.0),
              ),
              builder: StatusChangeTileBuilder.connected(
                itemWidth: (_) =>
                    MediaQuery.of(context).size.width / _processes.length,
                nameWidgetBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      _processes[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: getColor(index),
                      ),
                    ),
                  );
                },
                indicatorWidgetBuilder: (_, index) {
                  if (index <= _processIndex) {
                    return DotIndicator(
                      size: 35.0,
                      border: Border.all(color: Colors.green, width: 1),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return OutlinedDotIndicator(
                      size: 30,
                      borderWidth: 1.0,
                      color: todoColor,
                    );
                  }
                },
                lineWidgetBuilder: (index) {
                  if (index > 0) {
                    if (index == _processIndex) {
                      final prevColor = getColor(index - 1);
                      final color = getColor(index);
                      var gradientColors;
                      gradientColors = [
                        prevColor,
                        Color.lerp(prevColor, color, 0.5)
                      ];
                      return DecoratedLineConnector(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradientColors,
                          ),
                        ),
                      );
                    } else {
                      return SolidLineConnector(
                        color: getColor(index),
                      );
                    }
                  } else {
                    return null;
                  }
                },
                itemCount: _processes.length,
              ),
            ),
          ),
          pages == Pages.DeliveryTime
              ? DeliveryTime()
              : pages == Pages.AddAddress
                  ? AddAddress()
                  : Summary()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.skip_next),
        onPressed: () {
          print(_processIndex);
          setState(() {
            _processIndex++;
            if (_processIndex == 1) {
              pages = Pages.AddAddress;
            } else if (_processIndex == 2) {
              pages = Pages.Summary;
            } else if (_processIndex == 3) {}
          });
        },
        backgroundColor: inProgressColor,
      ),
    );
  }
}

final _processes = [
  'Delivery',
  'Address',
  'Summer',
];
// class CheckoutView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CheckoutViewModel>(
//       init: CheckoutViewModel(),
//       builder: (controller) => Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           elevation: 0.0,
//           title: Text(
//             "CheckOut",
//             style: TextStyle(
//               color: Colors.black,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             Container(
//               height: 100,
//               child: StatusChange.tileBuilder(
//                 theme: StatusChangeThemeData(
//                   direction: Axis.horizontal,
//                   connectorTheme:
//                       ConnectorThemeData(space: 1.0, thickness: 1.0),
//                 ),
//                 builder: StatusChangeTileBuilder.connected(
//                   itemWidth: (_) =>
//                       MediaQuery.of(context).size.width / _processes.length,
//                   nameWidgetBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(top: 15.0),
//                       child: Text(
//                         _processes[index],
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: controller.getColor(index),
//                         ),
//                       ),
//                     );
//                   },
//                   indicatorWidgetBuilder: (_, index) {
//                     if (index <= controller.index) {
//                       return DotIndicator(
//                         size: 35.0,
//                         border: Border.all(color: Colors.green, width: 1),
//                         child: Padding(
//                           padding: const EdgeInsets.all(6.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.green,
//                             ),
//                           ),
//                         ),
//                       );
//                     } else {
//                       return OutlinedDotIndicator(
//                         size: 30,
//                         borderWidth: 1.0,
//                         color: todoColor,
//                       );
//                     }
//                   },
//                   lineWidgetBuilder: (index) {
//                     if (index > 0) {
//                       if (index == controller.index) {
//                         final prevColor = controller.getColor(index - 1);
//                         final color = controller.getColor(index);
//                         var gradientColors;
//                         gradientColors = [
//                           prevColor,
//                           Color.lerp(prevColor, color, 0.5)
//                         ];
//                         return DecoratedLineConnector(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: gradientColors,
//                             ),
//                           ),
//                         );
//                       } else {
//                         return SolidLineConnector(
//                           color: controller.getColor(index),
//                         );
//                       }
//                     } else {
//                       return null;
//                     }
//                   },
//                   itemCount: _processes.length,
//                 ),
//               ),
//             ),
//             controller.pages == Pages.DeliveryTime
//                 ? DeliveryTime()
//                 : controller.pages == Pages.AddAddress
//                     ? AddAddress()
//                     : Summary()
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.skip_next),
//           onPressed: () {
//             controller.changeIndex(controller.index + 1);
//           },
//           backgroundColor: inProgressColor,
//         ),
//       ),
//     );
//   }
// }

// final _processes = [
//   'Delivery',
//   'Address',
//   'Summer',
// ];
