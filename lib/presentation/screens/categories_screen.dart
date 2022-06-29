import 'package:expense_control_app/business_logic/cubits/category_cubit/category_cubit.dart';
import 'package:expense_control_app/business_logic/cubits/filter_date_time_cubit/filter_date_time_cubit.dart';
import 'package:expense_control_app/presentation/widgets/shared_widgets/total_sum_widget.dart';
import 'package:expense_control_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/model/category.dart';
import '../../main.dart';
import '../widgets/category_widgets/categories_list.dart';
import '../widgets/category_widgets/create_new_category_widget.dart';
import '../widgets/date_filter_categories_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FilterDateTimeCubit>().getFilterDateTime();
    context.read<CategoryCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Control',
            style: GoogleFonts.faustina(
                textStyle: Theme.of(context).textTheme.headline5!)),
        actions: [
          IconButton(
              icon: Icon(
                  ExpenseControlApp.themeNotifier.value == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode),
              onPressed: () {
                ExpenseControlApp.themeNotifier.value =
                    ExpenseControlApp.themeNotifier.value == ThemeMode.light
                        ? ThemeMode.dark
                        : ThemeMode.light;
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Category>(
              context: context,
              builder: (context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          CreateNewCategoryWidget(category: Category(name: '')),
                    ),
                  ));

          if (result != null) {
            context.read<CategoryCubit>().addCategory(result);
            context.read<CategoryCubit>().getCategories();
          }
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Text(
                'Categories',
                style: GoogleFonts.caveat(
                    textStyle: Theme.of(context).textTheme.headline4!),
              ),
            ),
          ),
          DateFilterCategoriesWidget(),
          Expanded(
            child: CategoriesList(),
          ),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoaded) {
                return Container(
                  margin: kTotalSumMargin,
                  child: TotalSumWidget(
                    totalSum: state.totalSum,
                  ),
                );
              } else if (state is CategoryLoading) {
                return Container();
              } else {
                return const Text('Error in total sum (custom)');
              }
            },
          ),
        ],
      ),
    );
  }
}
