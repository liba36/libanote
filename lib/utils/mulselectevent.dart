import 'package:event_bus/event_bus.dart';

EventBus eventBus = new EventBus();

class muldiaryselect
{
  bool MulSelectEndable;
  muldiaryselect(this.MulSelectEndable);
}

class diaryslected
{
  bool statu;
  int id;
  diaryslected(this.statu,this.id);
}