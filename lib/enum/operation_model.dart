class OperationModel {
  String name;
  String selectedIcon;
  String unselectedIcon;

  OperationModel(
    this.name,
    this.selectedIcon,
    this.unselectedIcon,
  );
}

List<OperationModel> datas = operationsData
    .map((item) => OperationModel(
        item['name'], item['selectedIcon'], item['unselectedIcon']))
    .toList();

var operationsData = [
  {
    "name": "Medical\nAbreviation",
    "selectedIcon": "assets/svg/money_transfer_white.png",
    "unselectedIcon": "assets/svg/money_transfer_blue.png"
  },
  {
    "name": "BMI\nCalculator",
    "selectedIcon": "assets/svg/bank_withdraw_white.png",
    "unselectedIcon": "assets/svg/bank_withdraw_blue.png"
  },
  {
    "name": "Component\nTask",
    "selectedIcon": "assets/svg/insight_tracking_white.png",
    "unselectedIcon": "assets/svg/insight_tracking_blue.png"
  },
  {
    "name": "Covid\nUpdate",
    "selectedIcon": "assets/svg/insight_tracking_white.png",
    "unselectedIcon": "assets/svg/insight_tracking_blue.png"
  },
  {
    "name": "Note\nBook",
    "selectedIcon": "assets/svg/insight_tracking_white.png",
    "unselectedIcon": "assets/svg/insight_tracking_blue.png"
  },
   
 
];
