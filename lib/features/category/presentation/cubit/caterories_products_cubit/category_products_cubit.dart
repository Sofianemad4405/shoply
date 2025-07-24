import 'package:bloc/bloc.dart';
import 'package:shopify/features/category/data/category_service_impl.dart';
import 'package:shopify/core/models/product_model.dart';

part 'category_products_state.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  CategoryProductsCubit() : super(CategoryProductsInitial());

  String sortMethod = "SortBY";
  String order = "asc";

  Future<List<Product>> fetchCategoryProducts(
    String category,
    List<Product> categoryProducts,
  ) async {
    emit(CategoryProductsLoading());
    try {
      final categoryProducts =
          sortMethod == "SortBY"
              ? await CategoryServiceImpl().fetchCategoryProducts(category)
              : await CategoryServiceImpl().getCategoryProductsSorted(
                sortMethod,
                order,
                category,
              );
      emit(CategoryProductsLoaded(products: categoryProducts));
      return categoryProducts;
    } catch (e) {
      emit(CategoryProductsError(message: e.toString()));
      return [];
    }
  }
}
