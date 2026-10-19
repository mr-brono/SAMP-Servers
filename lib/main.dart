import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(home: MainPage(), theme: ThemeData.dark(), debugShowCheckedModeBanner: false));

class MainPage extends StatefulWidget { @override State<MainPage> createState() => _MainPage(); }

class _MainPage extends State<MainPage> {
  List servers = [];
  bool loading = true;

  Future<void> load() async {
    try {
      final r = await http.get(Uri.parse('https://raw.githubusercontent.com/mr-brono/samp-server/main/servers.json'));
      servers = jsonDecode(r.body);
    } catch(e) {}
    setState(()=> loading = false);
  }

  void joinServer(String ip) async {
    // ده بيخلي اللعبة تفتح مباشرة على السيرفر
    // كأن تطبيقك هو اللي بيشغلها
    final uri = Uri.parse('samp://$ip');
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('لازم تثبت GTA SAMP Launcher الأول')));
    }
  }

  @override void initState(){ super.initState(); load(); }

  @override Widget build(BuildContext c) {
    return Scaffold(
      appBar: AppBar(title: Text('SAMP Servers')),
      body: loading ? Center(child: CircularProgressIndicator()) :
      ListView.builder(itemCount: servers.length, itemBuilder: (c,i){
        final s = servers[i];
        return Card(
          child: ListTile(
            title: Text(s['name']),
            subtitle: Text('${s['ip']} | ${s['mode']} | ${s['players']}'),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('JOIN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () => joinServer(s['ip']),
            ),
          ),
        );
      }),
    );
  }
}
