import 'package:ecominds/module/home_page/controller/home_controller.dart';
import 'package:ecominds/module/level_control/controller/level_controller.dart';
import 'package:ecominds/utils/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HandsOnActivityScreen extends StatefulWidget {
  final ValueChanged<int> onCompleteClick;
  const HandsOnActivityScreen({super.key, required this.onCompleteClick});

  @override
  _HandsOnActivityScreenState createState() => _HandsOnActivityScreenState();
}

class _HandsOnActivityScreenState extends State<HandsOnActivityScreen> {
  int totalPoints = 0; // To keep track of total points
  List<bool> isDoneList = List.generate(5, (i) => false);
  void changeDoneState(int index, bool st) {
    isDoneList[index] = st;
    setState(() {});
  }

  @override
  void initState() {
    totalPoints = 0;
    isDoneList = List.generate(5, (i) => false);
    setState(() {});
    super.initState();
  }

  void addPoints(int points) {
    setState(() {
      totalPoints += points;
    });
    MyToast.showToast('+$points Points Added!');
  }

  void handleMakingPosters() async {
    // Open file picker to choose a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // A file was selected, add 2 points
      addPoints(2);
      changeDoneState(0, true);
    }
  }

  void handleTreePickUpload() async {
    // Open file picker to choose a file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      // A file was selected, add 2 points
      addPoints(2);
      changeDoneState(2, true);
    }
  }

  void handleJoiningNatureClub() {
    TextEditingController linkController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Link'),
          content: TextField(
            controller: linkController,
            decoration: const InputDecoration(hintText: 'Enter link here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog and add points
                Navigator.of(context).pop();
                if (linkController.text.trim() != '') {
                  addPoints(2);
                  changeDoneState(1, true);
                }
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void handleInvitingFriends() {
    TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Friend\'s Name'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Enter name here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog and add points
                Navigator.of(context).pop();
                if (nameController.text.trim() != '') {
                  addPoints(2);
                  changeDoneState(4, true);
                }
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void handleEoFriendlyProductsInput() {
    TextEditingController nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter some eco friendly products you use'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Enter name here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog and add points
                Navigator.of(context).pop();
                if (nameController.text.trim() != '') {
                  addPoints(2);
                  changeDoneState(3, true);
                }
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EcoMindsModules(
          onTreePickUpload: handleTreePickUpload,
          onMakingPosters: handleMakingPosters,
          onJoiningNatureClub: handleJoiningNatureClub,
          onInvitingFriends: handleInvitingFriends,
          onEcoFriendlyProducts: handleEoFriendlyProductsInput,
          isDoneStates: isDoneList,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Total Points: $totalPoints',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.green.shade100,
                ),
                onPressed: () {
                  widget.onCompleteClick(3);
                  LavelController.to
                      .addPointToALevel(3, totalPoints.toDouble());
                  HomeController.to.inputACompleteTopic(
                      LavelController.to.levelScores, context);
                },
                child: const Text(
                  'Finish this course',
                )),
          ),
        ),
      ],
    );
  }
}

class EcoMindsModules extends StatelessWidget {
  final VoidCallback onMakingPosters;
  final VoidCallback onTreePickUpload;
  final VoidCallback onJoiningNatureClub;
  final VoidCallback onEcoFriendlyProducts;
  final VoidCallback onInvitingFriends;
  final List<bool> isDoneStates;

  const EcoMindsModules({
    super.key,
    required this.onMakingPosters,
    required this.onJoiningNatureClub,
    required this.onTreePickUpload,
    required this.onInvitingFriends,
    required this.onEcoFriendlyProducts,
    required this.isDoneStates,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        EcoModuleItem(
          icon: Icons.campaign,
          label: 'Making Posters',
          iconColor: Colors.orange,
          onTap: onMakingPosters,
          isDone: isDoneStates[0],
        ),
        EcoModuleItem(
          icon: Icons.nature_people,
          label: 'Joining Nature Club',
          iconColor: Colors.blue,
          onTap: onJoiningNatureClub,
          isDone: isDoneStates[1],
        ),
        EcoModuleItem(
          icon: Icons.park,
          label: 'Planting Trees',
          iconColor: Colors.green,
          onTap: onTreePickUpload,
          isDone: isDoneStates[2],
        ),
        EcoModuleItem(
          icon: Icons.check_circle,
          label: 'Using Eco Friendly Products',
          iconColor: Colors.teal,
          onTap: onEcoFriendlyProducts,
          isDone: isDoneStates[3],
        ),
        EcoModuleItem(
          icon: Icons.mail,
          label: 'Inviting Friends',
          iconColor: Colors.yellow,
          onTap: onInvitingFriends,
          isDone: isDoneStates[4],
        ),
      ],
    );
  }
}

class EcoModuleItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final bool isDone;
  final VoidCallback onTap; // Callback for handling taps

  const EcoModuleItem({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 40,
                color: iconColor,
              ),
            ),
            title: Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            trailing: IconButton(
              icon: isDone
                  ? const Icon(Icons.check)
                  : const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
