import 'package:sharing_cafe/data/model/response/onboarding_model.dart';
import 'package:sharing_cafe/util/images.dart';
class OnBoardingRepo {

  List<OnBoardingModel> getOnBoardingList() {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(Images.onboard_1, 'Đọc những blog thú vị mỗi ngày!', 'Điều quan trọng nhất là phải kiên nhẫn, được khách hàng theo dõi, nhưng tôi chỉ đang cho nó thời gian...'),
        OnBoardingModel(Images.onboard_2, 'Tạo các sự kiện của riêng bạn với thế giới!', 'Điều quan trọng nhất là phải kiên nhẫn, được khách hàng theo dõi, nhưng tôi chỉ đang cho nó thời gian...'),
        OnBoardingModel(Images.onboard_3, 'Hãy kết nối với những người khác ngay nào!', 'Điều quan trọng nhất là phải kiên nhẫn, được khách hàng theo dõi, nhưng tôi chỉ đang cho nó thời gian...'),
      ];
      return onBoardingList;

}
}