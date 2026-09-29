
import 'package:flutter/material.dart';
import 'package:omran/core/models/user_profile.dart';
import 'package:omran/features/profile/view/profile_view.dart';

class HomeHeader extends StatelessWidget {
final UserProfile? user;

const HomeHeader({
super.key,
required this.user,
});

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);
final topPadding = MediaQuery.of(context).padding.top;

return Builder(
builder: (context) {
return Container(
width: double.infinity,
padding: EdgeInsets.only(
top: topPadding,
left: 8,
right: 12,
bottom: 18,
),
decoration: BoxDecoration(
color: theme.colorScheme.primary,
borderRadius: const BorderRadius.only(
bottomLeft: Radius.circular(32),
bottomRight: Radius.circular(32),
),
),
child: Row(
children: [
// Menu
IconButton(
onPressed: () {
Scaffold.of(context).openDrawer();
},
icon: const Icon(Icons.menu),
color: theme.colorScheme.onPrimary,
),

// Logo / Brand
Expanded(
child: Row(
children: [
Image.asset(
'assets/images/omran_logo_dark.png',
height: 36,
),
const SizedBox(width: 8),
Text(
'Omran',
style: theme.textTheme.titleLarge?.copyWith(
color: theme.colorScheme.onPrimary,
fontWeight: FontWeight.bold,
),
),
],
),
),

// Profile
GestureDetector(
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const ProfileView(),
),
);
},
child: CircleAvatar(
radius: 20,
backgroundColor:
theme.colorScheme.onPrimary.withValues(alpha: 0.15),
child: Text(
user?.initials ?? '?',
style: TextStyle(
fontWeight: FontWeight.bold,
color: theme.colorScheme.onPrimary,
),
),
),
),
],
),
);
},
);
}
}

