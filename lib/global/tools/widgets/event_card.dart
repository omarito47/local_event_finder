import 'package:flutter/material.dart';
import 'package:local_event_finder/global/model/local_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventCard extends StatefulWidget {
  final Event event;
  final int eventIndex;
  final Function(Event) onFavoriteToggled;

  EventCard({required this.event, required this.eventIndex, required this.onFavoriteToggled});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.event.imageUrl,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.event.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        widget.event.fav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.event.fav ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          widget.onFavoriteToggled(widget.event);
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  widget.event.time,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.event.description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  'Organized by: ${widget.event.organizers}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}