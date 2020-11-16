import 'package:flutter/material.dart';
import 'package:flutter_lotto_retrospection/bloc/lotto_bloc.dart';

class LottoDetails extends StatelessWidget{
  LottoDetails({
    this.state
  });

  final LottoState state;

  @override
  Widget build(BuildContext context) {
    if (state == null) {
      return Container();
    }

    return AlertDialog(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(8.0)
            )
        ),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Game details',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                )
              ),
              SizedBox(height: 24),
              _getTextRow('Games played:\n${state.searchResult.gameCount}'),
              _getTextRow('Games with 2 matches:\n${state.searchResult.match2count}'),
              _getTextRow('Games with 3 matches:\n${state.searchResult.match3count}'),
              _getTextRow('Games with 4 matches:\n${state.searchResult.match4count}'),
              _getTextRow('Games with 5 matches:\n${state.searchResult.match5count}'),
              _getTextRow('Games with 5 matches and bonus:\n${state.searchResult.match5withBonusCount}'),
              _getTextRow('Games with 6 matches:\n${state.searchResult.match6count}'),
              SizedBox(height: 24),
              OutlineButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(32.0)),
                borderSide: BorderSide(
                    color: Colors.white,
                    width: 2
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.white
                  ),
                )
              ),
            ]
        )
    );
  }

  Text _getTextRow(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white
      ),
      textAlign: TextAlign.center,
    );
  }
}