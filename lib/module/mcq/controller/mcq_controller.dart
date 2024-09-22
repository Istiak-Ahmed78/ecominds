import 'package:ecominds/models/mcq_model.dart';
import 'package:get/get.dart';

class McqController extends GetxController {
  static McqController get to => Get.find<McqController>();
  var mCQSectionModel = MCQSectionModel(
    contenst:
        'Academic Reading Test has three sections or three reading passages that you\'ll have to answer in an hour. Each reading passage will come with 13-14 questions and three reading passages will have 40 questions (sometimes 41) in total. Each question carries 1 mark. For each correct answer, you will get one mark.',
    macqList: [
      MCQModel(
        title: "What is the capital of France?",
        points: 10,
        options: ["Paris", "Berlin", "Madrid", "Rome"],
        answerIndex: 0, // Paris
      ),
      MCQModel(
        title: "Which planet is known as the Red Planet?",
        points: 5,
        options: ["Earth", "Mars", "Jupiter", "Venus"],
        answerIndex: 1, // Mars
      ),
      MCQModel(
        title: "Who wrote 'Hamlet'?",
        points: 7,
        options: [
          "Mark Twain",
          "William Shakespeare",
          "Charles Dickens",
          "J.K. Rowling"
        ],
        answerIndex: 1, // William Shakespeare
      ),
      MCQModel(
        title: "What is the chemical symbol for water?",
        points: 8,
        options: ["O2", "H2O", "CO2", "HO"],
        answerIndex: 1, // H2O
      ),
      MCQModel(
        title: "What is the square root of 64?",
        points: 6,
        options: ["6", "7", "8", "9"],
        answerIndex: 2, // 8
      ),
    ],
  );

  RxList<int?> answerIndexs = <int?>[].obs;

  void setAnswer(int questionIndex, int answerIndex) {
    var currentValue = answerIndexs[questionIndex];
    if (currentValue == null) {
      answerIndexs[questionIndex] = answerIndex;
    } else {
      if (answerIndex == currentValue) {
        answerIndexs[questionIndex] = null;
      } else {
        answerIndexs[questionIndex] = answerIndex;
      }
    }
    update();
  }

  @override
  void onInit() {
    answerIndexs.value =
        List.generate(mCQSectionModel.macqList?.length ?? 0, (index) => null);
    update();
    super.onInit();
  }
}
