
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zekr/controller/changeTheme.dart';
import 'package:zekr/view/info.dart';
import 'package:zekr/view/settings.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).scaffoldBackgroundColor,

        width: 233,
        
        child: Column(children: [
          
          Padding(
            padding: const EdgeInsets.only(top: 40,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  alignment: Alignment.topRight,
                  icon: const Icon(CupertinoIcons.moon_stars_fill,color: Colors.grey,),
                  onPressed: (){
                    Themes().changeTheme();
                  },
                ),
              ],
            ),
          ),
          
          Container(margin: const EdgeInsets.symmetric(horizontal: 30), child: Image.asset("assets/quran/qaba.png",fit: BoxFit.cover)),
          
          const SizedBox(height: 33),

          InkWell(
            child: Card(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(side: const BorderSide(width: 1),borderRadius: BorderRadius.circular(33)),
              margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.home_outlined,size: 30),
                  const SizedBox(width: 8,height: 55,),
                  Text("1".tr,textAlign: TextAlign.center,style: Theme.of(context).textTheme.displayMedium),
                ],)
            ),
            onTap: (){
              Get.back();
            }
          ),

          InkWell(
            child: Card(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(side: const BorderSide(width: 1),borderRadius: BorderRadius.circular(33)),
              margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.settings,size: 30),
                  const SizedBox(width: 30,height: 55,),
                  Text("2".tr,textAlign: TextAlign.center,style: Theme.of(context).textTheme.displayMedium),
                ],
              )
            ),
            onTap: (){
              Get.to(() => Settings());
            },
          ),

          InkWell(
            child: Card(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(side: const BorderSide(width: 1),borderRadius: BorderRadius.circular(33)),
              margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.info,size: 30),
                  const SizedBox(width: 18,height: 55,),
                  Text("10".tr,textAlign: TextAlign.center,style: Theme.of(context).textTheme.displayMedium),
                ],
              )
            ),
            onTap: (){
              Get.to(() => const Info());
            },
          ),

        ]
      ),
    );
  }
}















// ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//             ),
//             child: Column(
//               children: [
//                 // Image.asset(
//                 //   'assets/quran.png',
//                 //   height: 80,
//                 // ),
//                 const Text(
//                   'Al Quran',
//                   style: TextStyle(fontSize: 20),
//                 ),

//               ],
//             ),
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.settings,
//             ),
//             title: const Text(
//               'Settings',
//             ),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => Settings()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.share,
//             ),
//             title: const Text(
//               'Share',
//             ),
//             onTap: () {
// //               Share.share('''*Quran app*\n
// // u can develop it from my github github.com/itsherifahmed ''');
// //               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.rate_review,
//             ),
//             title: const Text(
//               'Rate',
//             ),
//             onTap: () async {
//               // if (!await launchUrl(quranAppurl,
//               //     mode: LaunchMode.externalApplication)) {
//               //   throw 'Could not launch $quranAppurl';
//               // }
//             },
//           ),

//         ],
//       ),