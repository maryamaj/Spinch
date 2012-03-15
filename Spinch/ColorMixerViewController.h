//
//  ColorMixerViewController.h
//  Spinch
//
//  Created by Tommaso Piazza on 3/5/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorTileView.h"
#import "SpinchModel.h"

@interface ColorMixerViewController : UIViewController
{
    NSMutableArray* _selectedTiles;
    float _hueOffSet;
}

@property (nonatomic, strong) NSMutableArray* selectedTiles;
@property (nonatomic, assign) float hueOffSet;

-(int) tileIdFromLocation:(CGPoint) locationInView;

@end
