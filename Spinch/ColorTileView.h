//
//  ColorTileView.h
//  Spinch
//
//  Created by Tommaso Piazza on 3/6/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorTileView : UIView
{
    BOOL _isSelected;
}

@property (nonatomic, assign) BOOL isSelected;

+(ColorTileView *) tileWithFrame:(CGRect) frame andColor:(UIColor *) color;

@end
