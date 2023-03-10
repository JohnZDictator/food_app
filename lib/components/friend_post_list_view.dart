import 'package:flutter/material.dart';
import 'package:fooderlich/components/components.dart';
import '../models/models.dart';

class FriendPostListView extends StatelessWidget {
  const FriendPostListView({super.key, required this.friendPosts});

  final List<Post> friendPosts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Chefs',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 16),
          ListView.separated(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: friendPosts.length,
            itemBuilder: (context, index) {
              return FriendPostTile(post: friendPosts[index]);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
