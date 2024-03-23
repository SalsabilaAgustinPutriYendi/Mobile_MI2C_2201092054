import 'package:flutter/material.dart';
import 'package:project1mobilelanjut/screen_page/detail_berita.dart';
import '../model/Model_berita.dart';
import 'package:http/http.dart' as http;

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {

  Future<List<Datum>?> getBerita() async{
    try{
      //berhasil
      http.Response response = await
          http.get(Uri.parse('http://192.168.70.194:/Mobile/beritaDb/getBerita.php'));

      return modelBeritaFromJson(response.body).data;
      //kondisi gagal untuk mendapatkan respon api
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getBerita(),
        builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index)
                {
                  Datum? data = snapshot.data?[index];
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>
                        DetailBerita(data)));

                        //Ini untuk ke detail
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network
                                ('http://192.168.70.194:/Mobile/beritaDb/gambar_berita/${data?.gambarBerita}',
                              fit: BoxFit.fill,
                              ),

                            ),
                          ),
                            ListTile(
                              title: Text(
                                '${data?.judul}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 18
                                ),
                              ),
                              subtitle: Text(
                                '${data?.isiBerita}',
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },

            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }
}
