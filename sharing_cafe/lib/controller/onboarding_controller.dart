import 'package:sharing_cafe/data/model/response/onboarding_model.dart';
import 'package:sharing_cafe/data/repository/onboarding_repo.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController implements GetxService {
  final OnBoardingRepo onboardingRepo;
  OnBoardingController({required this.onboardingRepo});

  List<OnBoardingModel> _onBoardingList = [];
  int _selectedIndex = 0;

  List<OnBoardingModel> get onBoardingList => _onBoardingList;
  int get selectedIndex => _selectedIndex;

  void changeSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void getOnBoardingList() {
      _onBoardingList = [];
      _onBoardingList.addAll(onboardingRepo.getOnBoardingList());
    update();
  }
}
