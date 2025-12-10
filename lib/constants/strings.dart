
  class ServerLocalhost {
  static String server = "http://localhost:8000/api/";

  static String userLogin = "${server}user/login";
  static String register = "${server}user/register";

  static String changeTheServerUrl(String sever, urlFromClass) {
    return sever + urlFromClass;
  }
}

//Loclhost for physical Divise
class ServerLocalDiv {
  static String server = "http://192.168.1.200:8000/api/";

  // static String postAll = "${server}post/all";
  static String userLogin = "${server}user/login";
  static String register = "${server}user/register";
}

//Localhost for Emulator
class   ServerLocalhostEm {
  static String server = "http://192.168.2.4:8000/api/";
  static String seedGet = "${server}seed/get/";
  static String seedAdd = "${server}seed/add";
  static String getCustomPromotion = "${seedGet}custom-promotion";
  static String createPromotion = "${server}add/promation";
  static String createCustomPromotion = "$seedAdd/custom-promotion";
  static String getUserType = "${seedGet}user-type";
  static String getPromotionsOfClient = "${server}get/promation";
  static String   getPromotionsByStatus = "${server}get/promation-by-status";

  static String getInfluencersByCategory = "${seedGet}influencer-category";
    static String getInfluencerById = "${seedGet}influencer";
    static String getAllInfluencers = "${seedGet}influencers";
  static String getCategories = "${seedGet}category";
  // static String postAll = "${server}post/all";
  static String socialMediaOfIn = "${server}get-social-media-links-by-influencer";
  static String categoriesOfInf = "${server}get-categories-by-influencer";
  static String userLogin = "${server}auth/login";
  static String register = "${server}auth/register";
  static String completeProfile = "${server}auth/complete-profile";
  static String addSocialMedia = "${server}auth/add-social-media-links";
  static String addCategories = "${server}auth/assign-categories";
  //for test
}

class   PrefKeys {
  static const String userType = '';
  static const String userTypeId = 'user_type_id';
  static const String phone = 'phone';
  static const String token = 'token';
  static const String id = 'id';
  static const String lastLat = 'lastLat';
  static const String lastLng = 'lastLng';
  static const String language = 'language';
  static const String logged = 'logged';
  static const String isFirstTime = 'isFirstTime';
  static const String profile = 'profile';
  static const String name = 'name';
  static const String apartmentId = 'apartmentId';
  static const String facebook = 'facebook';
  static const String email = 'email';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String nickName = 'nickName';
  static const String gender = 'gender';
  static const String birthday = 'birthday';
// Influencer
  static const String inflRating = 'infl_rating';
  static const String inflBio = 'infl_bio';
  static const String inflGender = 'infl_gender';
  static const String inflShake = 'infl_shake';
  static const String inflTypeId = 'infl_type_id';
  static const String inflDob = 'infl_dob';
  static const String inflSocialLinks = 'infl_social_links';
  static const String inflCategories = 'infl_categories';
// Client
  static const String isHaveCr = 'is_have_cr';
  static const String regOwnerName = 'reg_owner_name';
  static const String institutionName = 'institution_name';
  static const String branchAddress = 'branch_address';
  static const String institutionAddress = 'institution_address';
  static const String rcNumber = 'rc_number';
  static const String nisNumber = 'nis_number';
  static const String nifNumber = 'nif_number';
  static const String iban = 'iban';
  static const String imageOfLicense = 'image_of_license';
  static const String identityNumber = 'identity_number'  ;
  static const String identityImage = 'identity_image';
  static const String profileImage = 'profile_image';
  static const String isVerified = 'is_verified';


}
