import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../data/models/product.dart';

List<Map<String, dynamic>> daftarProducts = [
  {
    'id': 2,
    'name': 'Apple',
    'price': 55000,
    'stock': 33,
    'image': 'assets/images/apple.png',
  },
  {
    'id': 2,
    'name': 'Orange',
    'price': 35000,
    'stock': 20,
    'image': 'assets/images/jeruk.png',
  },
  {
    'id': 3,
    'name': 'Banana1',
    'price': 25000,
    'stock': 50,
    'image': 'assets/images/banana.jpg',
  },
];

//final forms = LzForm.make(['name']);
class ProductListNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  ProductListNotifier() : super(const AsyncValue.loading()) {
    getProduct();
  }

  List<Map<String, dynamic>> products = []; // List of Product objects

  void create(Product item) {
    state.whenData((data) {
      data.insert(0, item);
      state = AsyncValue.data(data);
    });
  }

  void search(String query) {
    state.whenData((data) {
      final filteredProducts = data.where((product) {
        return (product.name ?? '')
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            product.id.toString() == query;
      }).toList();
      state = AsyncValue.data(filteredProducts);
    });
  }

  Future getProduct() async {
    try {
      state = const AsyncValue.loading();

      // Convert daftarProducts to Product objects using fromJson()
      state = AsyncValue.data(
          daftarProducts.map((e) => Product.fromJson(e)).toList());
    } catch (e, s) {
      Errors.check(e, s);

      // Handle errors
    }
  }

  void update(int id, Product value) {
    try {
      state.whenData((data) {
        final index = data.indexWhere((e) => e.id == id);
        if (index > -1) {
          data[index] = value;
          state = AsyncValue.data(List<Product>.from(data));
        }
      });
    } catch (e, s) {
      Errors.check(e, s);
      LzToast.show('User has been Updating..');
      // Handle errors
    }
  }

  //  Future<void> update(int id, Product product) async {
  //   try {
  //     final form = LzForm.validate(forms, required: ['name'], notifierType: LzFormNotifier.text);

  //     if (form.ok) {
  //       LzToast.overlay('Updating...');
  //       await Future.delayed(1.s);

  //       state.whenData((data) {
  //         final productIndex = data.indexWhere((p) => p.id == id);

  //         if (productIndex != -1) {
  //           data[productIndex] = product;
  //           state = AsyncValue.data(List<Product>.from(data));
  //         }
  //       });

  //       LzToast.show('Produk telah diperbarui');
  //     }
  //   } catch (e, s) {
  //     Errors.check(e, s);
  //   } finally {
  //     LzToast.dismiss();
  //   }
  // }

  void deleteProduct(int index) {
    state.whenData((data) {
      daftarProducts.removeWhere((product) => product['id'] == index);
      state = AsyncValue.data(List<Product>.from(data));
    });

    LzToast.show('User has been deleted');
  }
}

final productProvider =
    StateNotifierProvider<ProductListNotifier, AsyncValue<List<Product>>>(
        (ref) => ProductListNotifier());
