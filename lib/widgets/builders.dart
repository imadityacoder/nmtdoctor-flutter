import "package:flutter/material.dart";

Widget buildSection1Item({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color backgroundColor,
  VoidCallback? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: backgroundColor,
            child: Icon(icon, color: Colors.white),
          ),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    ),
  );
}

Widget buildSection2Item({
  required String title,
  required String subtitle,
  required IconData icon,
  VoidCallback? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, top: 6.0),
    child: Card(
      elevation: 3,
      child: Container(
        alignment: Alignment.centerLeft,
        width: 220,
        height: 120,
        child: ListTile(
          style: ListTileStyle.drawer,
          titleAlignment: ListTileTitleAlignment.threeLine,
          onTap: onTap,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(subtitle),
          leading: Icon(
            icon,
            size: 50,
            color: const Color.fromARGB(216, 255, 17, 0),
          ),
        ),
      ),
    ),
  );
}

Widget buildHealthCheckItem({
  required String title,
  required String price,
}) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: ListTile(
      leading: const Icon(Icons.check_circle, color: Colors.green),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(price),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
        ),
        onPressed: () {},
        child: const Text("Add"),
      ),
    ),
  );
}
