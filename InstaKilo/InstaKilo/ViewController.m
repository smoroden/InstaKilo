//
//  ViewController.m
//  InstaKilo
//
//  Created by Zach Smoroden on 2016-05-18.
//  Copyright © 2016 Zach Smoroden. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) NSMutableArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.data = [@[] mutableCopy];
    
    for (int i = 0; i < 10; i++) {
        [self.data addObject:[UIImage imageNamed:[NSString stringWithFormat:@"img%d", i]]];
    }
}

#pragma uicollectionview data/delegate



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    cell.imageView.image = self.data[indexPath.row];
    
    
    return cell;
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.data.count;
}

@end
