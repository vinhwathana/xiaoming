// BASE SERVICE URL
// const String baseUrl = 'https://edps.ddns.net/hrmis_api_mptc_training/v1';
const String baseUrl = "https://edps.ddns.net/hrmis_api_mptc_dev/v1";

// ENDPOINT: AUTHENTICATION
const String authLogin = '$baseUrl/user/login';
const String authLogout = '$baseUrl/user/logout';
const String recoverUserPassword = '$baseUrl/user/recoveryUserPassword';
const String changeUserPassword = '$baseUrl/user/changeUserPassword';
const String changePassword = '$baseUrl/user/Changepassword';

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
const String statCertificate = "$baseUrl/statistics/Certificates";

///?MinistryCode=20&Org=00&Dept=00&degree=B
const String statSkillByDegree = "$baseUrl/statistics/SkillByDegree";

///?MinistryCode=20&Org=80&Dept=93
const String statSkills = "$baseUrl/statistics/Skills";

///?MinistryCode=20&Org=80&Dept=93
const String statMerit = "$baseUrl/CountMeritByOrg/Getcount_merit_by_org";

///?MinistryCode=20&Org=80&Dept=93
const String statStaff = "$baseUrl/CountStaff/Getcountstaff";

///?MinistryCode=20&Org=80&Dept=87&start=0&length=10&search
const String statKrobKhan =
    "$baseUrl/CountKrobkhanByOrg/Getcount_krob_khan_by_org";

///?MinistryCode=20&Org=80&Dept=87&degree=B&start=0&length=10&search
const String statCertificatePeople = "$baseUrl/statistics/CertificatesPeople";

///?MinistryCode=20&Org=80&Dept=87&degree=P&start=0&length=10&search=&country=&skill=
const String statSkillPeople = "$baseUrl/statistics/SkillsPeople";

///?MinistryCode=20&Org=00&Dept=00&degree=B&start=0&search&length=10&&skill=&country
const String statSkillByDegreePeople = "$baseUrl/statistics/SkillByDegreePeople";

///?MinistryCode=20&Org=80&Dept=87&start=0&length=10&search
const String statStaffPeople = "$baseUrl/CountStaff/Getcountstaffpeople";

///?MinistryCode=20&Org=80&Dept=87&start=0&length=10&search
const String statMeritPeople = "$baseUrl/CountMeritByOrg/Getcount_merit_by_org_people";

///?MinistryCode=20&Org=80&Dept=87&start=0&length=10&search
const String statKrobKhanPeople = "$baseUrl/CountKrobkhanByOrg/Getcount_krob_khan_by_org_people";






///ATTENDANCE
///
///https://{{domain}}/attendances/personal-attd-by-date-ranges?dateFrom=2022-02-9&dateTo=2022-02-11
const String personalAttendance =
    "$baseUrl/attendances/personal-attd-by-date-ranges";

///https://{{domain}}/attendances-time-rules/1
const String attendanceRuleById = "$baseUrl/attendances-time-rules";

///https://{{domain}}/attendances/personal-attd-by-date/2022-01-20
const String personalAttendanceByDate =
    "$baseUrl/attendances/personal-attd-by-date";

///https://{{domain}}/attendances/personal-attd-log-by-date/2022-02-10
const String personalAttendanceLog =
    "$baseUrl/attendances/personal-attd-log-by-date";
