import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService{

  void initializedNotification(){
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications(),
      }
    });
  }
  void sendNotificationMorningBefore(String title,String meassage,DateTime dateTime){
    DateTime modifiedTime = dateTime.subtract(const Duration(minutes: 1));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
      id:1,
      channelKey: 'MediBox121',
      title: title,
      body: meassage,
    ),
      schedule: NotificationCalendar(     
        hour: modifiedTime.hour,
        minute: modifiedTime.minute,
        repeats: false,
        allowWhileIdle: true,
      ),
    );
  }
  void sendNotificationMorningAfter(String title,String meassage,DateTime dateTime){
    DateTime modifiedTime = dateTime.subtract(const Duration(minutes: 1));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
      id: 2,
      channelKey: 'MediBox121',
      title: title,
      body: meassage,
    ),
      schedule: NotificationCalendar(     
        hour: modifiedTime.hour,
        minute: modifiedTime.minute,
        repeats: false,
        allowWhileIdle: true,
      ),
    );
  }
  void sendNotificationAfternoonBefore(String title,String meassage,DateTime dateTime){
    DateTime modifiedTime = dateTime.subtract(const Duration(minutes: 1));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
      id: 3,
      channelKey: 'MediBox121',
      title: title,
      body: meassage,
    ),
      schedule: NotificationCalendar(     
        hour: modifiedTime.hour,
        minute: modifiedTime.minute,
        repeats: false,
        allowWhileIdle: true,
      ),
    );
  }
  void sendNotificationAfternoonAfter(String title,String meassage,DateTime dateTime){
    DateTime modifiedTime = dateTime.subtract(const Duration(minutes: 1));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
      id: 4,
      channelKey: 'MediBox121',
      title: title,
      body: meassage,
    ),
      schedule: NotificationCalendar(     
        hour: modifiedTime.hour,
        minute: modifiedTime.minute,
        repeats: false,
        allowWhileIdle: true,
      ),
    );
  }
   void sendNotificationNightBefore(String title,String meassage,DateTime dateTime){
    DateTime modifiedTime = dateTime.subtract(const Duration(minutes: 1));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
      id: 5,
      channelKey: 'MediBox121',
      title: title,
      body: meassage,
    ),
      schedule: NotificationCalendar(     
        hour: modifiedTime.hour,
        minute: modifiedTime.minute,
        repeats: false,
        allowWhileIdle: true,
      ),
    );
  }
   void sendNotificationNightAfter(String title,String meassage,DateTime dateTime){
    DateTime modifiedTime = dateTime.subtract(const Duration(minutes: 1));
    AwesomeNotifications().createNotification(
      content: NotificationContent(
      id: 6,
      channelKey: 'MediBox121',
      title: title,
      body: meassage,
    ),
      schedule: NotificationCalendar(     
        hour: modifiedTime.hour,
        minute: modifiedTime.minute,
        repeats: false,
        allowWhileIdle: true,
      ),
    );
  }
}