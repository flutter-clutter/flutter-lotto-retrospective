import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lotto_retrospection/services/lotto_history_service.dart';

import 'bloc/lotto_bloc.dart';
import 'views/home.dart';

void main() {
  runApp(LottoRetrospective());
}

class LottoRetrospective extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white
          ),
          bodyText2: TextStyle(
            color: Colors.white
          ),
          caption: TextStyle(
            color: Colors.white
          ),
        ),
        accentColor: Colors.white,
        backgroundColor: Colors.green
      ),
      home: BlocProvider(
        create: (BuildContext context) {
          return LottoBloc(
            lottoHistoryService: LottoHistoryService()
          );
        },
        child: Scaffold(
          body: SafeArea(
            child: Home(),
          ),
        )
      ),
    );
  }
}
