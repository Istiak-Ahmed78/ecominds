import 'package:ecominds/models/mcq_model.dart';
import 'package:ecominds/module/level_control/controller/level_controller.dart';
import 'package:ecominds/module/mcq/controller/mcq_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MCQView extends GetView<McqController> {
  const MCQView({super.key, required this.onCompleteClick});
  final ValueChanged<int> onCompleteClick;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 16.0, vertical: 8.0),
                //   child: Card(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15.0),
                //     ),
                //     child: Padding(
                //       padding: const EdgeInsets.all(10),
                //       child: Text(
                //         controller.mCQSectionModel.contenst ?? '',
                //         style: const TextStyle(fontSize: 18),
                //       ),
                //     ),
                //   ),
                // ),
                Column(
                  children:
                      controller.macqList.asMap().entries.map<Widget>((e) {
                            return MCQWidget(
                              enableEdit: controller.enableEdit.value,
                              mcq: e.value,
                              questionInedex: e.key,
                              givenAnserIndex: controller.answerIndexs[e.key],
                            );
                          }).toList() ??
                          [],
                ),
                if (!controller.answerIndexs.any((e) => e == null)) ...[
                  Text(
                    'You got: ${controller.totalGottenNumber()} points',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
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
                          onPressed: () =>
                              controller.changeEditabilityState(false),
                          child: const Text(
                            'Reveal answers',
                          )),
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
                            onCompleteClick(1);
                            LavelController.to.addPointToALevel(
                                1, controller.totalGottenNumber().toDouble());
                          },
                          child: const Text('Proceed to next')),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      );
    });
  }
}

class MCQWidget extends StatelessWidget {
  final MCQModel mcq;
  final int questionInedex;
  final int? givenAnserIndex;
  final bool enableEdit;

  const MCQWidget({
    super.key,
    required this.mcq,
    required this.questionInedex,
    required this.enableEdit,
    required this.givenAnserIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
      color: Colors.green.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the MCQ
            Text(
              mcq.title ?? "No Title",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10.0),
            // Points
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                  text: TextSpan(children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.diamond,
                    size: 17,
                    color: Colors.yellowAccent,
                  ),
                ),
                TextSpan(
                    text: '${mcq.points ?? 0}',
                    style: const TextStyle(color: Colors.black))
              ])),
            ),

            const SizedBox(height: 10.0),
            // Options List
            Column(
              children: List.generate(mcq.options?.length ?? 0, (index) {
                return _buildOption(mcq.options![index], index, questionInedex,
                    givenAnserIndex, enableEdit);
              }),
            ),
            if (!enableEdit)
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (mcq.answerIndex == givenAnserIndex)
                      const Text(
                        'Correct!',
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold),
                      )
                    else ...[
                      const Text(
                        'Wrong!',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      Text(
                          'Correct answer: ${mcq.options?[mcq.answerIndex ?? 0]}')
                    ]
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  // Widget for displaying each option
  Widget _buildOption(String option, int optionIndex, int questionIndex,
      int? givenAnserIndex, bool enableEdit) {
    bool isClicked =
        (givenAnserIndex != null) && optionIndex == givenAnserIndex;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: isClicked ? Colors.green : Colors.white,
        border: Border.all(
          color: Colors.green,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        onTap: enableEdit
            ? () => McqController.to.setAnswer(questionIndex, optionIndex)
            : null,
        title: Text(
          option,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: isClicked ? Colors.white : Colors.green,
          ),
        ),
      ),
    );
  }
}
