namespace * user

struct FeedRequest {
    1: optional i64 LatestTime //可选参数，限制返回视频的最新投稿时间戳，精确到秒，不填表示当前时间
    2: optional string Token // 可选参数，登录用户设置
}
struct FeedResponse {
    1: i32 StatusCode //状态码，0-成功，其他值失败
    2: optional string StatusMsg //返回状态描述
    3: list<Video> VideoList //视频列表
    4: optional i64 NextTime //本次返回的视频中，发布最早的时间，作为下次请求时的latest_time
}
struct Video {
    1: i64 Id //视频唯一标识
    2: User Author //视频作者信息
    3: string PlayPath //视频播放路径
    4: string CoverPath //视频封面路径
    5: i64 FavoriteCount //视频的点赞总数
    6: i64 CommentCount //视频的评论总数
    7: bool IsFavorite // true- 已点赞，false-未点赞
    8: string Title //视频标题
}
struct User {
    1: i64 Id //用户id
    2: string Name //用户名称
    3: optional i64 FollowCount //关注总数
    4: optional i64 FollowerCount //粉丝总数
    5: bool IsFollow // true-已关注，false-未关注
}
struct UserRegisterRequest {
    1: string Username //注册用户名，最长32个字符1525
    2: string Password //密码，最长32个字符
}
struct UserRegisterResponse {
    1: i32 StatusCode //状态码，0-成功，其他值失败
    2: optional string StatusMsg //返回状态描述
    3: i64 UserId //用户id
    4: string Token //用户鉴权token
}
struct UserLoginRequest {
    1: string Username //登录用户名
    2: string Password //登录密码
}
struct UserLoginResponse {
    1: i32 StatusCode //状态码，0-成功，其他值失败
    2: optional string StatusMsg //返回状态描述
    3: i64 UserId //用户id
    4: string Token //用户鉴权token
}
struct UserRequest {
    1: i64 UserId //用户id
    2: string Token //用户鉴权token
}
struct UserResponse {
    1: i32 StatusCode //状态码，0-成功，其他值-失败
    2: optional string StatusMsg //返回状态描述
    3: User User //用户信息
}
struct PublishActionRequest {
    1: string Token //用户鉴权token
    2: string FilePath  // 视频路径
    3: string CoverPath // 封面路径
    4: string Title //视频标题
}
struct PublishActionResponse {
    1: i32 StatusCode //状态码，0-成功，其他值-失败
    2: optional string StatusMsg //返回状态描述
}
struct PublishListRequest {
    1: i64 UserId //用户id
    2: string Token //用户鉴权token
}
struct PublishListResponse {
    1: i32 StatusCode //状态码，0-成功，其他值-失败
    2: optional string StatusMsg //返回状态描述
    3: list<Video> VideoList //用户发布的视频列表
}
struct Testinfo {
    1: string testinfo //测试信息
}
service UserService {
    //注册
    UserRegisterResponse UserRegister (1: UserRegisterRequest Req)
    //获取视频流
    FeedResponse UserGetFeed (1: FeedRequest Req)
    //登录
    UserLoginResponse UserLogin (1: UserLoginRequest Req)
    //获取用户信息
    UserResponse UserInfo (1: UserRequest Req)
    //获取用户发布作品
    PublishListResponse UserPublishList (1: PublishListRequest Req)
    //视频投稿
    PublishActionResponse UserPublishAction (1: PublishActionRequest Req)
    //rpc测试
    Testinfo UserTest (1: Testinfo Req)
}