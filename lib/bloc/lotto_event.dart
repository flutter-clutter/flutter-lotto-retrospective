part of 'lotto_bloc.dart';

abstract class LottoEvent extends Equatable {
  const LottoEvent();
}

class Initialize extends LottoEvent {
  @override
  List<Object> get props => [];
}

class CrossNumber extends LottoEvent {
  CrossNumber({
    this.number
  });

  final int number;

  @override
  List<Object> get props => [number];
}