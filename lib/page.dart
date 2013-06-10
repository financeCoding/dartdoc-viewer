library page;

import 'package:web_ui/web_ui.dart';
import 'package:dartdoc_viewer/category.dart';

/**
 * A page object represents a single page in the documentation. 
 * 
 * Page objects will have a list of categories. 
 */
@observable 
class Page {
  String name;
  final List<Category> categories = toObservable([]);
  
  Page(this.name);
  
  Page.withCategories(this.name, List<Category> newCategories) {
    categories.addAll(newCategories);
  }
}