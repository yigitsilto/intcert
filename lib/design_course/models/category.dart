class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
    this.name = "Yiğit Şilto",
    this.date = "22.02.2012"
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;
  String name;
  String date;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'images/logo.png',
      title: 'App Design Course',
      lessonCount: 24,
      money: 25,
      rating: 4.3,
      name: "Yiğit Şilto",
      date: "22.02.2018"
    ),
    
  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'App Design Course',
      lessonCount: 12,
      money: 25,
      rating: 4.8,
            name: "Yiğit Şilto"

    ),
   
  ];
}
