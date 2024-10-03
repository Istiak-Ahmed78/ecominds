// lib/controllers/login_controller.dart
import 'package:ecominds/models/mcq_model.dart';
import 'package:ecominds/module/all_complete_con_screen/all_complete_con_screen.dart';
import 'package:ecominds/module/home_page/models/tile_model.dart';
import 'package:ecominds/module/mcq/controller/mcq_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Controllers for input fields
  static HomeController get to => Get.find<HomeController>();

  RxInt currentTopicIndex = 0.obs;
  void changeTopicIndex(int index) {
    currentTopicIndex.value = index;
    update();
  }

  void onEnterAModule(int moduleIndex) {
    McqController.to.loadMCQList(tileData[moduleIndex].mcqData);
    changeTopicIndex(moduleIndex);
  }

  void inputACompleteTopic(List<double?> earnedPoin, BuildContext context) {
    var previous = tileData[currentTopicIndex.value];

    tileData[currentTopicIndex.value] = TileModel(
        imagePath: previous.imagePath,
        title: previous.title,
        lessons: previous.lessons,
        isUnlocked: true,
        earnedPoints: earnedPoin,
        videoLinks: previous.videoLinks,
        puzzleImageLink: previous.puzzleImageLink,
        matchingImageData: previous.matchingImageData,
        puzzlePoint: previous.puzzlePoint,
        mcqData: previous.mcqData);

    if (currentTopicIndex.value + 1 != tileData.length) {
      var next = tileData[currentTopicIndex.value + 1];
      tileData[currentTopicIndex.value + 1] = TileModel(
          imagePath: next.imagePath,
          title: next.title,
          lessons: next.lessons,
          videoLinks: next.videoLinks,
          isUnlocked: true,
          mcqData: next.mcqData,
          puzzleImageLink: next.puzzleImageLink,
          puzzlePoint: next.puzzlePoint,
          matchingImageData: next.matchingImageData,
          earnedPoints: [null, null, null, null]);
      Get.back();
    } else {
      Get.off(() => const CongratulationsScreen());
    }
    update();
  }

  @override
  void onInit() {
    lockUnlockStatuses.value = List.generate(
      4, // Number of rows
      (i) => List.generate(
        4, // Number of columns
        (j) => false, // Initial value for all elements
      ),
    );
    update();
    super.onInit();
  }

  RxList<List<bool>> lockUnlockStatuses = <List<bool>>[[]].obs;
  RxList<TileModel> tileData = [
    TileModel(
        imagePath:
            'assets/images/climate-change.png', // Placeholder image for module
        title: 'Climate Basics',
        lessons: '4 Lessons',
        isUnlocked: true, // Unlocked
        earnedPoints: [null, null, null, null],
        puzzlePoint: 5,
        videoLinks: [
          'https://www.youtube.com/watch?v=xk11DVaAjEA',
          'https://www.youtube.com/watch?v=2wgiy3Qo6gg',
          'https://www.youtube.com/watch?v=v3dO7PhYas4',
          'https://youtu.be/8DQeFmWUyd8?si=sJxQ6SFrnYwefKe1'
        ],
        puzzleImageLink:
            'https://eoimages.gsfc.nasa.gov/images/imagerecords/152000/152328/cyclonebelal_tmo_20240114_th.jpg',
        matchingImageData: {
          'Precipitation Piles':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/151000/151107/ncalflooding_tmo_2023075_th.jpg',
          'Tropical Storm':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/39000/39941/hilda_qsc_2009236_lrg.jpg',
          'Heat Dome':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/151000/151751/midwestheatdome_geos5_2023235_lrg.jpg',
          'Soaking up Sun':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/149000/149442/bhadlasolarpark_oli_202226_th.jpg',
        },
        mcqData: [
          MCQModel(
            title:
                "When people burn fossil fuels or clear forests, Carbon dioxide is released in the atmosphere. Half of it stays in the atmosphere. Where does the other half go?",
            points: 1,
            options: [
              "River and air",
              "Rain and mountains",
              "Ecosystem and ocean",
              "Outer layer of the earth"
            ],
            answerIndex: 2, // Ecosystem and ocean
          ),
          MCQModel(
            title:
                "Which satellite gives us the complete picture of global carbon cycling?",
            points: 1,
            options: ["CO-2", "OCO-2", "COO-2", "OCC-2"],
            answerIndex: 1, // OCO-2
          ),
          MCQModel(
            title: "What is the natural process of producing aerosol?",
            points: 1,
            options: ["Volcano", "Rain", "Pipetting", "Sunshine"],
            answerIndex: 0, // Volcano
          ),
          MCQModel(
            title:
                "What is the upcoming mission of NASA which will provide a global data set of aerosol distribution?",
            points: 1,
            options: ["SWOT", "PACE", "OMG", "APS"],
            answerIndex: 3, // APS
          ),
          MCQModel(
            title: "What was the original idea behind SEAWIFS?",
            points: 1,
            options: [
              "To observe the food habits of sea animals",
              "To monitor the colour of the ocean",
              "To identify the damage to green organisms",
              "To save sea animals from being extinct"
            ],
            answerIndex: 1, // To monitor the colour of the ocean
          ),
          MCQModel(
            title:
                "Which satellite gives us an unprecedented view of our planet's water ecosystem?",
            points: 1,
            options: ["SWOT", "PACE", "NAAMES", "OMG"],
            answerIndex: 0, // SWOT
          ),
          MCQModel(
            title:
                "How many satellites does NASA have to measure the height of the ocean, inland water, clouds, and much more?",
            points: 1,
            options: [
              "More than 15",
              "More than 10",
              "More than 20",
              "More than 25"
            ],
            answerIndex: 2, // More than 20
          ),
        ]),
    TileModel(
        imagePath: 'assets/images/earth.png',
        title: 'Global Warming',
        lessons: '4 Lessons',
        isUnlocked: false, // Locked
        puzzlePoint: 5,
        matchingImageData: {
          'Mapping Marine':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/149000/149163/microplastics_cygnss_2018098.jpg',
          'Mapping Methane':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/148000/148806/camethane_2017_th.jpg',
          'Deforestation':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/150000/150513/nuevaitalia_oli_2017235_lrg.jpg',
          'Dust effects':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/151000/151100/gobidesert_tmo_2023069_th.jpg',
        },
        puzzleImageLink:
            'https://eoimages.gsfc.nasa.gov/images/imagerecords/153000/153113/arcsix_tmo_20240615_th.jpg',
        earnedPoints: [null, null, null, null],
        videoLinks: [
          'https://youtu.be/8Rvl6z80baI?si=cdT1IekZ6Sdy2KVj',
          'https://youtu.be/lMe-ld5aShI?si=uiZUcNDOF5u-CgKG',
          'https://youtu.be/6vgvTeuoDWY?si=kU01DmEQRKTPCYZO',
          'https://youtu.be/b7kv9DT_Vgk?si=gVeWsDxIsfj8gRXB'
        ],
        mcqData: [
          MCQModel(
            title: "In which curve can we see the summer and winter cycle?",
            points: 1,
            options: [
              "Mandala Curve",
              "Keeling Curve",
              "Transcendental Curve",
              "Sinusoidal Curve"
            ],
            answerIndex: 1, // Keeling Curve
          ),
          MCQModel(
            title:
                "Before the industrial revolution, what was the amount of carbon dioxide in the atmosphere?",
            points: 1,
            options: ["300 ppm", "400 ppm", "275 ppm", "250 ppm"],
            answerIndex: 2, // 275 ppm
          ),
          MCQModel(
            title: "Which greenhouse gases trap heat?",
            points: 1,
            options: [
              "Methane and Ethane",
              "Carbon Monoxide and Ozone",
              "Carbon Dioxide and Methane",
              "CFC and Propane"
            ],
            answerIndex: 2, // Carbon Dioxide and Methane
          ),
          MCQModel(
            title:
                "What is the time when people have a tendency to get the flu?",
            points: 1,
            options: [
              "When the atmosphere is humid",
              "When the atmosphere is drier",
              "When it's rainy season",
              "When it's winter"
            ],
            answerIndex: 1, // When the atmosphere is drier
          ),
          MCQModel(
            title:
                "What is the percentage of people who live within or near coastal regions?",
            points: 1,
            options: ["60%", "30%", "40%", "50%"],
            answerIndex: 2, // 40%
          ),
          MCQModel(
            title: "What is EDDY?",
            points: 1,
            options: [
              "Circular moving body of water",
              "The characteristics of wind",
              "The flow rate of releasing O2",
              "The rules that sunlight follows in a specific temperature"
            ],
            answerIndex: 0, // Circular moving body of water
          ),
          MCQModel(
            title:
                "How many NASA satellites form a 'Single Great Art Observatory'?",
            points: 1,
            options: ["One Dozen", "Fifteen", "Two Dozen", "Twenty"],
            answerIndex: 2, // Two Dozen
          ),
        ]),
    TileModel(
        imagePath: 'assets/images/global-warming.png',
        title: 'Possible Threats',
        lessons: '4 Lessons',
        isUnlocked: false, // Locked
        puzzlePoint: 6,
        puzzleImageLink:
            'https://eoimages.gsfc.nasa.gov/images/imagerecords/152000/152982/iowaflooding_oli_20240624_th.jpg',
        earnedPoints: [
          null,
          null,
          null,
          null
        ],
        videoLinks: [
          'https://youtu.be/YfWCUYX2_U0?si=Vh1ruDNNjy7K7Gfm',
          'https://youtu.be/-NZIvvhGlR0?si=oAMnPtknZsW8ja-u',
          'https://youtu.be/4NBAlxwA6Rs?si=gJrg-ATtvItB3Tt0',
          'https://youtu.be/iAUFVUzZIhI?si=wFQMIgNstZllf6ia'
        ],
        matchingImageData: {
          'Fire\'s rapid growth':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/153000/153122/parkfire653_oli2_20240727_th.jpg',
          'Rising flood risks':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/150000/150274/dhaka_oli_202279.jpg',
          'Ozone hole':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/152000/152023/ozone_geos5_2023264.png',
          'Sea ice chokes':
              'https://eoimages.gsfc.nasa.gov/images/imagerecords/153000/153166/northwestpassage_pace_20240713_th.jpg',
        },
        mcqData: [
          MCQModel(
            title: "What is the main reason for climate change?",
            points: 1,
            options: [
              "Greenhouse gas",
              "Cutting down trees",
              "Using transportation",
              "Powering buildings"
            ],
            answerIndex: 0, // Greenhouse gas
          ),
          MCQModel(
            title:
                "What is the percentage of decrease in corn crop yield by 2069-2099?",
            points: 1,
            options: ["20%", "26%", "24%", "29%"],
            answerIndex: 2, // 24%
          ),
          MCQModel(
            title:
                "Warmer global temperatures and higher atmospheric CO2 could increase wheat crop yields up to?",
            points: 1,
            options: ["17%", "15%", "10%", "18%"],
            answerIndex: 0, // 17%
          ),
          MCQModel(
            title: "What is the biggest source of ignition in today’s life?",
            points: 1,
            options: ["Carbon dioxide", "Human", "Transports", "Fire"],
            answerIndex: 1, // Human
          ),
          MCQModel(
            title:
                "What was the time when deforestation in Brazil was at its peak?",
            points: 1,
            options: ["Early 2000", "Early 1980", "Early 2010", "Early 1990"],
            answerIndex: 0, // Early 2000
          ),
          MCQModel(
            title:
                "Which data is used to generate initial states of NASA climate models?",
            points: 1,
            options: [
              "Optical and radar reflecting imagery",
              "GPM micro imager radiance data",
              "Free space laser",
              "Macro laser transportation"
            ],
            answerIndex: 1, // GPM micro imager radiance data
          ),
        ]),
    TileModel(
        imagePath: 'assets/images/healthy.png',
        title: 'Climate Action',
        lessons: '4 Lessons',
        isUnlocked: false, // Locked
        puzzlePoint: 2,
        puzzleImageLink:
            'https://eoimages.gsfc.nasa.gov/images/imagerecords/152000/152203/FireSensefire_pho_2023282.jpg',
        earnedPoints: [
          null,
          null,
          null,
          null
        ],
        videoLinks: [
          'https://youtu.be/WCMsdz8wMQc?si=3uaQ-lEjvAIg0lRu',
          'https://youtu.be/d5BZFrfgQn8?si=ezML9vKU_QbyTteS',
          'https://youtu.be/FUq5d7dqlVY?si=CidB-q6bvio4TV7D',
          'https://youtu.be/ZLDzvt7XRHQ?si=TLVvg3gytWBL-eVV'
        ],
        matchingImageData: {},
        mcqData: [
          MCQModel(
            title:
                "What is the key source of fertilization for the Amazon rainforest?",
            points: 1,
            options: [
              "Monsoon wind coming from Brazil",
              "The humidity of weather",
              "Dust swept from Northern Africa",
              "Due to heavy rainfall"
            ],
            answerIndex: 2, // Dust swept from Northern Africa
          ),
          MCQModel(
            title: "What are the biggest emission reductions?",
            points: 1,
            options: [
              "Solar and Wind",
              "Water and Trees",
              "Rain and Rivers",
              "Water and Wind"
            ],
            answerIndex: 0, // Solar and Wind
          ),
          MCQModel(
            title:
                "What is the percentage of the potential to cut emissions by taking induced measures according to IPCC?",
            points: 1,
            options: ["50%", "60%", "70%", "80%"],
            answerIndex: 2, // 70%
          ),
          MCQModel(
            title:
                "What is the first major partnership with the 'Indian Space Agency' in earth science?",
            points: 1,
            options: ["PACE", "NISAR", "OMG", "SWOT"],
            answerIndex: 1, // NISAR
          ),
          MCQModel(
            title:
                "What instrument does 'PACE' carry to observe the changes through colors?",
            points: 1,
            options: [
              "OCI - Ocean Colour Instrument",
              "SOT - Sea Observing Tunnel",
              "OND - Observer of Natural Difference",
              "MIC - Micro Image Capturer"
            ],
            answerIndex: 0, // OCI - Ocean Colour Instrument
          ),
        ]),
  ].obs;
}

void _showCompletionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Congratulations!'),
        content: const Text('You completed the whole course'),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
