import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
  final Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            width: size.width * .9,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.black54.withOpacity(.6),
                ),
                const Expanded(
                    child: TextField(
                  showCursor: false,
                  decoration: InputDecoration(
                    hintText: 'Search Plant',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                )),
                Icon(
                  Icons.mic,
                  color: Colors.black54.withOpacity(.6),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
