#import "FCSegmentedControl.h"

//
//  FCSegmentedControl.h
//
//  Created by Mayank Gupta on 30/07/2014.
//  Copyright (c) 2014 InfoEdge. All rights reserved.
//


@implementation FCSegmentedControl

- (void)setBadgeNumber:(NSUInteger)badgeNumber
     forSegmentAtIndex:(NSUInteger)segmentIndex
            usingBlock:(void (^)(CustomBadge*))configureBadge
{
    // If this is the first time a badge number has been set, then initialise the
    // badges
    if (_segmentBadgeNumbers.count == 0) {
        // initialise the badge arrays
        _segmentBadgeNumbers =
            [NSMutableArray arrayWithCapacity:self.numberOfSegments];
        _segmentBadges = [NSMutableArray arrayWithCapacity:self.numberOfSegments];
        for (int index = 0; index < self.numberOfSegments; index++) {
            [_segmentBadgeNumbers addObject:[NSNumber numberWithInt:0]];
            [_segmentBadges addObject:[NSNull null]];
        }

        // Create a transparent view to go on top of the segmented control and to
        // hold the badges. (This transparent view is added to the superview to work
        // around strange UISegmentedControl behaviour which causes its own subviews
        // to be obscured when certain segments are selected. It's important then
        // that the MESegmentedControl is placed on top of a suitable view and not
        // directly onto a UINavigationItem.)
        _badgeView = [[UIView alloc] initWithFrame:self.frame];
        [_badgeView setBackgroundColor:[UIColor clearColor]];
        _badgeView.userInteractionEnabled = NO;
        [self.superview addSubview:_badgeView];
    }

    // Recall the old badge number and store the new badge number
    int oldBadgeNumber = ((NSNumber*)[_segmentBadgeNumbers objectAtIndex:segmentIndex]).intValue;
    [_segmentBadgeNumbers
        replaceObjectAtIndex:segmentIndex
                  withObject:[NSNumber numberWithUnsignedInteger:badgeNumber]];

    // Modify the badge view
    if ((oldBadgeNumber == 0) && (badgeNumber > 0)) {
        // Add a badge, positioned on the upper right side of the requested segment
        // (Assumes that all segments are the same size - if segments are of
        // different sizes, modify the below to use the widthForSegmentAtIndex
        // method on UISegmentedControl)
        CustomBadge* customBadge;
        if (badgeNumber > 99) {
            customBadge = [CustomBadge customBadgeWithString:@"99+"];
        } else {
            customBadge = [CustomBadge
                customBadgeWithString:[NSString stringWithFormat:@"%d", badgeNumber]];
        }

        [customBadge
            setFrame:CGRectMake(
                         ((self.frame.size.width / self.numberOfSegments) * (segmentIndex + 1)) - customBadge.frame.size.width - 1,
                         (self.frame.size.height - customBadge.frame.size.height) / 2 + 3,
                         customBadge.frame.size.width,
                         customBadge.frame.size.height - 6)];
        [_segmentBadges replaceObjectAtIndex:segmentIndex
                                  withObject:customBadge];
        [_badgeView addSubview:customBadge];
    } else if ((oldBadgeNumber > 0) && (badgeNumber == 0)) {
        // Remove the badge
        [[_segmentBadges objectAtIndex:segmentIndex] removeFromSuperview];
        [_segmentBadges replaceObjectAtIndex:segmentIndex
                                  withObject:[NSNull null]];
    } else if ((oldBadgeNumber != badgeNumber) && (badgeNumber > 0)) {
        // Update the number on the existing badge
        if (badgeNumber > 99) {
            [[_segmentBadges objectAtIndex:segmentIndex]
                autoBadgeSizeWithString:@"99+"];
        } else {
            [[_segmentBadges objectAtIndex:segmentIndex]
                autoBadgeSizeWithString:[NSString
                                            stringWithFormat:@"%d", badgeNumber]];
        }
    }

    // Yield to the block for any custom setup to be done on the badge
    if (badgeNumber > 0) {
        configureBadge([_segmentBadges objectAtIndex:segmentIndex]);
    }
}

- (void)setBadgeNumber:(NSUInteger)badgeNumber
     forSegmentAtIndex:(NSUInteger)segmentIndex
{
    [self setBadgeNumber:badgeNumber
        forSegmentAtIndex:segmentIndex
               usingBlock:^(CustomBadge* badge) {}];
}

- (NSUInteger)getBadgeNumberForSegmentAtIndex:(NSUInteger)segmentIndex
{
    if (_segmentBadgeNumbers == nil) {
        return 0;
    }
    NSNumber* number = [_segmentBadgeNumbers objectAtIndex:segmentIndex];
    if (number == nil) {
        return 0;
    } else {
        return [number unsignedIntegerValue];
    }
}

- (void)clearBadges
{
    // Remove the badge view
    [_badgeView removeFromSuperview];

    // Clear the badge arrays
    [_segmentBadges removeAllObjects];
    [_segmentBadgeNumbers removeAllObjects];
}

- (void)changeBadgeType:(SEGMENT_BADGE_TYPE)argBadgeType
      forSegmentAtIndex:(NSUInteger)segmentIndex
{
    if ([[_segmentBadges objectAtIndex:segmentIndex]
            isKindOfClass:CustomBadge.class]) {
        [((CustomBadge*)[_segmentBadges objectAtIndex:segmentIndex])
            changeBadgeType:argBadgeType];
    }
}

- (void)removeFromSuperview
{
    if (_badgeView)
        [_badgeView removeFromSuperview];
    [super removeFromSuperview];
}

- (void)dealloc
{
    if (_badgeView)
        [_badgeView removeFromSuperview];
}

@end
