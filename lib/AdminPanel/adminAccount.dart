import 'package:firebasework/backend/AuthServices.dart';
import 'package:firebasework/utilities/constants.dart';
import 'package:flutter/material.dart';

class AdminAccount extends StatefulWidget {
  const AdminAccount({Key? key}) : super(key: key);

  @override
  State<AdminAccount> createState() => _AdminAccountState();
}

class _AdminAccountState extends State<AdminAccount> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        const DrawerHeader(
            padding: EdgeInsets.all(0),
            child: UserAccountsDrawerHeader(
                accountName: Text("AbdulSalam"),
                accountEmail: Text("Abdul@gmail.com"))),
        const ListTile(
          leading: Icon(
            Icons.person,
            size: 30,
            color: maincolor,
          ),
          title: Text(
            "Profile",
            style: TextStyle(color: maincolor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: maincolor,
          ),
        ),
        const Divider(
          height: 1,
        ),
        GestureDetector(
          onTap: () {},
          child: const ListTile(
            leading: Icon(
              Icons.shopping_cart,
              size: 30,
              color: maincolor,
            ),
            title: Text(
              "Cancel Orders",
              style: TextStyle(color: maincolor),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: maincolor,
            ),
          ),
        ),
        const Divider(
          height: 0,
        ),
        const ListTile(
          leading: Icon(
            Icons.card_giftcard,
            size: 30,
            color: maincolor,
          ),
          title: Text(
            "Total Orders",
            style: TextStyle(color: maincolor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: maincolor,
          ),
        ),
        const Divider(
          height: 0,
        ),
        const ListTile(
          leading: Icon(
            Icons.info,
            size: 30,
            color: maincolor,
          ),
          title: Text(
            "About",
            style: TextStyle(color: maincolor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: maincolor,
          ),
        ),
        const Divider(
          height: 0,
        ),
        const ListTile(
          leading: Icon(
            Icons.lock,
            size: 30,
            color: maincolor,
          ),
          title: Text(
            "Change",
            style: TextStyle(color: maincolor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: maincolor,
          ),
        ),
        const Divider(
          height: 0,
        ),
        const ListTile(
          leading: Icon(
            Icons.phone,
            size: 30,
            color: maincolor,
          ),
          title: Text(
            "Contact",
            style: TextStyle(color: maincolor),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: maincolor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () {
            AuthServices().googleSignOut(context);
          },
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 50),
              primary: maincolor,
              shape: const StadiumBorder()),
          child: const Text("Logout"),
        ),
      ]),
    );
  }
}
