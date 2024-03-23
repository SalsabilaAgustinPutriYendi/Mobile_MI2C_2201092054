import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageSearchList extends StatefulWidget {
  const PageSearchList({super.key});

  @override
  State<PageSearchList> createState() => _PageSearchListState();
}

class _PageSearchListState extends State<PageSearchList> {
  //Item array utk data list
  List<String> ListDevice=[
    "Iphone",
    "Xiomi",
    "Oppo",
    "Vivo",
    "Samsung",
    "sony",
    "Ipad",
    "Iwatch",
    "Macbook",
    "Lenovo thinkpad",
  ];
  bool isCari = true;
  List<String> filterDevice=[];
  TextEditingController txtCari = TextEditingController();

  _PageSearchListState(){
    txtCari.addListener(() {
      if(txtCari.text.isEmpty){
        setState(() {
          isCari = true;
          txtCari.text != "";
        });
      }
      else {
        setState(() {
          isCari = false;
          txtCari.text != "";

        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search List"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: txtCari,
              decoration: InputDecoration(
                hintText: "Search..",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                    ),
                filled: true,
                fillColor: Colors.green.withOpacity(0.1)
              ),
            ),
            //kondisi untuk data list
            isCari ? Expanded(
              child: ListView.builder(
                  itemCount: ListDevice.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      title: Text(ListDevice[index]),
                    );

                  }),
            ):
                CreateFilterList()
          ]
        ),
      ),
    );
  }

  Widget CreateFilterList(){
    filterDevice =  [];
    for(int i = 0; i<ListDevice.length; i++){
      var item = ListDevice[i];
      if(item.toLowerCase().contains(txtCari.text.toLowerCase())){
        filterDevice.add(item);
      }
    }
    return HasilSearch();
  }


  Widget HasilSearch(){
    return Expanded(
      child: ListView.builder(
          itemCount: filterDevice.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(filterDevice[index]),
            );
          },
      ),
    );
  }
}
