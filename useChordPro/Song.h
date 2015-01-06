//
//  Song.h
//  useChordPro
//
//  Created by ANDRIANARIJAONA Claude on 03/01/2015.
//  Copyright (c) 2015 firstInfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject{
    NSString *title;
    NSString *author;
    NSDictionary *comments;
    NSDictionary *songDetails;
    int nbLine;
}
-(id)initWithTitle:(NSString *)xtitle wAuthor:(NSString *)xauthor wComment:(NSDictionary *)xcomments wSongDetails:(NSDictionary *)xSongDetails wNbLine:(int) xNbLine;
-(NSString *)getTitle;
-(NSString *)getAuthor;
-(NSDictionary *)getComments;
-(NSDictionary *)getSongDetail;
-(int)getNbLine;
@end
