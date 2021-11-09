import 'package:alura_flutter/screens/feed/feed_list.dart';
import 'package:alura_flutter/screens/transfers_web/contact_to_transfer_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: LayoutBuilder(
        builder: (context, contraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: contraints.maxHeight
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/bytebank_logo.png'),
                ),
                Container(
                  height: 120,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        MiniCard(icon: Icons.monetization_on, title: 'Transfer', onClick: () {
                          _showPage(context, ContactToTransferList());
                        }),
                        MiniCard(icon: Icons.description, title: 'Feed', onClick: () {
                          _showPage(context, Feed());
                        }),
                      ]
                  ),
                ),
              ],
            ),
          )
        )
      ),
    );
  }

  void _showPage(BuildContext context, Widget destiny) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => destiny));
  }
}

class MiniCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final Function onClick;

  const MiniCard({required this.icon, required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => this.onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(icon, color: Colors.white, size: 24.0),
                Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
