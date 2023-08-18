import 'package:flutter/material.dart';
import 'package:newsline/helper/category_data.dart';
import 'package:newsline/helper/news_data.dart';
import 'package:newsline/model/news_model.dart';
import 'package:newsline/views/category_page.dart';
import '../model/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

// import 'package:newsline/model/category_model.dart';
// import 'package:newsline/helper/category_data.dart'; // Import the category_data.dart file

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Get category list

  //List<CategoryModel> categories = List<CategoryModel>();
  List<CategoryModel> categories = [];

  //Get list for news
  List<ArticleModel> articles = [];

  getArticle() async {
    News newsdata = News();
    await newsdata.getArticle();
    articles = newsdata.datatobesaved;
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // child: Text('Home page'),
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Flutter ',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'News',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ],
          )),

      //category widgets
      body: Container(
          color: Color.fromARGB(255, 215, 243, 243),
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection:
                      Axis.horizontal, // Set the scroll direction to horizontal
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: articles.length,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return NewsWidget(
                        title: articles[index].title,
                        description: articles[index].description,
                        url: articles[index].url,
                        urlToImage: articles[index].urlToImage,
                        //urlToImage: articles[index].urlToImage,
                      );
                    }),
              )
            ],
          )),
    );
  }
}

// Template display
class CategoryTile extends StatelessWidget {
  //String categoryName, imageUrl;
  final String categoryName;
  final String imageUrl;

  CategoryTile({required this.categoryName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {Navigator.push(context, MaterialPageRoute(
        builder: (context) => CategoryFragment(
          category: categoryName.toLowerCase(),
        ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          // alignment: Alignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                  imageUrl: imageUrl, width: 170, height: 90, fit: BoxFit.cover),
            ),
            Container(
              // color: Colors.black.withOpacity(0.6),
              // padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              width: 170,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// News template

class NewsWidget extends StatelessWidget {

  String title, description, url, urlToImage;
  NewsWidget({
  required this.title, 
  required this.description, 
  required this.url, 
  required this.urlToImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: urlToImage, 
                width: 380, 
                height: 200, 
                fit: BoxFit.cover,)),
          SizedBox(height: 8),
          Text(title, style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18.0, 
            color: Colors.black),),
          SizedBox(height: 8),
          Text(description, style: TextStyle(
            fontSize: 15.0, 
            color: Colors.grey[800]),),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:newsline/helper/category_data.dart';
// import 'package:newsline/helper/news_data.dart';
// import 'package:newsline/model/news_model.dart';
// import '../model/category_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class HomePage extends StatefulWidget {
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<CategoryModel> categories = [];
//   List<ArticleModel> articles = [];

//   @override
//   void initState() {
//     super.initState();
//     categories = getCategories();
//     getArticle();
//   }

//   void getArticle() async {
//     News newsdata = News();
//     await newsdata.getArticle();
//     setState(() {
//       articles = newsdata.datatobesaved;
//     });
//   }

//   void getArticlesForCategory(String categoryName) async {
//     NewsCategory newsCategory = NewsCategory();
//     await newsCategory.getArticle(categoryName);
//     setState(() {
//       articles = newsCategory.datatobesaved;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Flutter ',
//               style: TextStyle(color: Colors.black),
//             ),
//             Text(
//               'News',
//               style: TextStyle(color: Colors.blueAccent),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         color: Color.fromARGB(255, 215, 243, 243),
//         child: Column(
//           children: <Widget>[
//             Container(
//               height: 80,
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: ListView.builder(
//                 itemCount: categories.length,
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       getArticlesForCategory(categories[index].categoryName);
//                     },
//                     child: CategoryTile(
//                       imageUrl: categories[index].imageUrl,
//                       categoryName: categories[index].categoryName,
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: articles.length,
//                 physics: ClampingScrollPhysics(),
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return NewsWidget(
//                     title: articles[index].title,
//                     description: articles[index].description,
//                     url: articles[index].url,
//                     urlToImage: articles[index].urlToImage,
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CategoryTile extends StatelessWidget {
//   final String categoryName;
//   final String imageUrl;

//   CategoryTile({required this.categoryName, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(right: 16),
//       child: Stack(
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: CachedNetworkImage(
//                 imageUrl: imageUrl, width: 170, height: 90, fit: BoxFit.cover),
//           ),
//           Container(
//             alignment: Alignment.center,
//             width: 170,
//             height: 90,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               color: Colors.black26,
//             ),
//             child: Text(
//               categoryName,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class NewsWidget extends StatelessWidget {
//   String title, description, url, urlToImage;

//   NewsWidget({
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(16),
//       child: Column(
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: BorderRadius.circular(6),
//             child: CachedNetworkImage(
//               imageUrl: urlToImage,
//               width: 380,
//               height: 200,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18.0,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             description,
//             style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
//           ),
//         ],
//       ),
//     );
//   }
// }




