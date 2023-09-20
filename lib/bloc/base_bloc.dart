
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {

  final _progressSubject = BehaviorSubject<bool>();
  Stream<bool> get progressObservable => _progressSubject.stream;
  Function(bool) get triggerProgress => _progressSubject.sink.add;

  void init();

  void dispose();

}
