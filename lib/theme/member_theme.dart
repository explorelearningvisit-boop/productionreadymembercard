import 'package:flutter/material.dart';
class MemberTheme{
 static const ink=Color(0xFF24103D),purple=Color(0xFF7900C8),
 violet=Color(0xFFB52BFF),neon=Color(0xFFD500FF),green=Color(0xFF16C900),
 red=Color(0xFFE51B45),gold=Color(0xFFFFC900),canvas=Color(0xFFF4EDFF),
 muted=Color(0xFF766887),line=Color(0xFFE4D5F7);
 static ThemeData get light=>ThemeData(useMaterial3:true,
  scaffoldBackgroundColor:canvas,colorScheme:ColorScheme.fromSeed(seedColor:purple),
  cardTheme:CardThemeData(color:Colors.white,elevation:2,
   shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20),
    side:const BorderSide(color:line))));
}
