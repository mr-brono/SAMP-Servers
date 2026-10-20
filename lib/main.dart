import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: MainPage(), theme: ThemeData.dark(), debugShowCheckedModeBanner: false));

class MainPage extends StatefulWidget { @override State<MainPage> createState() => _MainPage(); }

class _MainPage extends State<MainPage> {
  List servers = [];
  bool loading = true;

  final String hostingUrl = 'https://api.npoint.io/a7d31723dd';

  Future<void> load() async {
    setState(()=> loading = true);
    try {
      final r = await http.get(Uri.parse(hostingUrl));
      if(r.statusCode == 200) servers = jsonDecode(r.body);
    } catch(e){}
    setState(()=> loading = false);
  }

  @override void initState(){ super.initState(); load(); }

  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SAMP Servers'), actions: [IconButton(icon: Icon(Icons.refresh), onPressed: load)]),
      body: loading ? Center(child: CircularProgressIndicator()) :
      servers.isEmpty ? Center(child: Text('مفيش سيرفرات')) :
      ListView.builder(itemCount: servers.length, itemBuilder: (c,i){
        final s = servers[i];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(s['name'], style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${s['ip']} - ${s['mode']} - Ping ${s['ping']}'),
            trailing: Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(8)), child: Text(s['players'], style: TextStyle(color: Colors.white))),
          ),
        );
      }),
    );
  }
}
