import 'package:flutter/material.dart';
import 'package:local_event_finder/global/model/local_event.dart';
import 'package:local_event_finder/global/tools/constants/constant_helper.dart';
import 'package:local_event_finder/global/tools/widgets/drawer.dart';
import 'package:local_event_finder/global/tools/widgets/event_card.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List<Event> favoriteEvents = [];

  @override
  void initState() {
    super.initState();
    updateFavoriteEvents();
  }

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
        title: Text("Favorites Local Events"),
      ),
      drawer: AppMainDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: favoriteEvents.isEmpty
              ? Text("No Favorites")
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: favoriteEvents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EventCard(
                        event: favoriteEvents[index],
                        eventIndex: index,
                        onFavoriteToggled: toggleFavorite,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}