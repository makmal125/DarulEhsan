import 'package:darulehsan/models/channel_model.dart';
import 'package:darulehsan/models/video_model.dart';
import 'package:darulehsan/services/youtube_api_service.dart';
import 'package:darulehsan/utilities/keys.dart';
import 'package:darulehsan/screens/youtube/video_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/timeago.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeHomeScreen extends StatefulWidget {
  const YoutubeHomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _YoutubeHomeScreenState createState() => _YoutubeHomeScreenState();
}

class _YoutubeHomeScreenState extends State<YoutubeHomeScreen> {
  late Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
    timeago.setLocaleMessages('ur', MyCustomMessages());
    //timeago.setLocaleMessages('ur', timeago.UrMessages());
  }

  _initChannel() async {
    Channel channel =
        await APIService.instance.fetchChannel(channelId: YOUTUBE_CHANNEL_ID);
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        height: 180.0,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(30, 30, 30, 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45.0,
              backgroundImage: NetworkImage(_channel.profilePictureUrl),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _channel.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w100,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${_channel.subscriberCount} سبسکرائبرز',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:12.0),
                    child: TextButton.icon(
                      onPressed: () => _launchURL(),
                      icon: const Icon(
                        FontAwesomeIcons.bell,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'سبسکرائب',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      style: const ButtonStyle(elevation:MaterialStatePropertyAll(5),backgroundColor:MaterialStatePropertyAll( Color.fromRGBO(248, 147, 0, 1))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildVideo(Video video) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => YoutubeVideoPlayer(id: video.id, title: video.title, description: video.description,),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          padding: const EdgeInsets.all(10.0),
          height: 140.0,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(30, 30, 30, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              Image(
                width: 150.0,
                image: NetworkImage(video.thumbnailUrl),
              ),
              const SizedBox(width: 10.0),
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width * 0.40,
                child: Column(
                  children: [
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          video.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(FontAwesomeIcons.clock, size: 12,color: Colors.white60,),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        Text(
                          video.publishedAtAgo,
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12.0,
                            
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos!..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }
  
  Future<void> _launchURL() async => await canLaunchUrl(YOUTUBE_SUBSCRIBE_URL)
      ? await launchUrl(YOUTUBE_SUBSCRIBE_URL)
      : throw 'Could not launch $YOUTUBE_SUBSCRIBE_URL';
  @override
  Widget build(BuildContext context) {
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('یوٹیوب چینل'),
          backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromRGBO(15, 15, 15, 1),
        // ignore: unnecessary_null_comparison
        body: _channel != null
            ? NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollDetails) {
                  if (!_isLoading &&
                      _channel.videos!.length != int.parse(_channel.videoCount) &&
                      scrollDetails.metrics.pixels ==
                          scrollDetails.metrics.maxScrollExtent) {
                    _loadMoreVideos();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: 1 + _channel.videos!.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return _buildProfileInfo();
                    }
                    Video video = _channel.videos![index - 1];
                    String d = timeago.format(DateTime.parse(video.publishedAt),
                        locale: 'ur');
                    video.publishedAtAgo = d;
                    return _buildVideo(video);
                  },
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor, // Red
                  ),
                ),
              ),
      ),
    );
  }
}
// my_custom_messages.dart
class MyCustomMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'پہلے';
  @override
  String suffixFromNow() => 'اب سے';
  @override
  String lessThanOneMinute(int seconds) => 'ایک لمحہ';
  @override
  String aboutAMinute(int minutes) => 'ایک منٹ';
  @override
  String minutes(int minutes) => '$minutes منٹ';
  @override
  String aboutAnHour(int minutes) => 'ایک گھنٹہ';
  @override
  String hours(int hours) => '$hours گھنٹے';
  @override
  String aDay(int hours) => 'ایک دن';
  @override
  String days(int days) => '$days دن';
  @override
  String aboutAMonth(int days) => 'ایک مہینہ';
  @override
  String months(int months) => '$months مہینہ';
  @override
  String aboutAYear(int year) => 'ایک سال';
  @override
  String years(int years) => '$years برس';
  @override
  String wordSeparator() => ' ';
}
