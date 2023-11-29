// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MyWidget extends StatefulWidget {
//   const MyWidget({super.key});

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   void initState() {
//     AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
//       if(!isAllowed){
//         AwesomeNotifications().requestPermissionToSendNotifications(),
//       }
//     });
//     super.initState();
//   }

//   void sendNotification(){
//     AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 10, 
//         channelKey: 'MediBox121',
//         title: 'Hello',
//         body: 'Its go to then',
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.maxFinite.h,
//         width: double.maxFinite.w,
//         child: Center(
//           child: ElevatedButton(
//             onPressed: (){
//               sendNotification();
//             }, 
//             child: Text('Send'),
//           ),
//         ),
//       ),
//     );
//   }
// }