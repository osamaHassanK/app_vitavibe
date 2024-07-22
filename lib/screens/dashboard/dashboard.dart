import 'package:app_vitavibe/other/firebase/download_image_url_from_firestore.dart';
import 'package:app_vitavibe/other/overlays/notification_overlays/notification_overlays.dart';
import 'package:app_vitavibe/other/overlays/notification_overlays/showoverlays.dart';
import 'package:app_vitavibe/other/widgets/text_widget.dart';
import 'package:app_vitavibe/screens/guide_screen/guide_screen.dart';
import 'package:app_vitavibe/screens/uploadlist.dart';
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

  @override
  void initState() {
    super.initState();
    _fetchImageUrl();
  }

  Future<void> _fetchImageUrl() async {
    String? url = await getImageUrlFromFirestore();
    setState(() {
      imageUrl = url;
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      guideScreenWidget(context, imageUrl ?? ""),
      const Text('Supplement Reminder'),
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
            builder: (context) => IconButton(
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/icons/app-drawer.png', fit: BoxFit.cover),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UploadScreen()));
                // ShowOverlays showOverlays = ShowOverlays();
                // showOverlays.showOverlay(
                //   context,
                //   const NotificationOverlay(message: 'Welcome to VitaVibe!'),
                // );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Image.asset('assets/icons/notification.png', scale: 3),
              ),
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
