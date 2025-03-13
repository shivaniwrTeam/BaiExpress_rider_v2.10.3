import 'package:deliveryboy_multivendor/Helper/color.dart';
import 'package:deliveryboy_multivendor/Helper/constant.dart';
import 'package:deliveryboy_multivendor/Helper/extensions/string.dart';
import 'package:deliveryboy_multivendor/Helper/extensions/textWidgetExtention.dart';
import 'package:deliveryboy_multivendor/Model/ReturnOrderModel.dart';
import 'package:deliveryboy_multivendor/Screens/Return/Widget/orderDetailsScreen.dart';
import 'package:deliveryboy_multivendor/Widget/desing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final ReturnOrderModel order;
  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    Color back;
    if (widget.order.activeStatus == "returned")
      back = Colors.green.withOpacity(0.85);
    else if (widget.order.activeStatus == "return_request_decline")
      back = Colors.red.withOpacity(0.85);
    else if (widget.order.activeStatus == "return_request_approved")
      back = Colors.blue.withOpacity(0.85);
    else if (widget.order.activeStatus == "return_request_pending")
      back = Colors.indigo.withOpacity(0.85);
    else if (widget.order.activeStatus == "return_pickedup")
      back = Colors.orange;
    else
      back = Colors.cyan;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailsScreen(
                      order: widget.order,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration:
            BoxDecoration(color: white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildOrderId(back),
            _divider(context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(widget.order.productName!),
            ),
            _divider(context),
            buildProfileCardAndPrice(context)
          ],
        ),
      ),
    );
  }

  Widget buildOrderId(Color back) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Text("#${widget.order.orderId!}"),
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                  color: back,
                  borderRadius: const BorderRadius.all(
                      Radius.circular(circularBorderRadius5))),
              child: Text(
                '${widget.order.activeStatus!.replaceAll('_', ' ')}',
                style: const TextStyle(color: white),
              )
              // widget.order.activeStatus == "returned"
              // ? Text(
              //     "Returned",
              //     style: const TextStyle(color: white),
              //   )
              // : widget.order.activeStatus == "return_request_decline"
              //     ? Text(
              //         "Return Request Decline",
              //         style: const TextStyle(color: white),
              //       )
              //     : widget.order.activeStatus == "return_request_approved"
              //         ? Text(
              //             "Return Request Approved",
              //             style: const TextStyle(color: white),
              //           )
              //         : widget.order.activeStatus == "return_request_pending"
              //             ? Text(
              //                 "Return Request Pending",
              //                 style: const TextStyle(color: white),
              //               )
              //             : widget.order.activeStatus == "return_pickedup"
              //                 ? Text(
              //                     "Return Pickedup",
              //                     style: const TextStyle(color: white),
              //                   )
              //                 : Text(
              //                     "Return",
              //                     style: const TextStyle(color: white),
              //                   ),

              )
        ],
      ),
    );
  }

  Widget buildProfileCardAndPrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.order.username!),
              const SizedBox(
                height: 4,
              ),
              Text(widget.order.mobile!)
                  .size(10)
                  .color(const Color.fromARGB(255, 80, 80, 80)),
            ],
          ),
          // const Spacer(),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   children: [
          //     Text(DesignConfiguration.getPriceFormat(
          //         context, widget.order.subTotal!.toDouble())!),
          //     Text(widget.order.paymentMethod!)
          //         .size(10)
          //         .color(const Color.fromARGB(255, 80, 80, 80)),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _divider(BuildContext context) {
    return IntrinsicHeight(
      child: OverflowBox(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: 1,
        minHeight: 0.8,
        child: Container(
          color: const Color.fromARGB(255, 235, 235, 235),
          margin: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}
