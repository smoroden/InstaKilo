//
//  ViewController.m
//  InstaKilo
//
//  Created by Zach Smoroden on 2016-05-18.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import "Photos.h"
#import "SubjectHeaderView.h"
#import "Photo.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) Photos *data;

@property (nonatomic) BOOL sortedLocation;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortValue;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSDictionary *sortedPhotos;
@property (nonatomic) NSArray *keys;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.data = [Photos premadePhotoSet];
    
    NSLog(@"%@", self.data.byLocation);
    
    self.sortedLocation = self.sortValue.selectedSegmentIndex;
    
    [self refreshData];

}
- (IBAction)sortChanged:(UISegmentedControl *)sender {
    self.sortedLocation = sender.selectedSegmentIndex;
    
    [self refreshData];
}

-(void)refreshData {
    
    if(self.sortedLocation) {
        self.sortedPhotos = [self.data byLocation];
    } else {
        self.sortedPhotos = [self.data bySubject];
    }

    self.keys = self.sortedPhotos.allKeys;
    
    [self.collectionView reloadData];
}

- (IBAction)doubleTap:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.collectionView];
    
    //NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    [self removeCellAtIndexPath:[self.collectionView indexPathForItemAtPoint:point]];
    
}
#pragma uicollectionview data/delegate

-(void)removeCellAtIndexPath:(NSIndexPath *)indexPath {
    Photo *photo = self.sortedPhotos[self.keys[indexPath.section]][indexPath.row];
    
    //NSLog(@"Before delete: %@", a);
    [self.data.photos removeObject:photo];
 //   [self.sortedPhotos[self.keys[indexPath.section]] removeObjectAtIndex:indexPath.row];
    //NSLog(@"after delete: %@", a);
    [self refreshData];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    //cell.imageView.image = self.data.photoSets[indexPath.section][indexPath.row];
    
    
    Photo *photo = self.sortedPhotos[self.keys[indexPath.section]][indexPath.row];
    
    cell.imageView.image = photo.image;
    
    return cell;
    
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SubjectHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"subjectHeader" forIndexPath:indexPath];
    
    header.subjectLabel.text = self.keys[indexPath.section];
    
    return header;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return self.keys.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *photos = self.sortedPhotos[self.keys[section]];
    
    return photos.count;
}

@end
