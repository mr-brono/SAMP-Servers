import 'package:flutter/material.dart';
void main() => runApp(SAMPApp());
class SAMPApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData.dark(), home: HomeScreen());
  }
}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Map<String,String>> servers = [
    {"name":"EGY Life RP","ip":"51.75.33.12:7777","players":"85/200","mode":"Roleplay"},
    {"name":"Arab Police RP","ip":"135.125.44.5:7777","players":"42/100","mode":"Police"},
    {"name":"SAMP Servers PRO","ip":"192.168.1.1:7777","players":"12/50","mode":"Freeroam"},
  ];
  final nameCtrl = TextEditingController();
  final ipCtrl = TextEditingController();
  String mode = "Roleplay";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(backgroundColor: Colors.black, title: Row(children:[Text("S", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize:28)), Text(" SAMP Servers", style: TextStyle(color: Colors.white))])),
      body: _currentIndex == 0 ? buildServers() : _currentIndex == 1 ? buildMods() : buildAddServer(),
      bottomNavigationBar: BottomNavigationBar(backgroundColor: Colors.black, selectedItemColor: Colors.red, unselectedItemColor: Colors.white54, currentIndex: _currentIndex, onTap: (i)=> setState(()=> _currentIndex=i), items: [BottomNavigationBarItem(icon: Icon(Icons.storage), label:"Servers"), BottomNavigationBarItem(icon: Icon(Icons.extension), label:"Mods"), BottomNavigationBarItem(icon: Icon(Icons.add), label:"Add Server")]),
    );
  }
  Widget buildServers() {
    return ListView.builder(padding: EdgeInsets.all(12), itemCount: servers.length, itemBuilder: (c,i){ return Card(color: Color(0xFF1E1E1E), margin: EdgeInsets.only(bottom:12), child: ListTile(leading: CircleAvatar(backgroundColor: Colors.green, radius:6), title: Text(servers[i]["name"]!, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold)), subtitle: Text("${servers[i]["ip"]} • ${servers[i]["mode"]} • ${servers[i]["players"]}", style: TextStyle(color:Colors.white54, fontSize:12)), trailing: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: Text("JOIN"), onPressed: (){})));});
  }
  Widget buildMods() {
    return GridView.count(crossAxisCount: 2, padding: EdgeInsets.all(12), children: [modCard("Anti-Cheat","أساسي"), modCard("Admin System","أساسي"), modCard("Factions 5","شرطة جيش حكومة طب اطفاء"), modCard("Vehicles","سيارات"), modCard("Houses","بيوت"), modCard("Mapping","مباني")]);
  }
  Widget modCard(String name, String cat) { return Card(color: Color(0xFF1E1E1E), child: Column(mainAxisAlignment: MainAxisAlignment.center, children:[Icon(Icons.folder_special, size:40, color:Colors.red), SizedBox(height:8), Text(name, style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold)), Text(cat, style: TextStyle(color:Colors.white54, fontSize:11), textAlign: TextAlign.center), SizedBox(height:8), ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black), onPressed: (){}, child: Text("تحميل"))]));}
  Widget buildAddServer() {
    return SingleChildScrollView(padding: EdgeInsets.all(16), child: Column(children: [SizedBox(height:10), Text("إنشاء سيرفر جديد", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), SizedBox(height:20), TextField(controller: nameCtrl, style: TextStyle(color:Colors.white), decoration: InputDecoration(labelText:"اسم السيرفر", filled:true, fillColor: Color(0xFF1E1E1E), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))), SizedBox(height:12), TextField(controller: ipCtrl, style: TextStyle(color:Colors.white), decoration: InputDecoration(labelText:"IP:Port", filled:true, fillColor: Color(0xFF1E1E1E), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))), SizedBox(height:12), DropdownButtonFormField(value: mode, dropdownColor: Colors.black, style: TextStyle(color:Colors.white), items: ["Roleplay","Police","Freeroam","DM","Drift"].map((e)=>DropdownMenuItem(value:e, child:Text(e))).toList(), onChanged: (v)=> setState(()=> mode=v.toString()), decoration: InputDecoration(labelText:"نوع السيرفر", filled:true, fillColor: Color(0xFF1E1E1E), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))), SizedBox(height:20), SizedBox(width: double.infinity, height:50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text("إضافة سيرفري الآن", style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)), onPressed: () { if(nameCtrl.text.isEmpty || ipCtrl.text.isEmpty) return; setState(() { servers.add({"name": nameCtrl.text, "ip": ipCtrl.text, "players":"0/100", "mode": mode});}); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("تم إضافة ${nameCtrl.text}"))); nameCtrl.clear(); ipCtrl.clear(); setState(()=> _currentIndex=0);} ))]));
  }
}
