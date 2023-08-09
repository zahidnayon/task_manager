import 'package:flutter/material.dart';
import 'package:task_manager/data/models/authUtility.dart';
import 'package:task_manager/screens/onboard/loginScreen.dart';
import 'package:task_manager/screens/profile/updateProfileScreen.dart';

import '../../style/style.dart';

class userProfileBanner extends StatefulWidget {
  final bool? isUpdateScreen;
  const userProfileBanner({
    super.key, this.isUpdateScreen,
  });

  @override
  State<userProfileBanner> createState() => _userProfileBannerState();
}

class _userProfileBannerState extends State<userProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        if((widget.isUpdateScreen??false)==false) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => updateProfileScreen()));
        }
      },
      contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 16),
      tileColor: colorGreen,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            authUtility.userInfo.data?.photo?? '',
        ),
        onBackgroundImageError: (_,__){
          Icon(Icons.image);
        },

      ),
      title: Text('${authUtility.userInfo.data?.firstName ??
          ''} ${authUtility.userInfo.data?.lastName}',),
      subtitle: Text(authUtility.userInfo.data?.email??'unknown'),
      trailing: IconButton(
        onPressed: () async {
         await authUtility.clearUserInfo();
         if (mounted) {
           Navigator.pushAndRemoveUntil(
               context,
               MaterialPageRoute(builder: (context) => loginScreen()), (
               route) => false);
         }
        },
        icon: Icon(Icons.logout),
      ),
    );
  }
}