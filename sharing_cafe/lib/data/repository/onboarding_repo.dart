import 'package:sharing_cafe/data/model/response/onboarding_model.dart';
import 'package:sharing_cafe/util/images.dart';
class OnBoardingRepo {

  List<OnBoardingModel> getOnBoardingList() {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(Images.onboard_1, 'on_boarding_1_title', 'on_boarding_1_description'),
        OnBoardingModel(Images.onboard_2, 'on_boarding_2_title', 'on_boarding_2_description'),
        OnBoardingModel(Images.onboard_3, 'on_boarding_3_title', 'on_boarding_3_description'),
      ];
      return onBoardingList;

}
}