//
//  MasterViewController.m
//  useChordPro
//
//  Created by ANDRIANARIJAONA Claude on 03/01/2015.
//  Copyright (c) 2015 firstInfo. All rights reserved.
//

#import "MasterViewController.h"
#import "FileManager.h"
#import "DetailViewController.h"

@interface MasterViewController () {
    NSDictionary *songs;
    NSArray *letters;
    FileManager *fileManager;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Init FileManager
    fileManager= [[FileManager alloc] init:@"chordpro"];
    songs = [[NSDictionary alloc] init];
    songs = [fileManager getSongDico];
    letters = [[NSMutableArray alloc] init];
    letters = [fileManager getLetters];

    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //Click sur button add
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewSong:)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewSong:(id)sender
{

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[songs allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[songs objectForKey:[letters objectAtIndex:section]] count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [letters objectAtIndex:section];
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return letters;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *letter = [[NSString alloc] initWithString:[letters objectAtIndex:indexPath.section]];
    NSString *songTitleWithAuthor = [songs objectForKey:letter][indexPath.row];
    NSArray *arrayDetailTitle = [songTitleWithAuthor componentsSeparatedByString:@"—"];
    if (arrayDetailTitle.count == 1){
        cell.textLabel.text = songTitleWithAuthor;
        cell.detailTextLabel.text = @"";
    }
    else if (arrayDetailTitle.count > 1){
        cell.textLabel.text = [arrayDetailTitle objectAtIndex:0];
        cell.detailTextLabel.text = [arrayDetailTitle objectAtIndex:1];
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
       return FALSE;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //[songs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *letter = [letters objectAtIndex:indexPath.section];
        NSArray *songsWithLetter = [songs objectForKey:letter];
        NSString *songTitleWithAuthor = songsWithLetter[indexPath.row];
        Song *currentSong = [[Song alloc] init];
        currentSong= [fileManager getSongByTitle:songTitleWithAuthor];
        [[segue destinationViewController] setDetailItem:currentSong];
    }
}

@end
