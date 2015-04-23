//
//  CustomBadge.h
//
//  Created by Mayank Gupta on 30/07/2014.
//  Copyright (c) 2014 InfoEdge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    NOTIFICATION_BADGES,
    NORMAL_SELECTED_BADGES,
    NORMAL_UNSELECTED_BADGES
} SEGMENT_BADGE_TYPE;

@interface CustomBadge : UIView {

    NSString* badgeText;
    UIColor* badgeTextColor;
    UIColor* badgeInsetColor;
    UIColor* badgeFrameColor;
    BOOL badgeFrame;
    BOOL badgeShining;
    CGFloat badgeCornerRoundness;
    CGFloat badgeScaleFactor;
}

@property (nonatomic, retain) NSString* badgeText;
@property (nonatomic, retain) UIColor* badgeTextColor;
@property (nonatomic, retain) UIColor* badgeInsetColor;
@property (nonatomic, retain) UIColor* badgeFrameColor;

@property (nonatomic, readwrite) BOOL badgeFrame;
@property (nonatomic, readwrite) BOOL badgeShining;

@property (nonatomic, readwrite) CGFloat badgeCornerRoundness;
@property (nonatomic, readwrite) CGFloat badgeScaleFactor;

+ (CustomBadge*)customBadgeWithString:(NSString*)badgeString;
+ (CustomBadge*)customBadgeWithString:(NSString*)badgeString
                      withStringColor:(UIColor*)stringColor
                       withInsetColor:(UIColor*)insetColor
                       withBadgeFrame:(BOOL)badgeFrameYesNo
                  withBadgeFrameColor:(UIColor*)frameColor
                            withScale:(CGFloat)scale
                          withShining:(BOOL)shining;
- (void)autoBadgeSizeWithString:(NSString*)badgeString;
- (void)changeBadgeType:(SEGMENT_BADGE_TYPE)argBadgeType;

@end
