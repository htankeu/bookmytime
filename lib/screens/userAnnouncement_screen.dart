import 'package:bookmytime/services/announcement/announcement_service.dart';
import 'package:bookmytime/services/theme_provider.dart';
import 'package:bookmytime/tools/pallete.dart';
import 'package:bookmytime/widgets/announce_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAnnouncementScreen extends StatefulWidget {
  const UserAnnouncementScreen({Key? key}) : super(key: key);

  @override
  _UserAnnouncementScreenState createState() => _UserAnnouncementScreenState();
}

class _UserAnnouncementScreenState extends State<UserAnnouncementScreen> {
  final AnnouncementService _announcementService = AnnouncementService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _announcementService.getUserAnnouncementsSecond(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
          // ignore: prefer_is_empty
        } else if (snapshot.data!.isEmpty || snapshot.data!.length == 0) {
          return const Center(
            child: Text("Any data are available"),
          );
        } else {
          List<Map<String, dynamic>> announcements = snapshot.data!;
          return _buildAnnounceElement(announcements);
        }
      },
    );
  }

  Widget _buildAnnounceElement(List<Map<String, dynamic>> snapshot) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      color: themeProvider.currentTheme.primaryColor,
      height: snapshot.length * 100,
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1.5,
              mainAxisSpacing: 15.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return AnnounceCard(
                    location: snapshot[index]['location'],
                    description: snapshot[index]['title'],
                    startTime: snapshot[index]['startDateTime'].toDate(),
                    endTime: snapshot[index]['endDateTime'].toDate(),
                    grobDesc: snapshot[index]['description'],
                    creatorId: snapshot[index]['userId'],
                    cardColor: Pallete.whiteColor);
              },
              childCount: snapshot.length,
            ),
          )
        ],
      ),
    );
  }
}
