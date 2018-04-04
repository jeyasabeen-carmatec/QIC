//
//  VC_categories.m
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_categories.h"
#import "categorie_cell.h"
#import "VC_sub_categories.h"

@interface VC_categories ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *arr_images;
}

@end

@implementation VC_categories

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    arr_images = [NSArray arrayWithObjects:@"Banner-A.jpg",@"Banner-B.jpg",@"Banner-C.jpg", nil];

    
    /************** setting the dlegates ******************/
    
    _collection_categoriesl.delegate = self;
    _collection_categoriesl.dataSource =  self;
    
    /**************** registering the cell *********************/
    [self.collection_categoriesl registerNib:[UINib nibWithNibName:@"categorie_cell" bundle:nil]  forCellWithReuseIdentifier:@"cell"];
   // _collection_categoriesl.backgroundColor = [UIColor redColor];

    // Do any additional setup after loading the view.
}
#pragma collection view delgate methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arr_images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    categorie_cell *cell = (categorie_cell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.IMG_categories.image = [UIImage imageNamed:[arr_images objectAtIndex:indexPath.row]];
    cell.BTN_categories.layer.cornerRadius = 2.0f;
    
    return cell;
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_collection_categoriesl.bounds.size.width/2.02 ,217);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"display the cell");
    [self.delegate sub_categories_action:@"subcategories"];


    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
