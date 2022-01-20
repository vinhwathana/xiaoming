// BASE SERVICE URL
const String baseUrl = 'https://Edps.ddns.net/hrmis_api_mptc_dev/v1';

// ENDPOINT: AUTHENTICATION
const String authLogin = '$baseUrl/user/login';
const String authLogout = '$baseUrl/user/logout';
const String recoverUserPassword = '$baseUrl/user/recoveryUserPassword';
const String changeUserPassword = '$baseUrl/user/changeUserPassword';

// ENDPOINT: USER
const String userProfile = '$baseUrl/employees';

// ENDPOINT: ATTENDANCE
const String attCheckIn = '$baseUrl/IsInside/location';

//FILE UPLOAD
const String getFile = "$baseUrl/file-upload/get-file";
