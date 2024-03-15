import 'package:flutter/material.dart';
import 'package:local_event_finder/global/model/local_event.dart';
import 'package:local_event_finder/global/tools/constants/constant_helper.dart';
import 'package:local_event_finder/global/tools/widgets/drawer.dart';
import 'package:local_event_finder/global/tools/widgets/event_card.dart';

class LocalEventList extends StatefulWidget {
  const LocalEventList({Key? key}) : super(key: key);

  @override
  State<LocalEventList> createState() => _LocalEventListState();
}

class _LocalEventListState extends State<LocalEventList> {
  List<Event> favoriteEvents = [];
  List<Event> filteredEvents = [];
  String searchText = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      filteredEvents = ConstantHelper.events!;
    });
  }

  void updateFavoriteEvents() {
    favoriteEvents.clear();
    for (var i = 0; i < ConstantHelper.events!.length; i++) {
      if (ConstantHelper.events![i].fav) {
        favoriteEvents.add(ConstantHelper.events![i]);
      }
    }
    filterEvents();
  }

  void toggleFavorite(Event event) {
    setState(() {
      event.fav = !event.fav;
      updateFavoriteEvents();
    });
  }

  void filterEvents() {
    if (searchText.isEmpty) {
      filteredEvents = ConstantHelper.events!;
    } else {
      filteredEvents = ConstantHelper.events!.where((event) {
        final eventName = event.name.toLowerCase();
        final searchTextLower = searchText.toLowerCase();
        return eventName.contains(searchTextLower);
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Events List"),
      ),
      drawer: AppMainDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                  filterEvents();
                });
              },
              decoration: InputDecoration(
                labelText: 'Search by event name',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EventCard(
                    event: filteredEvents[index],
                    eventIndex: index,
                    onFavoriteToggled: toggleFavorite,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
