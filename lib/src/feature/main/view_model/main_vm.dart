import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../../../common/routes/app_route_name.dart";


AutoDisposeChangeNotifierProvider<MainVM> mainVM = ChangeNotifierProvider.autoDispose<MainVM>((ChangeNotifierProviderRef<MainVM> ref) => MainVM());

class MainVM with ChangeNotifier {
  int currentIndex = 0;

  void changeIndex(int index, BuildContext context) {
    currentIndex = index;
    if (index == 0) {
      context.go(AppRouteName.homePage);
    }else{
      context.go(AppRouteName.homePage);
    }
  }
}
