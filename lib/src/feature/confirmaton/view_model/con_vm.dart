import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

AutoDisposeChangeNotifierProvider<ConVM> conVM =
    ChangeNotifierProvider.autoDispose<ConVM>((ChangeNotifierProviderRef<ConVM> ref) => ConVM());

class ConVM with ChangeNotifier {

}
