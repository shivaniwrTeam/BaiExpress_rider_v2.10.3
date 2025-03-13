import 'package:deliveryboy_multivendor/Screens/Return/Return.dart';
import 'package:deliveryboy_multivendor/Widget/setSnackbar.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import '../../Helper/color.dart';
import '../../Helper/constant.dart';
import '../../Widget/desing.dart';
import '../CashCollection/cash_collection.dart';
import '../Home/home.dart';
import '../WalletHistory/wallet_history.dart';
import '../getDrawer/drawerWidget.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Widget> fragments;
  int _curBottom = 0;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    fragments = [
      Home(),
      ReturnOrder(),
      WalletHistory(isBack: false),
      CashCollection(
        isBack: false,
      ),
      GetDrawerWidget(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _curBottom == 0 &&
          !(currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) >
                  const Duration(seconds: 2)),
      onPopInvokedWithResult: (didPop, result) {
        if (_curBottom != 0) {
          setState(
            () {
              _curBottom = 0;
            },
          );
        } else {
          DateTime now = DateTime.now();

          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            currentBackPressTime = now;
            setSnackbar('Press back again to Exit', context);
            setState(() {});
          }
        }
      },
      child: Scaffold(
        bottomNavigationBar: getBottomNav(),
        body: fragments[_curBottom],
      ),
    );
  }

  getBottomNav() {
    return Container(
      decoration: const BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(circularBorderRadius13)),
          boxShadow: [
            BoxShadow(
                color: black12,
                offset: Offset(0, -3),
                blurRadius: 6,
                spreadRadius: 0)
          ],
          color: white),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(circularBorderRadius12),
          topLeft: Radius.circular(circularBorderRadius12),
        ),
        child: BottomNavigationBar(
          unselectedItemColor: grey3,
          selectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          unselectedLabelStyle: Theme.of(context).textTheme.bodySmall,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('Home_inactive'),
                height: 25,
                width: 25,
                // colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('Home_active'),
                height: 25,
                width: 25,
                // colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('Return_inactive'),
                height: 25,
                width: 25,
                // colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('Return_active'),
                height: 25,
                width: 25,
                // colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
              ),
              label: 'Return',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('wallet_inactive'),
                height: 25,
                width: 25,
                // colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('wallet_active'),
                height: 25,
                width: 25,
                // colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
              ),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('Cash_Collection_inactive'),
                height: 25,
                width: 25,
                // colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('Cash_Collection_active'),
                height: 25,
                width: 25,
                // colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
              ),
              label: 'Cash Collection',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('Profile_inactive'),
                height: 25,
                width: 25,
                // colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                DesignConfiguration.setSvgPath('Profile_active'),
                height: 25,
                width: 25,
                // colorFilter: const ColorFilter.mode(black, BlendMode.srcIn),
              ),
              label: 'Profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _curBottom,
          selectedItemColor: black,
          onTap: (int index) {
            if (mounted) {
              setState(
                () {
                  _curBottom = index;
                },
              );
            }
          },
          elevation: 25,
        ),
      ),
    );
  }
}
