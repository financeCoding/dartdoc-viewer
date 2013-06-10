part of dartdoc_viewer;

/**
 *  Used to read a YAML file and generate a page. 
 *  
 *  Recursively goes through the YAML file to 
 *  find all the pages, categories and items. 
 */

Future getHttp() {
  String path = "../yaml/largeTest.yaml";
  return HttpRequest.getString(path);
}

Page loadData(response) {
  var doc = loadYaml(response);
  print(doc);
  for (String k in doc.keys) {
    print(k);
    print(doc[k]);
    
    page = generatePage(k, doc[k]);
    return page;
  }
}

/**
 *  Returns a page with a list of categories from a map of category. 
 */
Page generatePage(String name, Map<String, String> pageMap) {
  
  List<Category> categories = new List<Category>();
  for (String k in pageMap.keys) {
    print(k);
    print(pageMap[k]);
    
    Category category;
    // To check whether there is another map contained inside. 
    // If there is another map, it is necessary to generate a list of items. 
    if (pageMap[k].toString().contains(": {")) {
      category = generateCategory(k, pageMap[k]);
    } else {
      category = new Category(k);
    }
    categories.add(category);
  }
  Page page = new Page.withCategories(name, categories);
  return page;
}

/**
 *  Returns a category with a list of items from a map of items. 
 */
Category generateCategory(String name, Map<String, String> categoryMap) {
  
  List<CategoryItem> items = new List<CategoryItem>();
  for (String k in categoryMap.keys) {
    print(k);
    print(categoryMap[k]);
    
    CategoryItem item;
    // To check whether there is another map contained inside. 
    // If there is another map, it is necessary to generate another page. 
    if (categoryMap[k].toString().contains(": {")) {
      item = new CategoryItem.withPage(k, generatePage(k, categoryMap[k]));
    } else {
      item = new CategoryItem(k);
    }
    items.add(item);
  }
  Category category = new Category.withItems(name, items);
  return category;
}