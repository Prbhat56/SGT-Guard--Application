const String baseUrl = 'https://sgt-inhouse.myclientdemo.us/api/'; //STAGE_URL
// const String baseUrl = 'https://sgtsuperadmin.oohap.com/api/'; //PRODUCTION_URL


Map<String, String> apiRoutes = {
  "login": "guard/login",
  "logout":"guard/logout",
  "forgetPassword":"guard/forget-password",
  "verifyOtp":"guard/verify-otp",
  "resetPassword":"guard/reset-password",
  "updatePassword":"guard/update-password",
  "updateProfilePic":"guard/update-profile-pic",
  "profileUpdate":"guard/profile-update",
  "leavePolicy":"guard/leave-policy",
  "helpAndSupport":"guard/help-and-support",
  "privacyPolicy":"guard/privacy-policy",
  "termsCondition":"guard/privacy-policy"
};
