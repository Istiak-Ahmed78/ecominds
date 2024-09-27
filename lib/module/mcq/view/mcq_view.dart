import 'package:ecominds/models/mcq_model.dart';
import 'package:ecominds/module/mcq/controller/mcq_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MCQView extends GetView<McqController> {
  const MCQView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        controller.mCQSectionModel.contenst ?? '',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: controller.mCQSectionModel.macqList
                          ?.asMap()
                          .entries
                          .map<Widget>((e) {
                        return MCQWidget(
                          mcq: e.value,
                          questionInedex: e.key,
                          givenAnserIndex: controller.answerIndexs[e.key],
                        );
                      }).toList() ??
                      [],
                )
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

  const MCQWidget(
      {Key? key,
      required this.mcq,
      required this.questionInedex,
      required this.givenAnserIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4,
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
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10.0),
            // Points
            Text(
              "Points: ${mcq.points ?? 0}",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10.0),
            // Options List
            Column(
              children: List.generate(mcq.options?.length ?? 0, (index) {
                return _buildOption(mcq.options![index], index, questionInedex,
                    givenAnserIndex);
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for displaying each option
  Widget _buildOption(
      String option, int optionIndex, int questionIndex, int? givenAnserIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: (givenAnserIndex != null) && optionIndex == givenAnserIndex
            ? Colors.greenAccent.withOpacity(0.2)
            : Colors.white,
        border: Border.all(
          color: (givenAnserIndex != null) && optionIndex == givenAnserIndex
              ? Colors.green
              : Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        onTap: () => McqController.to.setAnswer(questionIndex, optionIndex),
        title: Text(
          option,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
