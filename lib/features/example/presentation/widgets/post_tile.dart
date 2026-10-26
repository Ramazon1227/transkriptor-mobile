import 'package:flutter/material.dart';
import 'package:transkriptor_uz/features/example/domain/entities/post.dart';

class PostTile extends StatelessWidget {
  const PostTile({required this.post, super.key});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
    );
  }
}
