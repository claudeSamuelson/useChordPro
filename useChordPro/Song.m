//
//  Song.m
//  useChordPro
//
//  Created by ANDRIANARIJAONA Claude on 03/01/2015.
//  Copyright (c) 2015 firstInfo. All rights reserved.
//

#import "Song.h"

@implementation Song
-(id)initWithTitle:(NSString *)xtitle wAuthor:(NSString *)xauthor wComment:(NSDictionary *)xcomments wSongDetails:(NSDictionary *)xSongDetails wNbLine:(int)xNbLine{
    title = xtitle;
    author = xauthor;
    comments = [[NSDictionary alloc] init];
    comments = xcomments;
    songDetails = [[NSDictionary alloc] init];
    songDetails = xSongDetails;
    nbLine = xNbLine;
    return self;
}
-(NSString *) getTitle{
    return title;
}
-(NSString *)getAuthor{
    return author;
}
-(NSDictionary *)getComments{
    return comments;
}
-(NSDictionary *)getSongDetail{
    return songDetails;
}
-(int) getNbLine{
    return nbLine;
}
@end
