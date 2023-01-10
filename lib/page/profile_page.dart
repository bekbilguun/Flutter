import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile/model/user.dart';
import 'package:profile/page/edit_profile_page.dart';
import 'package:profile/page/product/products_screen.dart';
import 'package:profile/page/sale/sale_screen.dart';
import 'package:profile/page/sale/sales_screen.dart';
import 'package:profile/page/customer/customers_screen.dart';
import 'package:profile/utils/user_preferences.dart';
import 'package:profile/widget/appbar_widget.dart';
import 'package:profile/widget/button_widget.dart';
import 'package:profile/widget/numbers_widget.dart';
import 'package:profile/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                  setState(() {});
                },
              ),
              const SizedBox(height: 24),
              buildName(user),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: buildProductButton(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: buildCustomerButton(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: buildSalesButton(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15),
                    child: buildSaleButton(),
                  ),
                ],
              ),

              // Center(child: buildCustomerButton()),
              // Center(child: buildProductButton()),
              // Center(child: buildSaleButton()),
              const SizedBox(height: 24),
              NumbersWidget(),
              const SizedBox(height: 48),
              buildAbout(user),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildCustomerButton() => ButtonWidget(
        text: 'Customer',
        onClicked: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CustomersScreen()));
          setState(() {});
        },
      );

  Widget buildProductButton() => ButtonWidget(
        text: 'Product',
        onClicked: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProductsScreen()));
          setState(() {});
        },
      );

  Widget buildSaleButton() => ButtonWidget(
        text: 'Sale',
        onClicked: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SaleScreen()));
          setState(() {});
        },
      );

  Widget buildSalesButton() => ButtonWidget(
        text: 'Sales',
        onClicked: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SalesScreen()));
          setState(() {});
        },
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
