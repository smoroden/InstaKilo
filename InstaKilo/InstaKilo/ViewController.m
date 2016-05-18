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
- (IBAction)panning:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.collectionView];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:[self.collectionView indexPathForItemAtPoint:point]];
            break;
        case UIGestureRecognizerStateChanged:
            [self.collectionView updateInteractiveMovementTargetPosition:point];
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
            [self.collectionView endInteractiveMovement];
            break;
        default:
            break;
    }
    
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

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    Photo *temp = self.sortedPhotos[self.keys[sourceIndexPath.section]][sourceIndexPath.row];
    
    //[self.data.photos removeObject:temp];
    
    [self.sortedPhotos[self.keys[sourceIndexPath.section]] removeObject:temp];
    
    NSMutableArray *a = self.sortedPhotos[self.keys[sourceIndexPath.section]];
    [a removeObject:temp];
    [a insertObject:temp atIndex:destinationIndexPath.row];
    //self.sortedPhotos[self.keys[sourceIndexPath.section]]
    
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
