import 'package:sudan_horizon_scanner/imports.dart';

class EmergenceIssueOfTheMonthCardTileWS extends StatelessWidget
{
  final String? emergingIssueName;
  final double? repetition;
  final String? time;
  final String? sdgTargeted;

  const EmergenceIssueOfTheMonthCardTileWS(
  {   Key? key,
      this.emergingIssueName,
      this.repetition,
      this.time,
    this.sdgTargeted,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    final screenSize = MediaQuery.of(context).size;
    return FittedBox(
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EmergenceIssueOfTheMonthScreenDetailScreenWS(
                emergingIssueName: emergingIssueName!,
              ),
            ),
          );
        },
        child: SizedBox(
          height: screenSize.height / 6,
          width: screenSize.width / 5.5,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Material(
                elevation: 10,
                color: Colors.white,
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  height: screenSize.height / 6.5,
                  width: screenSize.width / 5.5,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        emergingIssueName == null ? "" : emergingIssueName!,
                        style: cardTileTitleText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      FittedBox(
                        child: Text(
                          repetition == null ? "" : "${repetition!}%",
                          style: cardTileMainText,
                        ),
                      ),
                      const Spacer(),
                      const Divider(),
                      Align(
                          alignment: Alignment.topLeft,
                          child: FittedBox(
                            child: Text(
                           time == null ? "" : time!,
                              style: cardTileSubText,
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 20,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: screenSize.height / 18,
                  width: screenSize.width / 36,
                  child: sdgTargeted == "" ? Container(): Image.asset(
                   sdgTargeted == sdgGoalsList![0] ? sdgGoalsIconList![0] :
                   sdgTargeted == sdgGoalsList![1] ? sdgGoalsIconList![1] :
                   sdgTargeted == sdgGoalsList![2] ? sdgGoalsIconList![2] :
                   sdgTargeted == sdgGoalsList![3] ? sdgGoalsIconList![3] :
                   sdgTargeted == sdgGoalsList![4] ? sdgGoalsIconList![4] :
                   sdgTargeted == sdgGoalsList![5] ? sdgGoalsIconList![5] :
                   sdgTargeted == sdgGoalsList![6] ? sdgGoalsIconList![6] :
                   sdgTargeted == sdgGoalsList![7] ? sdgGoalsIconList![7] :
                   sdgTargeted == sdgGoalsList![8] ? sdgGoalsIconList![8] :
                   sdgTargeted == sdgGoalsList![9] ? sdgGoalsIconList![9] :
                   sdgTargeted == sdgGoalsList![10] ? sdgGoalsIconList![10] :
                   sdgTargeted == sdgGoalsList![11] ? sdgGoalsIconList![11] :
                   sdgTargeted == sdgGoalsList![12] ? sdgGoalsIconList![12] :
                   sdgTargeted == sdgGoalsList![13] ? sdgGoalsIconList![13] :
                   sdgTargeted == sdgGoalsList![14] ? sdgGoalsIconList![14] :
                   sdgTargeted == sdgGoalsList![15] ? sdgGoalsIconList![15] :
                    sdgGoalsIconList![0],
                      fit: BoxFit.contain,
                  ),
                  /*Icon(
                    icon,
                    size: 35,
                    color: Colors.white,
                  ),*/
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}