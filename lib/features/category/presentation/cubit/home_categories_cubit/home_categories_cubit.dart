// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:shopify/features/category/data/repo/category_repo_impl.dart';

// part 'home_categories_state.dart';

// class HomeCategoriesCubit extends Cubit<HomeCategoriesState> {
//   HomeCategoriesCubit() : super(HomeCategoriesInitial());

//   List<String> categories = [];

//   Future<void> init() async {
//     emit(HomeCategoriesLoading());
//     categories = await getCategories();
//     emit(CategoriesLoaded(categories: categories));
//   }

//   Future<List<String>> getCategories() async {
//     emit(HomeCategoriesLoading());
//     try {
//       final categories = await CategoryServiceImpl().getCategories();
//       log(categories.length.toString());
//       emit(CategoriesLoaded(categories: categories));
//       return categories;
//     } catch (e) {
//       emit(CategoriesError(message: e.toString()));
//       return [];
//     }
//   }
// }
