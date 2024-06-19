import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/values/values.dart';

class UserDetails {
  final String userName;
  final String email;
  final String? imageUrl;

  UserDetails({
    required this.userName,
    required this.email,
    this.imageUrl,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      imageUrl: json['imageUrl'],
    );
  }
}

class CommentDto {
  final int id;
  final String text;

  CommentDto({
    required this.id,
    required this.text,
  });

  factory CommentDto.fromJson(Map<String, dynamic> json) {
    return CommentDto(
      id: json['id'],
      text: json['text'] ?? '',
    );
  }
}

class Post {
  final int id;
  final String text;
  final List<CommentDto> comments;

  Post({
    required this.id,
    required this.text,
    required this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    List<CommentDto> commentsList = [];

    if (json['comments'] != null) {
      commentsList = List<Map<String, dynamic>>.from(json['comments'])
          .map((commentJson) => CommentDto.fromJson(commentJson))
          .toList();
    }

    return Post(
      id: json['id'],
      text: json['text'],
      comments: commentsList,
    );
  }
}
// Existing imports...

class GroupTherapyPage extends StatefulWidget {
  @override
  _GroupTherapyPageState createState() => _GroupTherapyPageState();
}

class _GroupTherapyPageState extends State<GroupTherapyPage> {
  late Future<UserDetails> userDetails;
  late Future<void> postsFuture;
  final List<Post> _posts = [];
  final TextEditingController _postController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userDetails = fetchUserDetails();
    postsFuture = fetchPosts();
  }

  Future<UserDetails> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('https://tameit.azurewebsites.net/api/auth/userDetails'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return UserDetails.fromJson(responseData);
      } else {
        throw Exception('Failed to load user details.');
      }
    } catch (e) {
      throw Exception('Error fetching user details: $e');
    }
  }

  Future<void> fetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://tameit.azurewebsites.net/api/posts/getAllAcceptedPosts'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _posts.clear();
          for (var postJson in responseData) {
            _posts.add(Post.fromJson(postJson));
          }
        });
      } else {
        throw Exception('Failed to load posts.');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  Future<void> addPost(String postText) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.post(
        Uri.parse('https://tameit.azurewebsites.net/api/posts/sendPost'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'text': postText}),
      );

      if (response.statusCode == 200) {
        // Refresh posts after adding
        await fetchPosts();
      } else {
        throw Exception('Failed to add post.');
      }
    } catch (e) {
      throw Exception('Error adding post: $e');
    }
  }

  Future<void> addComment(int postId, String commentText) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.post(
        Uri.parse(
            'https://tameit.azurewebsites.net/api/comments/sendComment/$postId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'text': commentText}),
      );

      if (response.statusCode == 200) {
        // Refresh posts after adding comment
        await fetchPosts();
      } else {
        throw Exception('Failed to add comment.');
      }
    } catch (e) {
      throw Exception('Error adding comment: $e');
    }
  }

  void _showAddPostDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Post'),
          content: TextField(
            controller: _postController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Write your post here...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await addPost(_postController.text);
                  _postController.clear();
                } catch (e) {
                  print('Error adding post: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to add post.'),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showAddCommentDialog(int postIndex) {
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Comment'),
          content: TextField(
            controller: commentController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Write your comment here...',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await addComment(
                      _posts[postIndex].id, commentController.text);
                } catch (e) {
                  print('Error adding comment: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to add comment.'),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteShade3,
      appBar: AppBar(
        backgroundColor: AppColors.whiteShade3,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        title: const Text(
          'Group Therapists',
          style: TextStyle(
            color: AppColors.deepsea,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.deepsea,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Profile');
                  },
                  child: CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.deepsea,
                    child: FutureBuilder<UserDetails>(
                      future: userDetails,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return const Icon(Icons.error);
                        } else {
                          return CircleAvatar(
                            radius: 16,
                            backgroundImage: snapshot.data!.imageUrl != null
                                ? NetworkImage(snapshot.data!.imageUrl!)
                                : AssetImage('assets/images/newlogo.jpg')
                                    as ImageProvider,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.OrangePeel,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: _showAddPostDialog,
                ),
              ),
              SizedBox(width: 8.0),
              TextButton(
                onPressed: _showAddPostDialog,
                child: Text(
                  'Add Post',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: AppColors.OrangePeel,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await fetchPosts();
            },
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#' + post.id.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          post.text,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10.0),
                        const Divider(
                          color: AppColors.deepsea,
                          thickness: 0.1,
                          height: 9,
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => _showAddCommentDialog(index),
                              child: Row(
                                children: [
                                  Icon(Icons.message,
                                      color: AppColors.OrangePeel),
                                  SizedBox(width: 5.0),
                                  Text('Comment'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: post.comments.length,
                          itemBuilder: (context, commentIndex) {
                            final comment = post.comments[commentIndex];
                            return Column(
                              children: [
                                const Divider(
                                  color: AppColors.deepsea,
                                  thickness: 0.1,
                                  height: 9,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        '#' + comment.id.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                          comment.text,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}
