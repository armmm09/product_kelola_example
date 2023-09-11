import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});
 Widget _buildInfoTile(String label, String value, IconData icon) {
    return ListTile(
      title: Textr(
        label,
        style: gfont.black,
      ),
      subtitle: Text(value),
      leading: Icon(icon),
      tileColor: Colors.white10, // Ganti warna border sesuai kebutuhan
      contentPadding: Ei.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     final key = GlobalKey();
    return  Scaffold(
       appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
              key: key,
              onPressed: () {
                final icons = [
                  La.info,
                  La.hatWizard,
                  La.steam,
                  La.star,
                  La.signOutAlt,
                  
                ];

                final options = [
                  'About',
                  'Privacy Policy',
                  'Setting',
                  'Rate App',
                  'Logout',
                  
                ].options(icons: icons);
                DropX.show(key, options: options);
              },
              icon: const Icon(La.bars))
        ],
      ),
      body: LzListView(
        children: [
          Column(
            crossAxisAlignment: Caa.center,
            children: <Widget>[
             const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/yuta.jpg'),
                  
                ),
              ),
              SizedBox(height: 40),
             _buildInfoTile('Name', 'Yuta Okkotsu', Icons.people_alt),
              SizedBox(height: 10),
              _buildInfoTile('Age', '19', Icons.cake),
              SizedBox(height: 10),
              _buildInfoTile('Hobby', 'Music', Icons.star),
              SizedBox(height: 10),
              _buildInfoTile('Job', 'Jujutsu Sorcerer', Icons.star),
            ],
          ),
        ],
      ),
    );
  }
}