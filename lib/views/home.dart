import 'package:flutter_lotto_retrospection/views/lotto_details.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lotto_retrospection/bloc/lotto_bloc.dart';

import 'lotto_input.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LottoBloc bloc;
  final numberFormat = new NumberFormat("#,##0", "en_GB");

  @override
  void didChangeDependencies() {
    bloc = context.read();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      bloc.add(Initialize());
    });

    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LottoBloc, LottoState>(
      builder: (BuildContext context, LottoState state) {
        return Scaffold(
          backgroundColor: Colors.green,
          body: _getBody(state)
        );
      },
    );
  }

  Widget _getBody(LottoState state) {
    if (!state.initialized) {
      return _getLoadingIndicator();
    }

    return _getMainWidget(state);
  }

  SingleChildScrollView _getMainWidget(LottoState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Image.asset('assets/clover_white.png', width: 80),
          SizedBox(height: 24),
          Text(
            'Lotto retrospective',
            style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(color: Colors.black26, offset: Offset(1.5, 1.5), blurRadius: 10)
              ],
              fontSize: 26
            )
          ),
          SizedBox(height: 24),
          Text(
            'How would your numbers have performed in 2020?',
            style: TextStyle(
                fontSize: 18
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          _getLottoNumbersInput(state),
          _getResultTexts(state),
        ],
      )
    );
  }

  Container _getLoadingIndicator() {
    return Container(
      child: Center(
        child: Text('Loading ...')
      ),
    );
  }

  Container _getLottoNumbersInput(LottoState state) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            offset: Offset(2,2),
            blurRadius: 6,
            spreadRadius: 1,
            color: Colors.black26
          )
        ]
      ),
      padding: EdgeInsets.all(24),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            'Choose your lucky numbers:',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87
            )
          ),
          SizedBox(height: 16),
          SizedBox(
            width: 300,
            child: LottoInput(
              crossed: state.currentNumbers
            )
          )
        ],
      ),
    );
  }

  Widget _getResultTexts(LottoState state) {
    if (state.searchResult == null) {
      return Container();
    }
    return Column(
      children: [
        SizedBox(height: 24),
        Text(
          'Costs: ${numberFormat.format(state.searchResult.costs)} £',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            'Prize: ${numberFormat.format(state.searchResult.prizeSum)} £ (and ${state.searchResult.match2count} free tickets)',
            style: TextStyle(
              fontSize: 20,
              //color: Colors.white
            ),
            textAlign: TextAlign.center,
          )
        ),
        SizedBox(height: 8),
        OutlineButton(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(32.0)),
          onPressed: () {
            setState(() {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LottoDetails(state: state);
                }
              );
            });
          },
          borderSide: BorderSide(
            color: Colors.white,
            width: 2
          ),
          child: Text(
            'DETAILS',
            style: TextStyle(
              color: Colors.white
            ),
          )
        )
      ]
    );
  }
}