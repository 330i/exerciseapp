class OpponentListData {
  OpponentListData({
    //this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.mileTime = 0,
    this.pushups = 0,
    this.crunches = 0,
    this.score = 0,
  });

  //String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  int score;
  int mileTime;
  int pushups;
  int crunches;

  static List<OpponentListData> tabIconsList = <OpponentListData>[
    OpponentListData(
      // add profile pic imagePath: ,
      titleTxt: 'Michael Mohn',
      score: 520,
      mileTime: 480,
      pushups: 20,
      crunches: 30,
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    OpponentListData(
      titleTxt: 'Ian Kim',
      score: 520,
      mileTime: 480,
      pushups: 20,
      crunches: 30,
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    OpponentListData(
      titleTxt: 'Kevin Liu',
      score: 520,
      mileTime: 480,
      pushups: 20,
      crunches: 30,
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    OpponentListData(
      titleTxt: 'Timothy Wong',
      score: 520,
      mileTime: 480,
      pushups: 20,
      crunches: 30,
      startColor: '#FA7D82',
      endColor: '#FFB295',
    )
  ];
}