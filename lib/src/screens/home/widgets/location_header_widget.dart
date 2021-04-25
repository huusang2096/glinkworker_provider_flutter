import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:simplest/simplest.dart';

class LocationHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<HomeCubit>();
    if (!bloc.state.isShowLocationHeader) {
      return SizedBox.shrink();
    }

    final _triprDetail = bloc.state.tripResponse.requests.first.detail;
    final _address = _triprDetail.sAddress;

    return Container(
        height: 80,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "service_location".tr,
                    style: heading18Black,
                  ),
                  Expanded(
                    child: AutoSizeText(
                      _address,
                      style: body1,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              width: 1,
              height: 40,
              color: Colors.grey,
            ),
            InkWell(
              onTap: bloc.selectRequestLocation,
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: redColor2, borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }
}
