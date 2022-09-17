import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../data/data.dart';

class BottomShitIteamText extends StatelessWidget {
  final TaskEntity taskEntity;
  const BottomShitIteamText({Key? key, required this.taskEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(15),
      height: 260,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select",
            style: textTheme.displayLarge?.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 32),
          const SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text("Delete Items", style: textTheme.bodyLarge),
            onTap: () {
              taskEntity.delete();
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text("Share Text", style: textTheme.bodyLarge),
            onTap: () async {
              await Share.share(taskEntity.name);
            },
          ),
        ],
      ),
    );
  }
}
