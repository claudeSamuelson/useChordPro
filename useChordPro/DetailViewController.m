//
//  DetailViewController.m
//  useChordPro
//
//  Created by ANDRIANARIJAONA Claude on 03/01/2015.
//  Copyright (c) 2015 firstInfo. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end


@implementation DetailViewController

@synthesize songAuthor, songTitle, songDescription, bodySongTextView;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        NSString *description = [[NSString alloc]init];
        NSString *songDetail = [[NSString alloc] init];
        songTitle.text = [self.detailItem getTitle];
        songAuthor.text = [self.detailItem getAuthor];
        
        int nbLine = [self.detailItem getNbLine];
        
        NSDictionary *comments = [self.detailItem getComments];
        NSDictionary *songWithKeys = [self.detailItem getSongDetail];
        for (int i=0;i<nbLine;i++){
            if ([comments objectForKey:[NSNumber numberWithInt:i]]!=nil){
                NSString *comment = [[NSString alloc] init];
                comment = [comments objectForKey:[NSNumber numberWithInt:i]];
                if (i==2 || i==3){
                    description = [description stringByAppendingString:comment];
                    description = [description stringByAppendingString:@"\r\n"];
                }
                else {
                    songDetail = [songDetail stringByAppendingString:comment];
                    songDetail = [songDetail stringByAppendingString:@"\r\n"];
                }
            }
            else if ([songWithKeys objectForKey:[NSNumber numberWithInt:i]]!=nil){
                NSArray *arraySong = [songWithKeys objectForKey:[NSNumber numberWithInt:i]];
                NSArray *posKeys = [arraySong objectAtIndex:0];
                NSArray *keys = [arraySong objectAtIndex:1];
                //Longueur des clés qu'on a extrait
                int longKey = 0;
                for (int l=0; l<keys.count;l++){
                    longKey += [keys[l] length];
                }
                //Plus []
                longKey += 2*keys.count;
                
                NSString *lyrics = [arraySong objectAtIndex:2];
                NSString *strKey = [[NSString alloc] init];
                int currPosKey = 0;
                for (int k=0;k<lyrics.length+longKey;k++){
                    if ([posKeys containsObject:[NSNumber numberWithInt:k]]){
                        strKey = [strKey stringByAppendingString:[keys objectAtIndex:currPosKey]];
                        currPosKey++;
                    }
                    else strKey = [strKey stringByAppendingString:@" "];
                }
                songDetail = [songDetail stringByAppendingString:strKey];
                songDetail = [songDetail stringByAppendingString:@"\r\n"];
                songDetail = [songDetail stringByAppendingString:lyrics];
                songDetail = [songDetail stringByAppendingString:@"\r\n"];
            }
        }
        songDescription.text = description;
       
        bodySongTextView.text = songDetail;
    }
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.scrollerView layoutIfNeeded];
    self.scrollerView.contentSize = self.ContentView.bounds.size;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    bodySongTextView.scrollEnabled = NO;
	// Do any additional setup after loading the view, typically from a nib.

    [self configureView];
}


@end
