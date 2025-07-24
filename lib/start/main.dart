import 'package:ders_app/core/app_bindings.dart';
import 'package:ders_app/modules/main_page/my_task_handler.dart';
import 'package:ders_app/modules/routes/app_pages.dart';
import 'package:ders_app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  // Foreground servis yapılandırması
  FlutterForegroundTask.init(
    androidNotificationOptions: AndroidNotificationOptions(
      channelId: 'foreground_service_channel',
      channelName: 'Foreground Service',
      channelDescription: 'Bu bildirim ders_app tarafından gösterilir',
      channelImportance: NotificationChannelImportance.LOW,
      priority: NotificationPriority.LOW,
      iconData: const NotificationIconData(
        resType: ResourceType.mipmap,
        resPrefix: ResourcePrefix.ic,
        name: 'launcher',
      ),
      isSticky: true,
      visibility: NotificationVisibility.VISIBILITY_PUBLIC,

      // İşte burada butonları ekliyoruz:
      buttons: [
        NotificationButton(id: 'pause_or_resume', text: 'Durdur/Başlat'),
        NotificationButton(id: 'reset', text: 'Bitir'),
      ],
    ),
    iosNotificationOptions: const IOSNotificationOptions(
      showNotification: true,
      playSound: false,
    ),
    foregroundTaskOptions: const ForegroundTaskOptions(
      interval: 1000,
      isOnceEvent: false,
      autoRunOnBoot: false,
      allowWakeLock: true,
      allowWifiLock: false,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr'), // Türkçe
        Locale('en'), // İngilizce
        // Diğer diller eklenebilir
      ],
      title: "Çalışma Süresi Takip Uygulaması",
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.INITIAL,
      getPages: AppPages.pages,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}
