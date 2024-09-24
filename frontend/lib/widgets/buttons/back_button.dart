import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final Function()? onPressed;

  const BackButtonWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: MediaQuery.of(context).size.height * 0.14,
      right: 20,
      left: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: onPressed ?? () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
