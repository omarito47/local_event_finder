import 'package:flutter/material.dart';
import 'package:local_event_finder/global/model/local_event.dart';
import 'package:local_event_finder/global/tools/constants/constant_helper.dart';
import 'package:local_event_finder/global/tools/widgets/drawer.dart';
import 'package:local_event_finder/global/tools/widgets/event_card.dart';

class LocalEventList extends StatefulWidget {
  const LocalEventList({super.key});

  @override
  State<LocalEventList> createState() => _LocalEventListState();
}

class _LocalEventListState extends State<LocalEventList> {
    List<Event> favoriteEvents = [];

  void updateFavoriteEvents() {
    favoriteEvents.clear();
    for (var i = 0; i < ConstantHelper.events!.length; i++) {
      if (ConstantHelper.events![i].fav) {
        favoriteEvents.add(ConstantHelper.events![i]);
      }
    }
  }

  void toggleFavorite(Event event) {
    setState(() {
      event.fav = !event.fav;
      updateFavoriteEvents();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Events List"),
      ),
      drawer: AppMainDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: ConstantHelper.events!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: EventCard(event: ConstantHelper.events![index],eventIndex: index,onFavoriteToggled: toggleFavorite),
              );
            },
          ),
        ),
      ),
    );
  }
}
