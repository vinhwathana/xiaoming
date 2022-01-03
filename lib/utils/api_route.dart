// BASE SERVICE URL
const String baseUrl = 'https://Edps.ddns.net/hrmis_api_mptc_dev/v1';

// ENDPOINT: AUTHENTICATION
const String authLogin = '$baseUrl/user/login'; // response : { _token }
const String authLogout = '$baseUrl/user/logout';

// ENDPOINT: USER
const String userProfile = '$baseUrl/user/profile';

// ENDPOINT: ATTENDANCE
const String attCheckIn = '$baseUrl/IsInside/location';
