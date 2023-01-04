import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zekr/controller/arabic_surah_number.dart';
import 'package:zekr/controller/constant.dart';
import 'package:zekr/view/mydrawer.dart';
import 'package:zekr/view/surah_builder.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({ Key? key }) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Go To bookmark',
        backgroundColor: Colors.lightBlue,
        onPressed: () async {
          fabIsClicked = true;
          if (await readBookMark() == true){
            Get.to(SurahBuilder(
              arabic: quran,
              surah: bookmarkedSurah - 1,
              surahName: arabicName[bookmarkedSurah - 1]['name'],
              ayah: bookmarkedAyah,
            ));
          }
        },
        child: const Icon(Icons.bookmark),
      ),
      drawer: const MyDrawer(),
      body: FutureBuilder(
        future: readJson(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done){
            if (snapshot.hasError){
              return const Text('Error');
            } else if (snapshot.hasData){
              return IndexCreator(snapshot.data,context);
            } else {
              return const Text('Empty');
            }
          }
          else {
            return Text('State ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}

Container IndexCreator(quran,context) {
  return Container(
    child: ListView(
      children: [
        for (int i = 0 ; i < 114 ; i++)
        Container(
          color: i % 2 == 0
          ? const Color.fromARGB(225, 253, 247, 230)
          : const Color.fromARGB(255, 253, 251, 240),
          child: TextButton(
            child: Row(
              children: [
                const SizedBox(width: 5),
                Text(
                  arabicName[i]['name'],
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black87,
                    fontFamily: arabicFont,
                    shadows: const [
                      Shadow(
                        offset: Offset(.5,.5),
                        blurRadius: 1.0,
                        color: Color.fromARGB(255, 130, 130, 130),
                      )
                    ]
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const Expanded(child: SizedBox()),
                ArabicSurahNumber(i: i),
              ],
            ),
            onPressed: () {
              fabIsClicked = false;
              Get.to(
                SurahBuilder(
                  arabic: quran,
                  surah: i,
                  surahName: arabicName[i]['name'],
                  ayah: 0,
                )
              );
            },
          ),
        )
      ],
    ),
  );
}