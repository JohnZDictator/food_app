import 'package:flutter/material.dart';

import '../components/components.dart';
import '../api/mock_fooderlich_service.dart';
import '../models/models.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final mockService = MockFooderlichService();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isTop) print('i am at the top!');
    if (_isBottom) print('i am at the bottom!');
  }

  bool get _isTop {
    if (!_scrollController.hasClients) return false;
    final initialScroll = _scrollController.position.minScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll == initialScroll;
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll == maxScroll;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data?.todayRecipes ?? [];
          return ListView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            children: [
              TodayRecipeListView(
                recipes: recipes,
              ),
              const SizedBox(height: 16),
              FriendPostListView(
                friendPosts: snapshot.data?.friendPosts ?? [],
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
