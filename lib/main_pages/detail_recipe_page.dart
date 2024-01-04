/*import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_recipes_app/utility/constant.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';*/
import 'package:food_recipes_app/index.dart';

class DetailRecipePage extends StatefulWidget {
  final int index;
  final String? name, image, recipe, youtubeLink, price;
  final bool tag;

  DetailRecipePage(this.index, this.name, this.image, this.recipe,
      this.youtubeLink, this.price, this.tag);

  @override
  State<DetailRecipePage> createState() => _DetailRecipePageState();
}

class _DetailRecipePageState extends State<DetailRecipePage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    var url = '';
    if (widget.youtubeLink == '') {
       url = 'https://www.youtube.com/watch';
    } else {
      url = widget.youtubeLink!;

    }
    final videoID = YoutubePlayer.convertUrlToId(url);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/org_bck.jpg'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //backgroundColor: kLightColor,
        bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
                color: kOrangeColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.0),
                    topRight: Radius.circular(28.0))),
            height: 55,
            child: Center(
              child: Text(
                'Back',
                style: TextStyle(
                  fontFamily: 'MulishBold',
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 70.0, left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.0),
                    decoration: BoxDecoration(
                        color: kOrangeColor,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.star,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.name!,
                  style: TextStyle(
                    fontSize: 36.0,
                    fontFamily: 'MulishBold',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.currency_rupee, color: kOrangeColor, size: 36),
                    Text(
                      widget.price!,
                      style: TextStyle(
                          fontFamily: 'MulishBold',
                          fontSize: 36.0,
                          color: kOrangeColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 36.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 36.0,
                            ),
                            Text(
                              'Calories',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'MulishBold',
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              '120 Calories',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'MulishBold',
                              ),
                            ),
                            SizedBox(
                              height: 36.0,
                            ),
                            Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'MulishBold',
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              '10 mins',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'MulishBold',
                              ),
                            ),
                            SizedBox(
                              height: 36.0,
                            ),
                            Text(
                              'Total Serve',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'MulishBold',
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              '1 Serving',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'MulishBold',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Hero(
                        tag: widget.tag
                            ? 'fresh${widget.index}'
                            : 'recommen${widget.index}',
                        child: Image.asset(
                          widget.image!,
                          height: 250.0,
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 36.0,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontFamily: 'MulishBold',
                        color: kOrangeColor),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YoutubePlayer(
                                      controller: _controller,
                                      showVideoProgressIndicator: true,
                                      onReady: () => debugPrint('Ready'),
                                      bottomActions: [
                                        CurrentPosition(),
                                        ProgressBar(
                                          isExpanded: true,
                                          colors: ProgressBarColors(
                                            playedColor: kOrangeColor,
                                            handleColor: kBlueColor,
                                          ),
                                        ),
                                        PlaybackSpeedButton(),
                                        FullScreenButton(),
                                        CloseButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          color: kOrangeColor,
                                        ),
                                      ],
                                    )));
                      },
                      child: SvgPicture.asset(
                        'assets/icons/youtube1.svg',
                        height: 50.0,
                      ),
                    ),
                  ),
                ]),
                Container(
                  margin: EdgeInsets.only(right: 24.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ReadMoreText(
                      widget.recipe!,
                      style: TextStyle(
                        fontFamily: 'MulishBold',
                        fontSize: 18.0,
                        color: Colors.black54,
                      ),
                      trimLines: 3,
                      textAlign: TextAlign.justify,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: " Show More",
                      trimExpandedText: " Show Less",
                      lessStyle: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'MulishBold',
                        color: kOrangeColor,
                      ),
                      moreStyle: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'MulishBold',
                        color: kOrangeColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
