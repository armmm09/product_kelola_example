import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kelola_product/kelola_produk/providers/product/product_provider.dart';
import 'package:kelola_product/kelola_produk/providers/product/search/search_provider.dart';
import 'package:lazyui/lazyui.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final opo = ref.read(productProvider.notifier);
    final sr = ref.read(searchProductProvider.notifier);
    return Scaffold(body: Consumer(builder: (context, ref, _) {
      final pro = ref.watch(productProvider);

      return pro.when(
        data: (pay) {
          if (pay.isEmpty) {
            return LzNoData(
                message: 'Opps! No data found', onTap: () => opo.getProduct());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LzTextField(
                  hint: 'Search.......',
                  onChange: (query) {
                    sr.searchProduct(query);
                  },
                ),
              ),
              Expanded(
                child: Refreshtor(
                  onRefresh: () async {
                    await opo.getProduct();
                  },
                  child: LzListView(
                    children: pay.generate(
                      (item, i) {
                        return ListTile(
                          title: Text(item.name ?? ''),
                          subtitle: Text(
                              'Harga: ${item.price}, Stock: ${item.stock}'),
                          leading: Image.asset(item.image ?? ''),
                          trailing: Icon(Ti.dotsVertical),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => LzLoader.bar(message: 'Loading...'),
        error: (error, _) => LzNoData(message: 'Opps! $error'),
      );
    }));
  }
}
