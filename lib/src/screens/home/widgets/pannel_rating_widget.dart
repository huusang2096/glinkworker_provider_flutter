import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:glinkwok_provider/src/widgets/image_error_widget.dart';
import 'package:glinkwok_provider/src/widgets/placeholder_widget.dart';
import 'package:simplest/simplest.dart';

class PannelRating extends StatelessWidget {
  final TextEditingController _reviewController = new TextEditingController();
  var _rating = 5.0;

  @override
  Widget build(BuildContext context) {
    final bloc = context.bloc<HomeCubit>();
    if (bloc.state.tripResponse.requests.length == 0) {
      return SizedBox.shrink();
    }
    final _user = bloc.state.tripResponse?.requests?.first?.detail?.user;
    final _avatarUrl = IMG_URL + (_user?.picture ?? '');
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Text(
              'rate_your_trip'.tr + ' ${_user.firstName} ${_user.lastName}',
              style: headingGrey.copyWith(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            width: 70,
            height: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(70),
              child: CachedNetworkImage(
                placeholder: (context, url) => PlacholderWidget(),
                errorWidget: (context, url, error) => ImageErrorWidget(),
                imageUrl: _avatarUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: RatingBar.builder(
              initialRating: 5,
              itemCount: 5,
              allowHalfRating: false,
              itemBuilder: (context, _) =>
                  Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                _rating = rating;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintStyle: body1.copyWith(color: Colors.grey),
                hintText: ("write_your_reviews").tr,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              maxLines: 3,
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () =>
                  bloc.submitRatingTrip(_rating, _reviewController.text),
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: redColor2, borderRadius: BorderRadius.circular(10)),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "submit".tr,
                  style: body1.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
