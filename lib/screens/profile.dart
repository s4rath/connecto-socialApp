import 'package:flutter/material.dart';
import '../models/highlight.dart';
import '../models/post.dart';
import '../models/profile.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;




class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Profile profile = Profile(
    username: 'jojodadaly',
    fullName: 'Joan Dadaly',
    bio: 'Big Dreamer and Work Hard',
    profileImage: 'assets/images/profile.jpg',
    posts: 5,
    followers: 1892,
    following: 631,
  );

  final List<Highlight> highlights = [
    Highlight(title: 'New', image: 'assets/images/newyork.jpg'),
    Highlight(title: 'Korea', image: 'assets/images/korea.jpg'),
    Highlight(title: 'Japan', image: 'assets/images/japan.jpg'),
    Highlight(title: 'USA', image: 'assets/images/usa.jpg'),
  ];

  final List<Post> posts = List.generate(5, (index) => Post(
    image: 'assets/images/post${index + 1}.jpg',
    description: 'Look at that color 😍\nI never knew cherries could be so vibrant!',
    timeAgo: '1 hour ago',
    likes: 2000,
    comments: 202,
    shares: 300,
  ));

  Uint8List? profileImageBytes;
  List<Uint8List> highlightImageBytes = [];
  List<Uint8List> postImageBytes = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Future<void> loadImages() async {
    final profileImageBytes = await loadAssetAsBytes(profile.profileImage);
    final highlightImageBytes = await Future.wait(highlights.map((highlight) => loadAssetAsBytes(highlight.image)).toList());
    final postImageBytes = await Future.wait(posts.map((post) => loadAssetAsBytes(post.image)).toList());

    setState(() {
      this.profileImageBytes = profileImageBytes;
      this.highlightImageBytes = highlightImageBytes;
      this.postImageBytes = postImageBytes;
    });
  }

  Future<Uint8List> loadAssetAsBytes(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: profileImageBytes == null || highlightImageBytes.isEmpty || postImageBytes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 40), // Space for the status bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {},
                      ),
                      Text(
                        profile.username,
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.menu, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: MemoryImage(profileImageBytes!),
                  ),
                  SizedBox(height: 10),
                  Text(
                    profile.fullName,
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    profile.bio,
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('${profile.posts}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text('Posts', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('${profile.followers}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text('Followers', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('${profile.following}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text('Following', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Edit Profile'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800],foregroundColor: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Share Profile'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800],foregroundColor: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: highlights.asMap().entries.map((entry) {
                        int index = entry.key;
                        Highlight highlight = entry.value;
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HighlightViewer(highlight: highlight, imageBytes: highlightImageBytes[index])),
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: MemoryImage(highlightImageBytes[index]),
                                radius: 30,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(highlight.title, style: TextStyle(color: Colors.white)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: posts.asMap().entries.map((entry) {
                      int index = entry.key;
                      Post post = entry.value;
                      return PostCard(post: post, imageBytes: postImageBytes[index]);
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;
  final Uint8List imageBytes;

  PostCard({required this.post, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpg'), // replace with your local asset
              ),
              title: Text(
                'jojodadaly',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                post.timeAgo,
                style: TextStyle(color: Colors.grey),
              ),
              trailing: Icon(Icons.more_vert, color: Colors.white),
            ),
            if (post.image.isNotEmpty)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostViewer(posts: [post], initialIndex: 0, imageBytes: [imageBytes]),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: MemoryImage(imageBytes),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (post.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  post.description,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite_border, color: Colors.white),
                      SizedBox(width: 5),
                      Text('${post.likes}', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 20),
                      Icon(Icons.comment, color: Colors.white),
                      SizedBox(width: 5),
                      Text('${post.comments}', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 20),
                      Icon(Icons.repeat_sharp, color: Colors.white),
                      SizedBox(width: 5),
                      Text('${post.shares}', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Icon(Icons.bookmark_border, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HighlightViewer extends StatelessWidget {
  final Highlight highlight;
  final Uint8List imageBytes;

  HighlightViewer({required this.highlight, required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Image.memory(imageBytes),
      ),
    );
  }
}

class PostViewer extends StatefulWidget {
  final List<Post> posts;
  final int initialIndex;
  final List<Uint8List> imageBytes;

  PostViewer({required this.posts, required this.initialIndex, required this.imageBytes});

  @override
  _PostViewerState createState() => _PostViewerState();
}

class _PostViewerState extends State<PostViewer> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          return Center(
            child: Image.memory(widget.imageBytes[index]),
          );
        },
      ),
    );
  }
}
