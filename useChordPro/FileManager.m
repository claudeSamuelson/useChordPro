//
//  FileManager.m
//  useChordPro
//
//  Created by ANDRIANARIJAONA Claude on 03/01/2015.
//  Copyright (c) 2015 firstInfo. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

-(id)init:(NSString*)repName{
    dirName = repName;
    NSMutableArray *songList = [[NSMutableArray alloc] init];
    songDico = [[NSMutableDictionary alloc] init];
    NSMutableArray *songByAlphabet = [[NSMutableArray alloc]init];
    letters = [[NSMutableArray alloc]init];
    NSString *currentDeb = [[NSString alloc] initWithFormat:@"@"];
    NSArray *contents =[[NSBundle mainBundle] pathsForResourcesOfType:@".chordpro" inDirectory:dirName];
    for(NSString *file in contents){
        NSString* fileName = [[file lastPathComponent] stringByDeletingPathExtension];
        [songList addObject:fileName];
    }
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
    NSArray *songListOrdored = [songList sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    for (NSString *songTitle in songListOrdored){
        NSString *deb = [[NSString alloc] init];
        deb = [[songTitle substringToIndex:1] uppercaseString];
        if (![deb isEqualToString:currentDeb]){
            if (![currentDeb isEqualToString:@"@"]){
                [songDico setObject:songByAlphabet forKey:currentDeb];
                [letters addObject:currentDeb];
                //NSLog(@" ST%@",songByAlphabet);
            }
            ///[songByAlphabet removeObjectsInArray:songByAlphabet];
            songByAlphabet = [[NSMutableArray alloc] init];
            
            currentDeb = deb;
        }
        [songByAlphabet addObject:songTitle];
        
    }
    return self;
}
-(NSMutableDictionary *)getSongDico{
    return songDico;
}
-(NSMutableArray *)getLetters{
    return letters;
}
-(Song *)getSongByTitle:(NSString *)songName{
    Song *song;
    NSString *path = [[NSBundle mainBundle] pathForResource:songName ofType:@".chordpro" inDirectory:dirName];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSString *songContent = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *lines = [songContent componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n"]];
    NSString *songTitle,*songAuthor,*lyric = [[NSString alloc] init];
    NSMutableDictionary *comments = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *songWithKeys= [[NSMutableDictionary alloc]init];
    int pos = 0;
    NSArray *currentValues = [[NSArray alloc]init];
    for (NSString* line in lines) {
        if (line.length == 0) {pos++; continue;}
            if ([line hasPrefix:@"{t:"]){
            currentValues = [line componentsSeparatedByString:@"{t:"];
            songTitle = [currentValues objectAtIndex:1];
            songTitle = [songTitle substringToIndex:songTitle.length -1 ];
            //NSLog(@"SongTitle : %@",songTitle);
        }
        if ([line hasPrefix:@"{st:"]){
            currentValues = [line componentsSeparatedByString:@"{st:"];
            songAuthor = [currentValues objectAtIndex:1];
            songAuthor = [songAuthor substringToIndex:songAuthor.length -1 ];
            //NSLog(@"SongAuthor : %@",songAuthor);
        }
        if ([line hasPrefix:@"{c:"]){
            NSString *comment = [[NSString alloc] init];
            currentValues = [line componentsSeparatedByString:@"{c:"];
            comment = [currentValues objectAtIndex:1];
            comment = [comment substringToIndex:comment.length -1 ];
            [comments setObject:comment forKey:[NSNumber numberWithInt:pos]];
        };
        if ([line rangeOfString:@"["].location !=NSNotFound){
            currentValues = [line componentsSeparatedByString:@"["];
            NSMutableArray *keys =[[NSMutableArray alloc]init];
            NSMutableArray *posKeys =[[NSMutableArray alloc]init];
            NSMutableArray *songDetails = [[NSMutableArray alloc]init];
            for (NSString *currentLine in currentValues){
                if (currentLine.length){
                    NSArray *thisValues =[[NSArray alloc] init];
                    thisValues = [currentLine componentsSeparatedByString:@"]"];
                    NSString *realKey = [[NSString alloc] initWithFormat:@"[%@]",[thisValues objectAtIndex:0]];
                    if ([line rangeOfString:realKey].location !=NSNotFound)
                    [keys addObject:[thisValues objectAtIndex:0]];
                }
            }
            lyric = [line stringByAppendingString:@""];
            for (NSString *key in keys){
                NSString *realKey = [[NSString alloc] initWithFormat:@"[%@]",key];
                NSRange range = [line rangeOfString:realKey];
                if ([[line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] rangeOfString:realKey].location !=NSNotFound)
                [posKeys addObject:[NSNumber numberWithInteger:range.location]];
                lyric = [lyric stringByReplacingOccurrencesOfString:realKey withString:@""];
                lyric = [lyric stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            }
            [songDetails addObject:posKeys];
            [songDetails addObject:keys];
            [songDetails addObject:lyric];
            [songWithKeys setObject:songDetails forKey:[NSNumber numberWithInt:pos]];
        }
        pos++;
    }
    song = [[Song alloc] initWithTitle:songTitle wAuthor:songAuthor wComment:comments wSongDetails:songWithKeys wNbLine:pos];
    return song;
}
@end
