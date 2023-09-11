
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kelola_product/kelola_produk/providers/product/product_provider.dart';
import 'package:lazyui/lazyui.dart';

import '../../../data/models/product.dart';

class SearchProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final AutoDisposeStateNotifierProviderRef ref;
  SearchProductNotifier(this.ref) : super(const AsyncValue.data([]));
  
  Future searchProduct (String keyword) async{

    try {
      final productNotifier = ref.read(productProvider.notifier);
      state = const AsyncValue.loading();

      // animasi loading 1second
      await Future.delayed(1.s);

      productNotifier.state.whenData((value){
        List<Product> products =value.where((element) => element.name!.toLowerCase().contains(keyword.toLowerCase())).toList();
        state = AsyncValue.data(products);
      });
    } catch (e,s) {
      Errors.check(e, s);

      
    }
  }
}

final searchProductProvider = StateNotifierProvider.autoDispose<SearchProductNotifier,AsyncValue<List<Product>>>((ref){
  return SearchProductNotifier(ref);
});
