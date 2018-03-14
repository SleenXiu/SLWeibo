//
//  SLStatus.h
//  SLWeibo
//
//  Created by Sleen Xiu on 16/1/5.
//  Copyright © 2016年 cn.Xsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SLUser,SLStatus;

@interface SLStatusMediaInfo : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, copy) NSString *stream_url;
@property (nonatomic, copy) NSString *stream_url_hd;
@property (nonatomic, copy) NSString *h5_url;
@property (nonatomic, copy) NSString *mp4_sd_url;
@property (nonatomic, copy) NSString *mp4_hd_url;
@property (nonatomic, copy) NSString *h265_mp4_hd;
@property (nonatomic, copy) NSString *h265_mp4_ld;
@property (nonatomic, copy) NSString *inch_4_mp4_hd;
@property (nonatomic, copy) NSString *inch_5_mp4_hd;
@property (nonatomic, copy) NSString *inch_5_5_mp4_hd;
@property (nonatomic, copy) NSString *mp4_720p_mp4;
@property (nonatomic, copy) NSString *hevc_mp4_720p;
@property (nonatomic, assign) NSInteger prefetch_type;
@property (nonatomic, assign) NSInteger prefetch_size;
@property (nonatomic, assign) NSInteger act_status;
@property (nonatomic, copy) NSString *next_title;
@property (nonatomic, strong) NSDictionary *video_details; ///< size bitrare label
@property (nonatomic, strong) NSArray *play_comlaetion_action;
@property (nonatomic, assign) NSInteger video_publish_time;
@property (nonatomic, assign) NSInteger play_loop_type;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) NSString *author_name;
@property (nonatomic, assign) NSInteger has_recommend_video;
@property (nonatomic, assign) NSInteger video_feed_show_custom_bg;
@property (nonatomic, copy) NSString *online_users;
@property (nonatomic, assign) NSInteger online_users_number;
@property (nonatomic, assign) NSInteger is_keep_current_mblog;
@end

@interface SLStatusPicutreMeta :NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger cut_type;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) BOOL croped;
@end
@interface SLStatusPicutre : NSObject
@property (nonatomic, copy) NSString *pic_id;
@property (nonatomic, copy) NSString *object_id;
@property (nonatomic, assign) int photo_tag;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) SLStatusPicutreMeta *thumbnail;  ///< w:180
@property (nonatomic, strong) SLStatusPicutreMeta *bmiddle;    ///< w:360 (列表中的缩略图)
@property (nonatomic, strong) SLStatusPicutreMeta *middleplus; ///< w:480
@property (nonatomic, strong) SLStatusPicutreMeta *large;      ///< w:720 (放大查看)
@property (nonatomic, strong) SLStatusPicutreMeta *largest;    ///<       (查看原图)
@property (nonatomic, strong) SLStatusPicutreMeta *original;   ///<
@end

@interface SLStatusPageInfo : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *object_type;  // videp topic
@property (nonatomic, copy) NSString *page_pic;
@property (nonatomic, copy) NSString *page_url;
@property (nonatomic, copy) NSString *page_title;
@property (nonatomic, copy) NSString *content1;
@property (nonatomic, copy) NSString *content2;
@property (nonatomic, strong) SLStatusMediaInfo *media_info; // @"stream_url"
@property (nonatomic, strong) NSArray<SLStatusPicutre *> *pic_info;
@end

@interface SLStatusTopic : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *topic_url;
@property (nonatomic, copy) NSString *topic_title;
@property (nonatomic, assign) NSInteger is_invalid;
@end


@interface SLStatusUrlStruct : NSObject
@property (nonatomic, copy) NSString *url_type_pic;

@property (nonatomic, copy) NSString *url_title;

@property (nonatomic, copy) NSString *storage_type;

@property (nonatomic, copy) NSString *short_url;
@property (nonatomic, assign) BOOL result;
@property (nonatomic, copy) NSString *page_id;
@property (nonatomic, copy) NSString *ori_url;
@property (nonatomic, copy) NSString *object_type;
@property (nonatomic, assign) NSInteger need_save_obj;
@property (nonatomic, assign) NSInteger hide;
@property (nonatomic, strong) NSDictionary *actionlog;

@property (nonatomic, strong) NSArray<NSString *> *pic_ids;
@property (nonatomic, strong) NSDictionary<NSString *, SLStatusPicutre *> *pic_infos;
@end


@interface SLStatus : NSObject
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *mid;
@property (nonatomic, assign) BOOL can_edit;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger textLength;
@property (nonatomic, assign) NSInteger source_allowclick;
@property (nonatomic, assign) NSInteger source_type;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, assign) BOOL favorited;
@property (nonatomic, assign) BOOL truncated;

@property (nonatomic, copy) NSString *in_reply_to_status_id;
@property (nonatomic, copy) NSString *in_reply_to_user_id;
@property (nonatomic, copy) NSString *in_reply_to_screen_name;


@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, copy) NSString *bmiddle_pic;
@property (nonatomic, copy) NSString *original_pic;

@property (nonatomic, copy) NSString *geo;
@property (nonatomic, assign) BOOL is_paid;
@property (nonatomic, assign) NSInteger mblog_vip_type;

@property (nonatomic, assign) NSInteger reposts_count;
@property (nonatomic, assign) NSInteger comments_count;
@property (nonatomic, assign) NSInteger attitudes_count;
@property (nonatomic, assign) NSInteger pending_approval_count;
@property (nonatomic, assign) BOOL isLongText;
@property (nonatomic, assign) NSInteger m_level;
@property (nonatomic, assign) NSInteger more_info_type;
@property (nonatomic, copy) NSString *cardid;
@property (nonatomic, assign) NSInteger content_auth;
@property (nonatomic, strong) NSArray *buttons;
@property (nonatomic, copy) NSString *bid;
@property (nonatomic, strong) SLUser *user;
@property (nonatomic, strong) SLStatus *retweeted_status;
@property (nonatomic, strong) SLStatusPageInfo *page_info;
@property (nonatomic, strong) SLStatusTopic *topic_struct;
@property (nonatomic, strong) NSDictionary<NSString *, SLStatusPicutre *> *pic_infos;
@property (nonatomic, strong) NSArray<NSString *> *pic_ids;
@property (nonatomic, strong) SLStatusUrlStruct *url_struct;
@end



