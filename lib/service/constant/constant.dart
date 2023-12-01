const String baseUrl = 'https://sgt-inhouse.myclientdemo.us/api/'; //STAGE_URL
// const String baseUrl = 'https://sgtsuperadmin.oohap.com/api/'; //PRODUCTION_URL


Map<String, String> apiRoutes = {
  "login": "guard/login",
  "logout":"guard/logout",
  "forgetPassword":"guard/forget-password",
  "verifyOtp":"guard/verify-otp",
  "resetPassword":"guard/reset-password",
  "updatePassword":"guard/update-password",
  "userDetails":"guard/user-details",
  "updateProfilePic":"guard/update-profile-pic",
  "country":"guard/country-list",
  "state":"guard/state-list",
  "city":"guard/city-list",
  "profileUpdate":"guard/profile-update",
  "leavePolicy":"guard/leave-policy",
  "helpAndSupport":"guard/help-and-support",
  "privacyPolicy":"guard/privacy-policy",
  "termsCondition":"guard/privacy-policy",
  "homePage":"guard/home",
  "checkpointListPropertyWise":"guard/checkpoint-list",
  "checkpointDetails":"guard/checkpoint-details",
  "checkpointTaskList":"guard/checkpoint-task-list",
  "dutyList":"guard/duty-list",
  "dutyDetails":"guard/guard/duty-details/",
  "timeSheet":"guard/timesheet",
  "activePropertyList":"guard/active-property-list",
};
