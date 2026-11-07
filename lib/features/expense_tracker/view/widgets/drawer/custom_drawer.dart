import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/static_assets.dart';
import '../../../../../core/theme/app_gradients.dart';
import '../../../../../shared/view/widgets/global_widgets.dart';
import '../../../../../shared/view/widgets/reusable_circular_image.dart';
import '../../../data/drawer_contents.dart';
import 'drawer_tile.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({required this.w, super.key});

  final double w;


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      width: w,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Color.fromARGB(255, 184, 241, 240)],
        ),
      ),
      child: Column(
        children: [
          Container(
              width: w,
              height: 240,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    // bottomRight: Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: AppGradients.skyBlueMyAppGradient),
              ),
              // padding: const EdgeInsets.,
              child: Column(
                children: [
                  spacerH(30),
                  const Center(
                    child: ReusableCircularImage(width: 90,height: 90,image: StaticAssets.budgetFlowIcon,borderWidth: 1.5,borderColor: Colors.white),
                  ),
                  spacerH(10),
                  const Text(AppConstants.budgetFlow,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  ),
                ],
              )),
          spacerH(15),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemBuilder: (context,index){
              var value = drawerContentsList(context,ref)[index];
              return DrawerTile(
                onTap: value.onTap,
                icon: value.icon,
                title: value.title,
              );
            },itemCount: drawerContentsList(context,ref).length,),
          ),
        ],
      ),
    );
  }
}