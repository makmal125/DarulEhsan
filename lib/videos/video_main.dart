import 'package:darulehsan/models/channel_model.dart';
import 'package:darulehsan/models/video_model.dart';
import 'package:darulehsan/services/youtube_api_service.dart';
import 'package:darulehsan/utilities/keys.dart';
import 'package:darulehsan/videos/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
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
  }

  _initChannel() async {
    Channel channel =
        await APIService.instance.fetchChannel(channelId: YOUTUBE_CHANNEL_ID);
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      height: 150.0,
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
            radius: 35.0,
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
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel.subscriberCount} subscribers',
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 16.0,
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
                      'Subscribe',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
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
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id, title: video.title, description: video.description,),
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
                      ),
                    ),
                  ),
                  Text(
                    video.publishedAtAgo,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('YouTube Channel'),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
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
                      locale: 'en');
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
    );
  }
}
