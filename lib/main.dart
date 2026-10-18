import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const SERVERS_URL = 'https://raw.githubusercontent.com/mr-brono/samp-server/refs/heads/main/servers.json';

void main() => runApp(MaterialApp(home: ServersPage(), theme: ThemeData.dark()));

class ServersPage extends StatefulWidget { @override State<ServersPage> createState()=> _S(); }
class _S extends State<ServersPage>{
  late Future<List> _f;
  Future<List> getData() async {
    final r = await http.get(Uri.parse(SERVERS_URL));
    return jsonDecode(r.body);
  }
  @override void initState(){ super.initState(); _f=getData(); }
  @override Widget build(BuildContext c){
    return Scaffold(
      appBar: AppBar(title: Text('SAMP - mr-brono'), actions:[IconButton(icon:Icon(Icons.refresh), onPressed:()=>setState(()=>_f=getData()))]),
      body: FutureBuilder<List>(future:_f, builder:(c,s){
        if(!s.hasData) return Center(child:CircularProgressIndicator());
        final list=s.data!;
        return ListView.builder(itemCount:list.length, itemBuilder:(c,i){
          final x=list[i];
          return Card(child:ListTile(title:Text(x['name']), subtitle:Text(x['ip']), trailing:Text(x['players']??'')));
        });
      }),
    );
  }
}
