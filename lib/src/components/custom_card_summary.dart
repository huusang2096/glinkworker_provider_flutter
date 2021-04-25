import 'package:flutter/material.dart';
import 'package:simplest/simplest.dart';

class CustomCardSummary extends StatelessWidget {
  final String text;
  final String value;
  final Color color;
  final IconData image;
  final String currency;

  const CustomCardSummary({
    Key key,
    this.text,
    this.value,
    this.color,
    this.image,
    this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text.tr,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Text(
                        currency,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        value,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(180.0),
              ),
              color: color,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 25.0),
              child: Icon(
                image,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
