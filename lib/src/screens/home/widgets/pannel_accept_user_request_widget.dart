import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:glinkwok_provider/src/screens/home/widgets/pannel_cancel_status_widget.dart';
import 'package:simplest/simplest.dart';

import 'actions_header_widget.dart';

class PannelAcceptUserRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<HomeCubit>();
    final user = bloc.state.tripResponse.requests.first.detail.user;
    final _avatarUrl = IMG_URL + (user?.picture ?? '');
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActionHeaderWidget(),
          Expanded(
            child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(70),
                              child: CachedNetworkImage(
                                imageUrl: _avatarUrl,
                                errorWidget: (context, url, error) =>
                                    Images.defaultAvatar.loadImage(size: 70),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${user.firstName} ${user.lastName}"),
                                Row(
                                  children: [
                                    Text(user.rating),
                                    Icon(Icons.star, color: Colors.amber),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => showBottomSheet(
                                context: context,
                                builder: (_) => PannelCancelStatusWidget()),
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 50,
                              child: Text("cancel".tr,
                                  style: body1.copyWith(color: Colors.white)),
                              decoration: BoxDecoration(
                                  color: redColor2,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          InkWell(
                            onTap: bloc.onSelectArrived,
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 50,
                              child: Text(
                                "arrived".tr,
                                style: body1.copyWith(color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                  color: redColor2,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
