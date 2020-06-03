import 'package:factory2homes/screens/login_screen.dart';
import 'package:factory2homes/screens/order_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawerNavigation extends StatefulWidget {
  @override
  _SideDrawerNavigationState createState() => _SideDrawerNavigationState();
}

class _SideDrawerNavigationState extends State<SideDrawerNavigation> {
  SharedPreferences _prefs;
  String _loginLogoutMenuText = "Log In";
  IconData _loginLogoutIcon = FontAwesomeIcons.signInAlt;

  @override
  void initState() {
    super.initState();
    _isLoggedIn();
  }

  _isLoggedIn() async {
    _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    if (userId == 0) {
      setState(() {
        _loginLogoutMenuText = "Log Out";
        _loginLogoutIcon = FontAwesomeIcons.signInAlt;
      });
    } else {
      setState(() {
        _loginLogoutMenuText = "Log In";
        _loginLogoutIcon = FontAwesomeIcons.signOutAlt;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.redAccent,
      child: Drawer(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                height: size.height / 12,
                color: Colors.redAccent,
                child: Center(
                  child: ListTile(
                      title: Text(
                        'Home',
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      trailing: Image.network(
                        "https://img.maximummedia.ie/her_ie/eyJkYXRhIjoie1widXJsXCI6XCJodHRwOlxcXC9cXFwvbWVkaWEtaGVyLm1heGltdW1tZWRpYS5pZS5zMy5hbWF6b25hd3MuY29tXFxcL3dwLWNvbnRlbnRcXFwvdXBsb2Fkc1xcXC8yMDE1XFxcLzA4XFxcLzA2MTUzOTM0XFxcL2FtYXpvbi5qcGdcIixcIndpZHRoXCI6NzAwLFwiaGVpZ2h0XCI6MzcwLFwiZGVmYXVsdFwiOlwiaHR0cHM6XFxcL1xcXC93d3cuaGVyLmllXFxcL2Fzc2V0c1xcXC9pbWFnZXNcXFwvaGVyXFxcL25vLWltYWdlLnBuZz9pZD1kNDgyODZlN2RlZWNmYzIzZWVjNlwiLFwib3B0aW9uc1wiOltdfSIsImhhc2giOiI1YWU5M2I3MDA2MTc0OThhZDc2ODQxNDFiNjRjYWJmNGEyNDg0ZTViIn0=/amazon.jpg",
                        height: size.height / 15,
                        width: size.width / 4,
                      )),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderListScreen()));
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: IconButton(
                            icon: Icon(Icons.list), onPressed: null)),
                    Expanded(flex: 8, child: Text('All Orders'))
                  ],
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: IconButton(
                            icon: Icon(_loginLogoutIcon), onPressed: null)),
                    Expanded(flex: 8, child: Text(_loginLogoutMenuText))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
