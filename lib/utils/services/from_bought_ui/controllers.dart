import 'package:get/get_state_manager/src/simple/get_controllers.dart';



// below is no controller and is only temporarly needed

class ModalEvent {
  String? image;
  String? name;
  String? date;
  String? price;

  ModalEvent(this.image, this.name, this.date, this.price);
}



class PopularEventController extends GetxController {
  var searchController;

  //todo ModalPopularEvent is the data model of the bought UI --> switch to ours
  // todo: the events are statically initialized, might be necessary to apply new logic
  List<ModalEvent> newPopularEventLists = [
    ModalEvent(
        "concert_1.jpeg", "Art Festival", "25 July, 02:00 pm", "\$25.33"),
    ModalEvent(
        "concert_2.jpeg", "Corporate Event", "27 July, 08:00 pm", "\$23.53"),
    ModalEvent(
        "community_1.jpeg", "Food Festivals", "29 July, 02:00 pm", "\$28.99"),
    ModalEvent(
        "concert_1.jpeg", "Art Festival", "25 July, 02:00 pm", "\$25.33"),
    ModalEvent(
        "concert_2.jpeg", "Corporate Event", "27 July, 08:00 pm", "\$23.53"),
    ModalEvent(
        "community_1.jpeg", "Food Festivals", "29 July, 02:00 pm", "\$28.99"),
    ModalEvent(
        "concert_1.jpeg", "Art Festival", "25 July, 02:00 pm", "\$25.33"),
    ModalEvent(
        "concert_2.jpeg", "Corporate Event", "27 July, 08:00 pm", "\$23.53"),
    ModalEvent(
        "community_1.jpeg", "Food Festivals", "29 July, 02:00 pm", "\$28.99")
  ];

  onItemChanged(String value) {
    newPopularEventLists = [
      ModalEvent(
          "popular1.png", "Art Festival", "25 July, 02:00 pm", "\$25.33"),
      ModalEvent(
          "popular2.png", "Corporate Event", "27 July, 08:00 pm", "\$23.53"),
      ModalEvent(
          "popular3.png", "Food Festivals", "29 July, 02:00 pm", "\$28.99")
    ]
        .where((string) =>
        string.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }
}