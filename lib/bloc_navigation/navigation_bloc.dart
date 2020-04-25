import 'package:bloc/bloc.dart';
import '../mypages/mycardpage/mycard.dart';
import '../mypages/homepage/homepage.dart';
import '../mypages/addoreditcard.dart';
import '../mypages/generateqr.dart';

enum EventType {
  HomePageClickedEvent,
  MyCardClickedEvent,
  AddOrEditCardEvent,
  GenerateQREvent
}

class NavigationEvents {
  EventType _eventType;
  var valueToPass;

  NavigationEvents(this._eventType, this.valueToPass);

  NavigationEvents.onlyEvent(EventType eventType) {
    _eventType = eventType;
    valueToPass = null;
  }
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event._eventType) {
      case EventType.HomePageClickedEvent:
        yield HomePage();
        break;
      case EventType.MyCardClickedEvent:
        yield MyCard();
        break;
      case EventType.AddOrEditCardEvent:
        yield AddOrEditCard(event.valueToPass);
        break;
      case EventType.GenerateQREvent:
        yield GenerateQR.valueString(event.valueToPass);
        break;
    }
  }
}
