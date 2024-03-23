import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_basic/news/detail_berita.dart';
import 'package:flutter_basic/news/res/res_berita.dart';
import 'package:http/http.dart' as http;
class ListBerita extends StatefulWidget {
  const ListBerita({super.key});
  @override
  State<ListBerita> createState() => _ListBeritaState();
}
class _ListBeritaState extends State<ListBerita> {
  Future<List<Berita>?> getBerita() async {
    try {
      http.Response res = await http .get(Uri.parse("http://192.168.1.34/news_apps_server/getBerita.ph
          p"));
          return resBeritaFromJson(res.body).data;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
        future: getBerita(),
    builder: (BuildContext context,
    AsyncSnapshot<List<Berita>?> snapshot) {
    if (snapshot.hasData) {
    return ListView.builder(
    itemCount: snapshot.data?.length ?? 0,
    itemBuilder: (context, index) {
    Berita? data = snapshot.data?[index];
    return Padding(
    padding: const EdgeInsets.only(left: 8, top:
    8, right: 8),
    child: GestureDetector(
    onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (_) => DetailBerita(data)));
    },
    child: Card(
    child: Column(
    crossAxisAlignment:
    CrossAxisAlignment.start,
    children: [
    Padding(
    padding: const EdgeInsets.only(
    left: 4, top: 4, right: 4),
    child: ClipRRect(
    borderRadius:
    BorderRadius.circular(10),
    child: Image.network(
    "http://192.168.1.34/news_apps_server/gambar_berita/${data?.gambarBerita}",
      fit: BoxFit.fill,
    ),
    ),
    ),
      ListTile(
        title: Text(
          "${data?.judul}",
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        subtitle: Text(
          "${data?.isiBerita}",
          maxLines: 2,
          style: const TextStyle(
              fontSize: 12, color:
          Colors.grey),
        ),
      ),
    ],
    ),
    ),
    ),
    );
    });
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
