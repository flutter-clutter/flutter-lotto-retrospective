import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart' show rootBundle;

class LottoHistoryService {
  List<LottoResult> _cachedList;

  Future<List<LottoResult>> getHistoricalResults() async {
    if (_cachedList == null) {
      List<dynamic> json = await _getJsonFromFile();
      _cachedList = _jsonToSearchTypes(json);
    }

    return _cachedList;
  }

  Future<List<dynamic>> _getJsonFromFile() async {
    String jsonString = await rootBundle.loadString('assets/historical_data.json');

    return jsonDecode(jsonString)['data'];
  }

  List<LottoResult> _jsonToSearchTypes(List<dynamic> json) {
    List<LottoResult> lottoResults = [];

    for (var element in json) {
      lottoResults.add(
        LottoResult.fromJson(element)
      );
    }

    return lottoResults;
  }
}

class LottoResult {
  Prizes prizes;
  DateTime dateTime;
  CorrectNumbers correctNumbers;

  LottoResult({
    @required this.prizes,
    @required this.dateTime,
    @required this.correctNumbers
  });

  LottoResult.fromJson(Map<dynamic, dynamic> json) {
    this.dateTime = DateTime.parse(json['date']);
    this.prizes = Prizes(
      match6: Prize(amount: json['prize']),
      match5plusBonus: Prize(amount: 1000000),
      match5: Prize(amount: 1000000),
      match4: Prize(amount: 1750),
      match3: Prize(amount: 140),
      match2: Prize(amount: 0),
    );

    List<int> numbers = [];

    for (var number in json['numbers']) {
      numbers.add(number);
    }
    this.correctNumbers = CorrectNumbers(
      numbers: numbers
    );
  }
}

class Prizes {
  Prize match6;
  Prize match5plusBonus;
  Prize match5;
  Prize match4;
  Prize match3;
  Prize match2;

  Prizes({
    @required this.match6,
    @required this.match5plusBonus,
    @required this.match5,
    @required this.match4,
    @required this.match3,
    @required this.match2,
  });
}

class Prize {
  int amount;
  int winners;

  Prize({
    @required this.amount,
    this.winners = 0
  });
}

class CorrectNumbers {
  @required List<int> numbers;
  @required int bonus;

  CorrectNumbers({
    this.numbers,
    this.bonus
  });
}