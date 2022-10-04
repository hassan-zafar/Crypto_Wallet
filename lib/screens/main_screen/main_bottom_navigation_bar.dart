import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../../utilities/app_images.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppProvider navBar = Provider.of<AppProvider>(context);
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      selectedLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
      selectedItemColor: Theme.of(context).primaryColor,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      unselectedItemColor: Colors.grey,
      currentIndex: navBar.currentTap,
      onTap: (int index) => navBar.onTabTapped(index),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.homeUnselected)),
          activeIcon: ImageIcon(AssetImage(AppImages.homeSelected)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.profitUnselected)),
          activeIcon: ImageIcon(AssetImage(AppImages.profitSelected)),
          label: 'Profit',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 36,
            child: Image.asset(AppImages.exchangeIcon),
          ),
          label: 'Exchange',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.timeUnselected)),
          activeIcon: ImageIcon(AssetImage(AppImages.timeSelected)),
          label: 'Time',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(AppImages.profileUnselected)),
          activeIcon: ImageIcon(AssetImage(AppImages.profileSelected)),
          label: 'Profile',
        ),
      ],
    );
  }
}
