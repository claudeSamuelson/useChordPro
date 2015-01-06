//
//  FileManager.h
//  useChordPro
//
//  Created by ANDRIANARIJAONA Claude on 03/01/2015.
//  Copyright (c) 2015 firstInfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"

@interface FileManager : NSFileManager{
    NSString *dirName;
    NSMutableDictionary *songDico;
    NSMutableArray *letters;
}

-(id)init:(NSString*) repName;
-(NSMutableDictionary *)getSongDico;
-(Song *)getSongByTitle:(NSString *)songName;
-(NSMutableArray *)getLetters;

@end

