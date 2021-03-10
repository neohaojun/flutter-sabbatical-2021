import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Root Widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("iEMB Posts")),
      body: ListView(
        children: [
          ListTile(
            title: Text('[Cyber Wellness] March - Gaming Addiction'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostPage()));
            },
          ),
        ],
      ),
    );
  }
}

// Post Page Widget
class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FavoriteButton(),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              '[Cyber Wellness] March - Gaming Addiction',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            contentPadding: EdgeInsets.all(16.0),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Tan Chee Wee'),
          ),
          ListTile(
            title: Text(
              '''Dear all,

This month, the focus on Cyber Wellness is on Gaming Addiction.

Despite the school's 7-2 rule which stipulates that students should not be gaming, there are still pockets of students who could not resist the temptation to game on their phones whenever they have some free time (before 7.30am, during recess or lunch, or waiting for CCA to start). While gaming is itself not an evil, the time in school should be spent on learning, whether academically or in co-curricular activities.

Are you one of those who lack the self discipline to manage your gaming urges?

Do visit this page to know more and how you can better manage your gaming habits.

Attached here is also an infographic to address the issue of gaming addiction. Hope it helps to serve as a reminder.

Regards,
Mr Tan''',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
          ListTile(
            leading: Icon(Icons.attachment),
            title: Text('Gaming Addiction.pdf'),
            trailing: Icon(Icons.file_download),
          ),
        ],
      ),
    );
  }
}

// Favorite Button Widget
class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  var isFavorited = false;

  @override
  Widget build(BuildContext context) {
    // Favorite Button
    return IconButton(
      icon: Icon(isFavorited ? Icons.star : Icons.star_border),
      color: isFavorited ? Colors.yellow : null,
      onPressed: () {
        setState(() {
          isFavorited = !isFavorited;
          print(isFavorited ? 'Favorited' : 'Unfavorited');
        });
      },
    );
  }
}
