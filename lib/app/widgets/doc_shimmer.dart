import 'package:flutter/material.dart';

class DocShimmer extends StatelessWidget {
  const DocShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        color: Colors.black54,

      ),
      title: Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: 12.0,
        color: Colors.white,
      ),
      subtitle: Container(
        width: MediaQuery.sizeOf(context).width * 0.5,
        height: 12.0,
        color: Colors.white,
      ),
    );
  }
}
