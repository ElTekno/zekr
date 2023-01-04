import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zekr/controller/changeTheme.dart';
import 'package:zekr/controller/constant.dart';
import 'package:zekr/controller/settings_controller.dart';
import 'package:zekr/locale/locale_controller.dart';
import 'package:zekr/services/settings_services.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MyLocaleController myLocaleController = Get.find();
    SettingsController settingsController = Get.find();
    Themes themes = Get.find();

    return Scaffold(
      appBar: AppBar(title: Text("2".tr)),
      body: ListView(
        children: [

          Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListTile(
              title: Text("3".tr,style: Theme.of(context).textTheme.bodyMedium),
              subtitle: Text("4".tr,style: Theme.of(context).textTheme.labelMedium),
              trailing: const Icon(Icons.format_color_fill),
              onTap: (){
                themes.changeTheme();
              },
            ),
          ),

          GetX<SettingsController>(builder: (_) => SingleChildScrollView(
            child: Column(
              children: [
                ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) {
                    settingsController.isExpanded.value = !isExpanded;
                  },
                  children: [
                    ExpansionPanel(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      canTapOnHeader: true,
                      isExpanded: settingsController.isExpanded.value,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                          title: Text("5".tr,style: Theme.of(context).textTheme.bodyMedium),
                          subtitle: Text("6".tr,style: Theme.of(context).textTheme.labelMedium),
                          trailing: const Icon(Icons.language),
                        );
                      },
                      body: Column(
                        children: [
                          RadioListTile(
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text("7".tr,style: Theme.of(context).textTheme.bodyMedium),
                            value: 'ar',
                            groupValue: SettingsServices.sharedPreferences.getString("var"),
                            onChanged: (value) {
                              settingsController.lang.value = value!;
                              myLocaleController.changeLang("ar");
                              SettingsServices.sharedPreferences.setString("var",'ar');
                            },
                          ),
                          RadioListTile(
                            controlAffinity: ListTileControlAffinity.trailing,
                            title: Text("8".tr,style: Theme.of(context).textTheme.bodyMedium),
                            value: 'en',
                            groupValue: SettingsServices.sharedPreferences.getString("var"),
                            onChanged: (value) {
                              settingsController.lang.value = value!;
                              myLocaleController.changeLang("en");
                              SettingsServices.sharedPreferences.setString("var",'en');
                            },
                          ),
                        ],
                      )
                  )
                  ]
                ),
              ],
            ),
          )),

          const SizedBox(height: 20),

          Obx(() => Column(children: [

            const Text(':Arabic Font Size',style: TextStyle(fontWeight: FontWeight.bold),),
            Slider(
              value: arabicFontSize.value,
              min: 20,
              max: 40,
              onChanged: (value) {
                arabicFontSize.value = value;
              },
            ),

          
            Text(
              "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
              style: TextStyle(
                fontFamily: 'quran', fontSize: arabicFontSize.value
              ),
                textDirection: TextDirection.rtl,
            ),
            
            const Divider(height: 50,color: Colors.black),

            const Text(':Mushaf Mode Font Size',style: TextStyle(fontWeight: FontWeight.bold),),
            Slider(
              value: mushafFontSize.value,
              min: 20,
              max: 50,
              onChanged: (value) {
                mushafFontSize.value = value;
              },
            ),

            Text(
              "‏ ‏‏ ‏‏‏‏ ‏‏‏‏‏‏ ‏",
              style: TextStyle(
                fontFamily: 'quran', fontSize: mushafFontSize.value
              ),
                textDirection: TextDirection.rtl,
            ),

            const Divider(height: 50,color: Colors.black),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: () {
                    saveSettings();
                    Get.back();
                  }, child: const Text('Save'),
                ),
                MaterialButton(
                  onPressed: () {
                    arabicFontSize.value = 28;
                    mushafFontSize.value = 40;
                    saveSettings();
                  }, child: const Text('Reset'),
                ),
              ],
            )
          ],)),
        ],
      ),
    );
  }
}

                      // CheckboxListTile(
                      //   title: Text("7".tr,style: Theme.of(context).textTheme.bodyMedium),
                      //   secondary: const Icon(Icons.language),
                      //   value: SettingsServices.sharedPreferences.getBool("value1") ?? false,
                      //   onChanged: (val){
                      //       myLocaleController.changeLang("ar");
                      //       SettingsServices.sharedPreferences.setBool("value1",true);
                      //       SettingsServices.sharedPreferences.setBool("value2",false);
                      //   },
                      // ),
                    
                      // CheckboxListTile(
                      //   title: Text("8".tr,style: Theme.of(context).textTheme.bodyMedium),
                      //   secondary: const Icon(Icons.language),
                      //   value: SettingsServices.sharedPreferences.getBool("value2") ?? false,
                      //   onChanged: (val){
                      //     myLocaleController.changeLang("en");
                      //     SettingsServices.sharedPreferences.setBool("value2",true);
                      //     SettingsServices.sharedPreferences.setBool("value1",false);
                      //   },
                      // ),