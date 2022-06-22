import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalSumWidget extends StatelessWidget {
  const TotalSumWidget({required this.totalSum, Key? key}) : super(key: key);
  final int? totalSum;
  @override
  Widget build(BuildContext context) {
    return Text('Total: $totalSum \$',
        style: GoogleFonts.caveat(
            textStyle: Theme.of(context).textTheme.headline4!));
  }
}
