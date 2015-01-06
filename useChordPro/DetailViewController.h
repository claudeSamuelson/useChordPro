//
//  DetailViewController.h
//  useChordPro
//
//  Created by ANDRIANARIJAONA Claude on 03/01/2015.
//  Copyright (c) 2015 firstInfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Song.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *songTitle;
@property (weak, nonatomic) IBOutlet UIView *ContentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;

@property (weak, nonatomic) IBOutlet UILabel *songAuthor;
@property (weak, nonatomic) IBOutlet UILabel *songDescription;
@property (weak, nonatomic) IBOutlet UITextView *bodySongTextView;



@property (strong, nonatomic) id detailItem;


@end
