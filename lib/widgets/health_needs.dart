
import 'package:bookmytime/screens/allAnnouncements_screen.dart';
import 'package:bookmytime/screens/askForHelp_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookmytime/models/announcement.dart';

final List<Announcement> announcements = [];
class HealthNeeds extends StatelessWidget {
  const HealthNeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomIcon> customIcons = [
      CustomIcon(icon: "assets/images/kits_medical.png", name: "Appointment"),
      CustomIcon(icon: "assets/images/help.png", name: "Extend our Hand"),
      CustomIcon(icon: "assets/images/asking_help.png", name: "Ask for Help"),
      CustomIcon(icon: "assets/images/others.png", name: "Further"),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(customIcons.length, (index) {
        return GestureDetector(
          onTap: () {
            if (customIcons[index].name == "Extend our Hand") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllAnnouncementsScreen(),
                ),
              );
            } 
            if (customIcons[index].name == "Ask for Help") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>const AskForHelpScreen(),
                ),
              );
            } else {
            }
          },
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Image.asset(customIcons[index].icon),
              ),
              const SizedBox(height: 6,),
              Text(customIcons[index].name),
            ],
          ),
        );
      }),
    );
  }
}

class CustomIcon {
  final String icon;
  final String name;

  CustomIcon({
    required this.icon,
    required this.name,
  });
}