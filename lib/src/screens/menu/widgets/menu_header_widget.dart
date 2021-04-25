import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:simplest/simplest.dart';

class MenuHeaderWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const MenuHeaderWidget({Key key, this.imageUrl, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double avatarSize = 60;
    final _placeholderWidget = Center(
        child: FaIcon(
      FontAwesomeIcons.user,
      size: avatarSize * 0.6,
    ));
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(avatarSize),
                child: SizedBox(
                  width: avatarSize,
                  height: avatarSize,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (_, val) => _placeholderWidget,
                    errorWidget: (context, error, _) => _placeholderWidget,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: heading18Black,
                ),
                Text(
                  subtitle,
                  style: heading14.apply(color: Colors.black),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
