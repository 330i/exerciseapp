class OpponentListData {
  OpponentListData({
    //this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.stats,
    this.score = 0,
  });

  //String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> stats;
  int score;

  static List<OpponentListData> tabIconsList = <OpponentListData>[
    OpponentListData(
      // add profile pic imagePath: ,
      titleTxt: 'Michael Mohn',
      score: 520,
      stats: <String>["8:30", "22" , "34"],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    OpponentListData(
      titleTxt: 'Ian Kim',
      score: 520,
      stats: <String>["8:30", "22" , "34"],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    OpponentListData(
      titleTxt: 'Timothy Wang',
      score: 520,
      stats: <String>["8:30", "22" , "34"],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    OpponentListData(
      titleTxt: 'Kevin Liu',
      score: 520,
      stats: <String>["8:30", "22" , "34"],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    )
  ];
}