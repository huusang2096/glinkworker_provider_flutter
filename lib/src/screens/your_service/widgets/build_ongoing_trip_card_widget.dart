import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/model/trip_response.dart';
import 'package:glinkwok_provider/src/screens/your_service/cubit/service_cubit.dart';
import 'package:simplest/simplest.dart';

import '../../../../routes.dart';

class OngoingTripCard extends StatelessWidget {
  final TripResponse item;
  ServiceCubit cubit;
  DateFormat format = DateFormat("yyyy-MM-dd");
  TextEditingController txtController = new TextEditingController();

  OngoingTripCard(this.item, this.cubit);

  _buildSubmitCancel(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "submit_cancel_reason".tr,
              style: heading1,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "booking_id".tr,
                  style: body1,
                ),
                Text(item.requests.first?.detail?.bookingId, style: body1)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              textInputAction: TextInputAction.go,
              controller: txtController,
              maxLines: 3,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'reason_to_cancel'.tr,
                hintStyle: body1.copyWith(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  child: FlatButton(
                    height: 50,
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      cubit.cancelTrip(
                          item.requests.first.requestId, txtController.text);
                    },
                    child: Text(
                      'submit'.tr,
                      style: body1.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  child: FlatButton(
                    height: 50,
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'close'.tr,
                      style: body1.copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        item.requests.first?.detail?.serviceType?.name ?? "",
                        style: heading1.copyWith(fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            (item.requests.first?.detail?.status
                                        .toString()
                                        .toLowerCase())
                                    .tr ??
                                "",
                            style: body1.copyWith(color: whiteColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoute.homeScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 5),
                      child: Row(
                        children: [
                          Container(
                            child: CircleAvatar(
                                backgroundImage: NetworkImage(item.requests
                                        .first?.detail.serviceType?.image ??
                                    Images.defaultAvatar)),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    item.requests.first?.detail?.serviceType
                                            ?.providerName ??
                                        "",
                                    style: body2.copyWith(fontSize: 18),
                                  ),
                                ),
                                RatingBar.builder(
                                  onRatingUpdate: null,
                                  initialRating: (item
                                      .requests.first?.detail?.userRated
                                      ?.toDouble()),
                                  itemCount: 5,
                                  itemSize: 15,
                                  allowHalfRating: true,
                                  itemBuilder: (context, index) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item.requests.first.detail.finishedAt == null
                                  ? "-"
                                  : (item.requests.first.detail.finishedAt
                                      .toString()),
                              textAlign: TextAlign.right,
                              style: body1.copyWith(fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FlatButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: Text(
                      "cancel".tr,
                      style: body1.copyWith(color: primaryColor),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => _buildSubmitCancel(context));
                    },
                    color: Color(0XFFfef2f1),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: greyColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(10)),
          )),
    );
  }
}
