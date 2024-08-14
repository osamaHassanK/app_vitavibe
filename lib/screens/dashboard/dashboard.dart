import 'package:app_vitavibe/other/firebase/download_image_url/download_image_url_from_firestore.dart';
import 'package:app_vitavibe/other/firebase/fetch_health_tips/fetch_and_add_health_tips.dart';
import 'package:app_vitavibe/other/overlays/notification_overlays/notification_overlays.dart';
import 'package:app_vitavibe/other/overlays/notification_overlays/showoverlays.dart';
import 'package:app_vitavibe/other/widgets/text_widget.dart';
import 'package:app_vitavibe/screens/guide_screen/guide_screen.dart';
import 'package:app_vitavibe/screens/reminder_screen/reminder_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/dashboard_bloc/dashboard_bloc.dart';
import '../../bloc/dashboard_bloc/dashboard_event.dart';
import '../../bloc/dashboard_bloc/dashboard_state.dart';
import '../drawer/drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? imageUrl;
  bool isOverlayOpen = false;
  List<Map<String, dynamic>> tips = [];

  @override
  void initState() {
    super.initState();
    _fetchImageUrlAndTips();
  }

  Future<void> _fetchImageUrlAndTips() async {
   // String? url = await getImageUrlFromFirestore();
    List<Map<String, dynamic>> fetchedTips = await FetchHealthTips.fetchAndPrintRandomHealthTips();
    setState(() {
   //   imageUrl = url;
      tips = fetchedTips;
    });
  }

  @override
  Widget build(BuildContext context) {
    ShowOverlays _showOverlays = ShowOverlays();
    List<Widget> widgetOptions = <Widget>[
      guideScreenWidget(context,
          //imageUrl ?? "",
          tips),
      ReminderScreen(),
    ];

    final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: Scaffold(
        drawer: CustomDrawer(
          drawerKey: key,
        ),
        appBar: AppBar(
          elevation: 1,
          title: const TextWidget(text: 'Vita Vibe', fontSize: 24),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.black12,
          centerTitle: true,
          leading: Builder(
            builder: (context) =>
                IconButton(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/icons/app-drawer.png',
                        fit: BoxFit.cover),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
          ),
          actions: [
            BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                return InkWell(
                  onTap: () {
                    final isOverlayOpen = state.isOverlayOpenValue;
                    if (isOverlayOpen) {
                      _showOverlays.removeOverlay();
                      context.read<DashboardBloc>().add(ShowNotificationOverlay(isOverlayOpen: false));
                    } else {
                      _showOverlays.showOverlay(
                        context,
                        NotificationOverlay(
                          closeMethod: () {
                            _showOverlays.removeOverlay();
                            context.read<DashboardBloc>().add(ShowNotificationOverlay(isOverlayOpen: false));
                          },
                        ),
                      );
                      context.read<DashboardBloc>().add(ShowNotificationOverlay(isOverlayOpen: true));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: Image.asset('assets/icons/notification.png', scale: 3),
                  ),
                );

              },
            ),
          ],
        ),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Center(
              child: widgetOptions.elementAt(state.selectedIndex),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return BottomNavigationBar(
              selectedLabelStyle: const TextStyle(fontFamily: 'f', fontSize: 12),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/book.png', scale: 4.5),
                  label: 'Guide',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/icons/reminder.png', scale: 2.17),
                  label: 'Reminder',
                ),
              ],
              currentIndex: state.selectedIndex,
              selectedItemColor: Colors.black87,
              unselectedLabelStyle: const TextStyle(fontFamily: 'f', fontSize: 12),
              unselectedItemColor: Colors.black,
              onTap: (index) {
                BlocProvider.of<DashboardBloc>(context).add(TabUpdated(index));
              },
            );
          },
        ),
      ),
    );
  }
}
