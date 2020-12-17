
struct TrackModel :Encodable {
    var id = ""
    var artist_id = ""
    var videoId = ""
    var p_listid = ""
    var album_name = ""
    var user_id = ""
    var cover_image = ""
    var title = ""
    var track_id = ""
    var artist_name = ""
    var type = ""
    var add_timestamp = ""
    var album_id = ""
}

struct AlbumModel :Encodable {
    var cover_image = ""
    var list_id = ""
    var title = ""
    var track_cnt = ""
    var tracklist = ""
    var user_name = ""
}

struct SearchModel :Encodable {
    var cover_image = ""
    var id = ""
    var title = ""
    var search_id = ""
}

struct PlayListModel :Encodable {
    var song_cnt = ""
    var id = ""
    var title = ""
    var sub_title = ""
}

struct EventQueueModel : Encodable {
    var EventNo = 0
    var EventTypeNo = 0
    var attendNo = 0
    var empID = ""
    var projectNo = ""
    var siteNo = ""
    var timeIn = ""
    var timeOut = ""
    var Duration = 0
    var Long = ""
    var Latt = ""
    var ExecBy = ""
    var ExecAt = ""
    var Allow = 0
    var Erp = 0
    var TAS = 0
    var DayInMilis = 0
    var Udp_by = ""
    var Udp_At = ""
    var shiftNo = ""
}

struct ReportDetailModel : Encodable {
    var date_ = ""
    var in_ = ""
    var out_ = ""
    var wo_ = ""
    var le_ = ""
    var l_ = ""
}

// report page

struct KPIModel : Encodable {
    var working_days = 0
    var worked_days = 0
    var attend_success_days_count = 0
    var worked_mins = 0
    var over_time = 0
    var early_entrance = 0
    var late_leave  = 0
    var jobModel = AlbumModel()
    var reportDetailModelArrayList = [ReportDetailModel]()
    
    var isSelected = true
}

struct NotificationLogModel : Encodable {
    var logNotificationNo = 0
    var logTime = ""
}
struct NotificationRoasterModel : Encodable {
    var roasterNo = 0
    var notificationNo = 0
    var scheduleNo = 0
    var eventNo = 0
    var broadcastType = ""
    var notificationType = ""
    var empID = 0
    var projectNo = 0
    var siteNo = 0
    var status = ""
    var validityPeriodStart = ""
    var validityPeriodEnd = ""
}

struct ScheduleModel : Encodable {
    var scheduleNo = 0
    var nameEn = ""
    var nameAr = ""
    var description = ""
    var periodType = ""
    var monthNumber = 0
    var dayNumber = 0
    var timeDay = ""
    var updBy = ""
    var updAt = ""
}

struct SupportContentModel : Encodable {
    var about_us = ""
    var message = ""
}


struct UserProfileModel : Encodable {
    var empName = ""
    var empNameAr = ""
    var empID = ""
    var natID = ""
    var phone = ""
    var email = ""
    var empNo = ""
    var assigned_jobs = ""
    var avatar_url = ""
    var verified = ""
    var imageData = ""
}
struct PrivacyPolicyModel : Encodable {
    var text = ""
    var last_updated = ""
    
}
