import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:lazyui/lazyui.dart';
import '../../data/models/product.dart';
import '../../providers/product/product_provider.dart';
import '../../providers/product/search/search_provider.dart';

class ProductView extends ConsumerWidget {
  const ProductView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(productProvider.notifier);
    final sr = ref.read(searchProductProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text('List Product'),
          actions: [
            const Icon(Ti.plus).onPressed(
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FormProduct(notifier2: notifier)),
                );
              },
            ),
          ],
        ),
        body: Consumer(builder: (context, ref, _) {
          final pro = ref.watch(productProvider);

          return pro.when(
            data: (pay) {
              if (pay.isEmpty) {
                return LzNoData(
                    message: 'Opps! No data found',
                    onTap: () => notifier.getProduct());
              }

              return Column(
                
                children: [
                  // LzListView(
                  //   children: [
                  //     SearchView(),
                  //   ],
                  // ),
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
                        await notifier.getProduct();
                      },
                      child: LzListView(
                        children: pay.isNotEmpty
                        ? pay.generate(
                      (item, i) {
                        return ListTile(
                          title: Text(item.name ?? ''),
                          subtitle: Text(
                              'Harga: ${item.price}, Stock: ${item.stock}'),
                          leading: Image.asset(item.image ?? ''),
                          trailing: Icon(Ti.dotsVertical),
                        );
                      },
                    )
                        :pay.generate(
                          (item, i) {
                            final key = GlobalKey();
                            return ListTile(
                              title: Text(item.name ?? ''),
                              subtitle: Text(
                                  'Harga: ${item.price}, Stock: ${item.stock}'),
                              leading: Image.asset(item.image ?? ''),
                              key: key,
                              onTap: () {
                                DropX.show(key,
                                    options: ['Edit', 'Delete'].options(
                                        icons: [Ti.pencil, Ti.trash],
                                        dangers: [1]), onSelect: (value) {
                                  if (value.option == 'Edit') {
                                    context.push(FormProduct(
                                      notifier2: notifier,
                                      data: item,
                                    ));
                                  } else {
                                    LzConfirm(
                                        title: 'Hapus data',
                                        type: LzConfirmType.bottomSheet,
                                        message:
                                            'Anda yakin ingin menghapus data ini?',
                                        onConfirm: () => notifier.deleteProduct(
                                            item.id ?? 0)).show(context);
                                  }
                                });
                              },
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

class FormProduct extends StatelessWidget {
  final ProductListNotifier notifier2;
  final Product? data;

  const FormProduct({Key? key, required this.notifier2, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forms = GlobalKey<FormState>();

    final TextEditingController nameController =
        TextEditingController(text: data?.name);
    final TextEditingController priceController =
        TextEditingController(text: data?.price?.toString());
    final TextEditingController stockController =
        TextEditingController(text: data?.stock?.toString());
    final TextEditingController imageController =
        TextEditingController(text: data?.image);

    return Scaffold(
      appBar: AppBar(
        title: Text(data == null ? 'Tambah Produk' : 'Edit Produk'),
      ),
      body: Form(
        key: forms,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Nama Produk', hintText: '...............'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              controller: priceController,
              decoration:
                  InputDecoration(labelText: 'Price', hintText: '...........'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: stockController,
              decoration:
                  InputDecoration(labelText: 'Stock', hintText: '.........'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: imageController,
              decoration:
                  InputDecoration(labelText: 'Url', hintText: '..........'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          if (forms.currentState?.validate() ?? false) {
            if (data != null) {
              notifier2.update(
                  data!.id ?? 0,
                  Product(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: nameController.text,
                    price: int.tryParse(priceController.text) ?? 0,
                    stock: int.tryParse(stockController.text) ?? 0,
                    image: imageController.text,
                  ) as Product);
            } else {
              notifier2.create(Product(
                id: DateTime.now().millisecondsSinceEpoch,
                name: nameController.text,
                price: int.tryParse(priceController.text) ?? 0,
                stock: int.tryParse(stockController.text) ?? 0,
                image: imageController.text,
              ));
            }
            Navigator.pop(context);
          }
        },
        child: Text('Submit'),
      ),
    );
  }
}
