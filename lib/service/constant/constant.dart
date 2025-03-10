//  const String baseUrl = 'https://sgt-inhouse.myclientdemo.us/api/'; //STAGE_URL
//  const String baseUrl = 'https://appdeveloperpro.online/api/'; //NEW PRODUCTION URL
// const String baseUrl = 'https://sgtsuperadmin.oohap.com/api/'; //PRODUCTION_URL
// const String baseImageUrl = 'https://sgt-inhouse.myclientdemo.us'; //Image_URL
// const String baseUrl = 'https://arrowtrack-solutions.com/api/'; // Latest Production URL
const String baseUrl = 'https://arrowtrack-solutions.com/public/api/'; // Latest Production URL


Map<String, String> apiRoutes = {
  "login": "guard/login",
  "logout": "guard/logout",
  "forgetPassword": "guard/forget-password",
  "verifyOtp": "guard/verify-otp",
  "resetPassword": "guard/reset-password",
  "updatePassword": "guard/update-password",
  "userDetails": "guard/user-details",
  "updateProfilePic": "guard/update-profile-pic",
  "country": "guard/country-list",
  "state": "guard/state-list",
  "city": "guard/city-list",
  "profileUpdate": "guard/profile-update",
  "leavePolicy": "guard/leave-policy",
  "leaveApply": "guard/leave-apply",
  "leaveRequestCancel" : "guard/leave-request-delete",
  "leaveStatusList": "guard/leave-applications",
  "leaveMissingShift":"guard/leave-apply-missing-shifts",
  "helpAndSupport": "guard/help-and-support",
  "privacyPolicy": "guard/privacy-policy",
  "termsCondition": "guard/privacy-policy",
  "homePage": "guard/home",
  "checkpointListPropertyWise": "guard/checkpoint-list-without-shift-id",
  "checkpointListShiftWise": "guard/checkpoint-list",
  "checkpointDetails": "guard/checkpoint-details",
  "checkpointTaskList": "guard/checkpoint-task-list",
  "checkpointTaskUpdate": "guard/checkpoint-task-update",
  "dutyList": "guard/duty-list",
  "dutyDetails": "guard/duty-details/",
  "timeSheet": "guard/timesheet",
  "activePropertyList": "guard/active-property-list",
  "missedShiftList": "guard/missed-shifts",
  "assignedPropertiesList":"guard/assigned-property-list",
  "generalReport": "guard/general-report-submit",
  "maintenanceReport": "guard/maintenance-report-submit",
  "parkingReport": "guard/parking-report-submit",
  "emergencyReport": "guard/emergency-report-submit",
  "myReport": "guard/report-list-filtered",
  "todaysActivePropertyList": "guard/todays-active-property",
  "clockIn": "guard/clock-in",
  "clockOut": "guard/clock-out",
  "notification": "guard/notifications",
  "propertyOwnerNotification":"guard/notify-property-owner ",
};
