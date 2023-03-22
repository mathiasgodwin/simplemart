import 'package:flutter/material.dart';
import 'package:simplemart/src/configs/theme/styles.dart';

class UserAccountPage extends StatelessWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You're Welcome",
            style: theme.textTheme.headlineSmall,
          ),
          HSpace.s10,
          const Text('mr.nice.guy@whoknows.com')
        ],
      ),
    );
  }
}
