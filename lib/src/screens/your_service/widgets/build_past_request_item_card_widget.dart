import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/routes.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/your_service/models/provider_past_trip_response_model.dart';
import 'package:simplest/simplest.dart';

class PastCardItemWidget extends StatelessWidget {
  final ProviderPastTripResponse item;
  Color statusColor;
  DateFormat format = DateFormat("yyyy-MM-dd");
  PastCardItemWidget(this.item);
  @override
  Widget build(BuildContext context) {
    if (item.status.toString() == "SCHEDULED") {
      statusColor = Colors.green;
    } else if (item.status.toString() == "COMPLETED") {
      statusColor = Colors.black45;
    } else {
      statusColor = Colors.red;
    }
    return IntrinsicHeight(
      child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          width: double.maxFinite,
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.serviceType?.name.toString() ?? "",
                        style: heading1.copyWith(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            (item.status?.toString().toLowerCase() ?? "").tr,
                            style: body1.copyWith(color: whiteColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    item.bookingId?.toString(),
                    textAlign: TextAlign.right,
                    style: heading1.copyWith(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Divider(
                  color: greyColor,
                  height: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        AppRoute.historyDetailScreen,
                        arguments: {'request_id': item.id});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  item.serviceType?.image ??
                                      Images.defaultAvatar)),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.serviceType?.providerName ?? "",
                                  style: body2.copyWith(fontSize: 18),
                                ),
                              ),
                              Text(
                                item.payment == null
                                    ? "0"
                                    : "${currencyFormatter.format(item.payment?.cash ?? '0')}",
                                style: body1.copyWith(
                                    color: redColor2, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item.finishedAt == null
                                ? "-"
                                : format.format(item.finishedAt).toString(),
                            textAlign: TextAlign.right,
                            style: body1.copyWith(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: greyColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
          )),
    );
  }
}
