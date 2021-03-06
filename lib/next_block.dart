import 'package:flutter/material.dart';

class NextBlock extends StatefulWidget {
  const NextBlock({Key? key}) : super(key: key);

  @override
  State<NextBlock> createState() => _NextBlockState();
}

class _NextBlockState extends State<NextBlock> {
  @override
   Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Next',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            AspectRatio(aspectRatio: 1,child: Container(color: Colors.indigo[600],),)
          ],
        ) ,

    );
  }
}
