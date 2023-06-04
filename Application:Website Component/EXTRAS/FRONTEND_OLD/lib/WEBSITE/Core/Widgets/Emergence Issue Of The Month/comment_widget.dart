import 'package:sudan_horizon_scanner/imports.dart';

class CommentWidget extends StatelessWidget
{
  const CommentWidget(
  {
    Key? key,
    required Size media,
  })  : _media = media,
        super(key: key);

  final Size _media;

  @override
  Widget build(BuildContext context)
  {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(4),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        height: _media.height / 1.4,
        width: _media.width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Recent Comments',
              style: cardTitleTextStyle,
            ),
            const SizedBox(height: 10),
            const Text(
              'Latest Comments on users from Material',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: commentList.length,
                itemBuilder: (context, index)
                {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(commentList[index].image!),
                        radius: 30,
                      ),
                      title: Text(
                        commentList[index].name!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${commentList[index].comment}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Text(
                                  '${commentList[index].date}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 10),
                                const Icon(Icons.edit, size: 15, color: Colors.grey),
                                const SizedBox(width: 10),
                                const Icon(Icons.highlight_off,
                                    size: 15, color: Colors.grey),
                                const SizedBox(width: 10),
                                const Icon(Icons.favorite_border,
                                    size: 15, color: Colors.pink),
                              ],
                            ),
                          ],
                        ),
                      ),
                      isThreeLine: true,
                      trailing: Material(
                        color: commentList[index].color,
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          alignment: Alignment.center,
                          width: 60,
                          height: 20,
                          child: Text(
                            commentList[index].status!.index == 0
                                ? 'Pending'
                                : commentList[index].status!.index == 1
                                    ? 'Approved'
                                    : 'Rejected',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///------------------------------------------------- COMPONENTS -------------------------------------------------///

enum Status { Pending, Approved, Rejected }

class Comment
{
  String? name;
  String? comment;
  Status? status;
  String? image;
  Color? color;
  String? date;

  Comment(
      {this.name,
        this.comment,
        this.status,
        this.image,
        this.color,
        this.date});
}

List<Comment> commentList = [
  Comment(
    name: 'Atharva Kulkarni',
    status: Status.Pending,
    image: 'assets/images/1.jpg',
    color: Colors.blue,
    date: 'May 19, 2019',
    comment:
    'Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has beenorem Ipsum is simply dummy text of the printing and type setting ',
  ),
  Comment(
    name: 'Adwait Gondhalekar',
    status: Status.Approved,
    image: 'assets/images/2.jpg',
    date: 'May 19, 2019',
    color: Colors.green,
    comment:
    'Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has beenorem Ipsum is simply dummy text of the printing and type setting ',
  ),
  Comment(
    name: 'Bill Gates',
    status: Status.Rejected,
    color: Colors.red,
    image: 'assets/images/3.jpg',
    date: 'May 19, 2019',
    comment:
    'Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has beenorem Ipsum is simply dummy text of the printing and type setting ',
  ),
  Comment(
    name: 'Mark Zuckerberg',
    status: Status.Pending,
    image: 'assets/images/4.jpg',
    color: Colors.blue,
    date: 'May 19, 2019',
    comment:
    'Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has beenorem Ipsum is simply dummy text of the printing and type setting ',
  ),
];