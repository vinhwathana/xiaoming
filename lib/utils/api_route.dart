// BASE SERVICE URL
const String baseUrl = 'https://edps.ddns.net/hrmis_api_mptc_training/v1';
// const String baseUrlTraining =
//     "https://edps.ddns.net/hrmis_api_mptc_dev/v1";

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

///STATISTIC

///ministry/MinistryCode = token contain field ministry

///?start=0&length=50&search=&ministry=20&parentId=0&orgRegion=025000&orgType=025001
///orgRegion = (ប្រភេទ) ទាំងអស់ = 00, ថ្នាក់ជាតិ = 025000, ថ្នាក់ក្រោមជាតិ = 026000,
///parentId = 00 (អគ្គនាយកដ្ឋាន), {អគ្គនាយកដ្ឋានId} (នាយកដ្ឋាន)
///search = for search
///orgType = "${orgRegion.first3Digit}" + 001(អគ្គនាយកដ្ឋាន)/002(នាយកដ្ឋាន)
const String getOrganization = "$baseUrl/ac/organization";

///Org = អគ្គនាយកដ្ឋាន || 0
///Dept = នាយកដ្ឋាន || 0
///degree = B,P,M,U

///?MinistryCode=20&Org=80&Dept=93
const String statCertificate = "$baseUrl/statistics/certificates";

///?MinistryCode=20&Org=00&Dept=00&degree=B
const String statSkillByDegree = "$baseUrl/statistics/skillbydegree";

///?MinistryCode=20&Org=80&Dept=93
const String statSkills = "$baseUrl/statistics/skills";

///?MinistryCode=20&Org=80&Dept=93
const String statGetMerit = "$baseUrl/CountMeritByOrg/getcount_merit_by_org";

///?MinistryCode=20&Org=80&Dept=93
const String statGetGender = "$baseUrl/CountStaff/getcountstaff";

///?MinistryCode=20&Org=80&Dept=93
const String statGetKrobKhan =
    "$baseUrl/CountKrobkhanByOrg/getcount_krob_khan_by_org";
