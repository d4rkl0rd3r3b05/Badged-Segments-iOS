//
//  FCSegmentedControl.h
//
//  Created by Mayank Gupta on 30/07/2014.
//  Copyright (c) 2014 InfoEdge. All rights reserved.
//

#import "CustomBadge.h"

@interface FCSegmentedControl : UISegmentedControl {
@private
    NSMutableArray* _segmentBadgeNumbers;
    NSMutableArray* _segmentBadges;
    UIView* _badgeView;
}

// Set the badge number for a specific segment.
// Setting the badge number to 0 will clear the badge for that segment.
// Use the block to make adjustments to badge formatting, using the methods
// outlined in CustomBadge.h.
- (void)setBadgeNumber:(NSUInteger)badgeNumber
     forSegmentAtIndex:(NSUInteger)segmentIndex
            usingBlock:(void (^)(CustomBadge*))configureBadge;

// Convenience method for setting a badge number with default look and feel.
- (void)setBadgeNumber:(NSUInteger)badgeNumber
     forSegmentAtIndex:(NSUInteger)segmentIndex;

// Get the badge number for a specific segment.
- (NSUInteger)getBadgeNumberForSegmentAtIndex:(NSUInteger)segmentIndex;

// Clear badges across all segments.
// If you need to add or remove segments, then call clearBadges first.
- (void)clearBadges;
- (void)changeBadgeType:(SEGMENT_BADGE_TYPE)argBadgeType
      forSegmentAtIndex:(NSUInteger)segmentIndex;

@end
