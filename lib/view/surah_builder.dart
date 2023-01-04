import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zekr/controller/constant.dart';

class SurahBuilder extends StatefulWidget {

  final surah;
  final arabic;
  final surahName;
  int ayah;

  SurahBuilder({ Key? key, this.surah, this.arabic, this.surahName, required this.ayah }) : super(key: key);

  @override
  _SurahBuilderState createState() => _SurahBuilderState();
}

class _SurahBuilderState extends State<SurahBuilder> {

  bool view = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumpToAyah());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int LengthOfSurah = nuOfVerses[widget.surah];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          leading: Tooltip(
            message: 'Mushaf Mode',
            child: TextButton(
              child: const Icon(
                Icons.chrome_reader_mode,
                color: Colors.white,
              ),
              onPressed: (){
                setState(() {
                  view = !view;
                });
              }
            ),
          ),
          centerTitle: true,
          title: Text(
            widget.surahName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontFamily: arabicFont,
              shadows: const [
                Shadow(
                  offset: Offset(1,1),
                  blurRadius: 2.0,
                  color: Color.fromARGB(255,0,0,0)
                )
              ]
            ),
          ),
          backgroundColor: const Color.fromARGB(255,56,115,59),
        ),
        body: SingleSurahBuilder(LengthOfSurah),
      ),
    );
  }

  jumpToAyah(){
    if (fabIsClicked){
      itemScrollController.scrollTo(index: widget.ayah , duration: const Duration(seconds: 3),curve: Curves.easeInOutCubic);
    }
    fabIsClicked = false;
  }



  Row verseBuilder(int index, previousVerse){
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.arabic[index + previousVerse]['aya_text'],
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: arabicFontSize.value,
                  fontFamily: arabicFont,
                  color: const Color.fromARGB(196,0,0,0)

                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  SafeArea SingleSurahBuilder(lengthOfSurah){

    String fullSurah = '';
    int previouseVerses = 0;
    if (widget.surah + 1 != 1){
      for (int i = widget.surah - 1 ; i >= 0 ; i--){
        previouseVerses = previouseVerses + nuOfVerses[i];
      }
    }

    if (!view)
      for (int i = 0; i < lengthOfSurah; i++) {
        fullSurah += (widget.arabic[i + previouseVerses]['aya_text']);
      }

    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 253, 251, 240),
        child: view ? ScrollablePositionedList.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                (index != 0) || (widget.surah == 0) || (widget.surah == 8)
                ? const Text('')
                : const returnBasmala(),
                Container(
                  color: index % 2 != 0
                  ? const Color.fromARGB(255,253,251,240)
                  : const Color.fromARGB(255,253,247,230),
                  child: PopupMenuButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: verseBuilder(index,previouseVerses),
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: () {
                          saveBookMark(widget.surah + 1 , index);
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.bookmark_add,
                              color: Color.fromARGB(255,56,115,59),
                            ),
                            SizedBox(width: 10),
                            Text('Bookmark')
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.share,
                              color: Color.fromARGB(255,56,115,59),
                            ),
                            SizedBox(width: 10),
                            Text('share')
                          ],
                        ),
                      )
                    ]
                  ),
                )
              ],
            );
          },
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          itemCount: lengthOfSurah,
        ) : Container(
          color: const Color.fromARGB(255,253,247,230),
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.surah + 1 != 1 && widget.surah +1 != 9
                        ? const returnBasmala()
                        : const Text(''),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            fullSurah,
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: mushafFontSize.value,
                              fontFamily: arabicFont,
                              color: Colors.black87
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }

}

class returnBasmala extends StatelessWidget {
  const returnBasmala({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Center(
            child: Text(
              'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
              style: TextStyle(
                fontFamily: 'me_quran', fontSize: 30,color: Colors.black
              ),
                textDirection: TextDirection.rtl,
            ),
        )
      ],
    );
  }
}