import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_lotto_retrospection/services/lotto_history_service.dart';

part 'lotto_event.dart';
part 'lotto_state.dart';

class LottoBloc extends Bloc<LottoEvent, LottoState> {
  LottoBloc({
    @required this.lottoHistoryService
  })  : super(LottoInitial());

  final LottoHistoryService lottoHistoryService;
  List<LottoResult> _lottoHistoryResults = [];

  @override
  Stream<LottoState> mapEventToState(
    LottoEvent event,
  ) async* {
    if (event is Initialize) {
      yield await _mapInitializeToState();
    }
    if (event is CrossNumber) {
      yield* _mapCrossNumberToState(event);
    }
  }

  Future<LottoState> _mapInitializeToState() async {
    _lottoHistoryResults = await lottoHistoryService.getHistoricalResults();

    return LottoState(
      currentNumbers: state.currentNumbers,
      searchResult: state.searchResult,
      initialized: true
    );
  }

  Stream<LottoState> _mapCrossNumberToState(CrossNumber event) async* {
    List<int> newNumbersList = List.from(state.currentNumbers);

    if (state.currentNumbers.contains(event.number)) {
      newNumbersList.remove(event.number);

      yield state.copyWith(newNumbersList, LottoHistorySearchResult(), true);
      return;
    }

    if (newNumbersList.length >= 6) {
      return;
    }

    newNumbersList.add(event.number);

    yield state.copyWith(newNumbersList, state.searchResult, true);

    LottoHistorySearchResult newResult = _calculateSearchResult(newNumbersList, _lottoHistoryResults/*await lottoHistoryService.getHistoricalResults()*/);

    yield state.copyWith(newNumbersList, newResult, true);
  }

  LottoHistorySearchResult _calculateSearchResult(List<int> numbers, List<LottoResult> results) {
    Set<int> numbersAsSet = Set.of(numbers);
    int match6count = 0;
    int match5withBonusCount = 0;
    int match5count = 0;
    int match4count = 0;
    int match3count = 0;
    int match2count = 0;
    int prizeSum = 0;
    int gameCount = results.length;

    for(LottoResult result in results) {
      Set winningNumbers = Set.of(result.correctNumbers.numbers);
      int correctNumbersCount;

      correctNumbersCount = numbersAsSet.intersection(winningNumbers).length;

      if (correctNumbersCount == 6) {
        prizeSum += result.prizes.match6.amount;

        match6count += 1;
      }

      if (correctNumbersCount == 5) {
        if (state.currentNumbers.contains(result.correctNumbers.bonus)) {
          match5withBonusCount += 1;
        }
        else {
          prizeSum += result.prizes.match5.amount;
          match5count += 1;
        }
      }

      else if (correctNumbersCount == 4) {
        prizeSum += result.prizes.match4.amount;
        match4count += 1;
      }

      else if (correctNumbersCount == 3) {
        prizeSum += result.prizes.match3.amount;
        match3count += 1;
      }

      else if (correctNumbersCount == 2) {
        prizeSum += result.prizes.match2.amount;
        match2count += 1;
      }
    }

    return LottoHistorySearchResult(
      match6count: match6count,
      match5withBonusCount: match5withBonusCount,
      match5count: match5count,
      match4count: match4count,
      match3count: match3count,
      match2count: match2count,
      prizeSum: prizeSum,
      costs: results.length * 2,
      gameCount: gameCount
    );
  }
}
