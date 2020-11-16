part of 'lotto_bloc.dart';

class LottoState extends Equatable {
  LottoState({
    @required this.currentNumbers,
    @required this.searchResult,
    @required this.initialized
  });

  final List<int> currentNumbers;
  final LottoHistorySearchResult searchResult;
  final bool initialized;

  LottoState copyWith(List<int> currentNumbers, LottoHistorySearchResult searchResult, bool initialized) {
    return new LottoState(
      currentNumbers: currentNumbers,
      searchResult: searchResult,
      initialized: initialized
    );
  }

  @override
  List<Object> get props => [currentNumbers, searchResult, initialized];
}

class LottoInitial extends LottoState {
  LottoInitial(): super(
    currentNumbers: [],
    searchResult: LottoHistorySearchResult(),
    initialized: false
  );
}

class LottoHistorySearchResult extends Equatable {
  final int match6count;
  final int match5withBonusCount;
  final int match5count;
  final int match4count;
  final int match3count;
  final int match2count;
  final int prizeSum;
  final int costs;
  final int gameCount;

  LottoHistorySearchResult({
    this.match6count = 0,
    this.match5withBonusCount = 0,
    this.match5count = 0,
    this.match4count = 0,
    this.match3count = 0,
    this.match2count = 0,
    this.prizeSum = 0,
    this.costs = 0,
    this.gameCount = 0
  });

  @override
  List<Object> get props => [
    match6count,
    match5withBonusCount,
    match5count,
    match4count,
    match3count,
    match2count,
    prizeSum,
    gameCount
  ];
}