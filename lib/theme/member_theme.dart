import 'package:flutter/material.dart';
class MemberTheme {
 static const wine=Color(0xff3a0206);
 static const red=Color(0xffa31812);
 static const berry=Color(0xffa31812);
 static const pink=Color(0xfff05287);
 static const gold=Color(0xfff0c14b);
 static const cream=Color(0xfffff7ec);
 static const ink=Color(0xff1b130e);
 static const green=Color(0xff168a3a);
 static const purple=Color(0xff7c3aed);
 static ThemeData get light=>ThemeData(useMaterial3:true,scaffoldBackgroundColor:wine,colorScheme:ColorScheme.fromSeed(seedColor:gold));
}
