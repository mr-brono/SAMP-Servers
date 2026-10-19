import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: ServersPage(),
    theme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ));
}

class ServersPage extends StatefulWidget {
  @override
  State<ServersPage> createState() => _ServersPageState();
}

class _ServersPageState extends State<ServersPage> {
  List servers = [];
  bool loading = true;
  String error = '';

  Future<void> loadServers() async {
    setState(() {
      loading = true;
      error = '';
    });
    try {
      // الرابط الصح بدون refs/heads
      const url = 'https://raw.githubusercontent.com/mr-brono/samp-server/main/servers.json';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        setState(() {
          servers = jsonDecode(response.body);
          loading = false;
        });
      } else {
        setState(() {
          error = 'خطأ ${response.statusCode} من GitHub';
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'فشل الاتصال: $e';
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadServers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SAMP Servers'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: loadServers)
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : error.isNotEmpty
              ? Center(child: Text(error, textAlign: TextAlign.center))
              : ListView.builder(
                  itemCount: servers.length,
                  itemBuilder: (context, i) {
                    final s = servers[i];
                    return Card(
                      child: ListTile(
                        title: Text(s['name']),
                        subtitle: Text("${s['ip']} - ${s['mode']}"),
                        trailing: Text(s['players'] ?? ''),
                      ),
                    );
                  },
                ),
    );
  }
}
