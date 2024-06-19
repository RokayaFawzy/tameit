import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tame_it/values/values.dart';

// Define CommentDto class
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
      text: json['text'],
    );
  }
}

// Define Post class
class Post {
  final int id; // Assuming Long is represented as int for simplicity
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
      commentsList = (json['comments'] as List)
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

class AdminPostsPage extends StatefulWidget {
  @override
  _AdminPostsPageState createState() => _AdminPostsPageState();
}

class _AdminPostsPageState extends State<AdminPostsPage> {
  late Future<UserDetails> userDetails;
  late Future<void> postsFuture;
  final List<Post> _posts = [];

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
            'https://tameit.azurewebsites.net/api/posts/getAllPendingPosts'),
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

  Future<void> deletePost(int postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.delete(
      Uri.parse(
          'https://tameit.azurewebsites.net/api/posts/deletePost/$postId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _posts.removeWhere((post) => post.id == postId);
      });
    } else {
      throw Exception('Failed to delete post.');
    }
  }

  Future<void> deleteComment(int commentId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.delete(
      Uri.parse(
          'https://tameit.azurewebsites.net/api/comments/deleteComment/$commentId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        for (var post in _posts) {
          post.comments.removeWhere((comment) => comment.id == commentId);
        }
      });
    } else {
      throw Exception('Failed to delete comment.');
    }
  }

  Future<void> acceptPost(int postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.post(
      Uri.parse(
          'https://tameit.azurewebsites.net/api/posts/acceptPost/$postId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _posts.removeWhere((post) => post.id == postId);
      });
    } else {
      throw Exception('Failed to accept post.');
    }
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
          'Admin Posts',
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
      body: Column(
        children: [
          Expanded(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '# ${post.id}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close,
                                  color: AppColors.OrangePeel),
                              onPressed: () => deletePost(post.id),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Text(post.text),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => acceptPost(post.id),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.green,
                                iconColor: Colors.white,
                              ),
                              child: Text('Accept'),
                            ),
                            SizedBox(width: 8.0),
                            ElevatedButton(
                              onPressed: () => deletePost(post.id),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red,
                              ),
                              child: Text('Reject'),
                            ),
                          ],
                        ),
                        const Divider(
                          color: AppColors.deepsea,
                          thickness: 0.1,
                          height: 9,
                        ),
                        // if (post.comments.isNotEmpty)
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            '# ${comment.id}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Text(comment.text),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close,
                                          color: AppColors.OrangePeel),
                                      onPressed: () =>
                                          deleteComment(comment.id),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: AppColors.deepsea,
                                  thickness: 0.1,
                                  height: 9,
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
        ],
      ),
    );
  }
}
