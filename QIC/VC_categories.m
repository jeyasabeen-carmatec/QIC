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
#import "APIHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface VC_categories ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *arr_images;
    NSDictionary *jsonresponse_DIC;
}

@end

@implementation VC_categories

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
       
    
    /************** setting the dlegates ******************/
    
    _collection_categoriesl.delegate = self;
    _collection_categoriesl.dataSource =  self;
    
    /**************** registering the cell *********************/
    [self.collection_categoriesl registerNib:[UINib nibWithNibName:@"categorie_cell" bundle:nil]  forCellWithReuseIdentifier:@"cell"];
   // _collection_categoriesl.backgroundColor = [UIColor redColor];

    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];
    [self.BTN_favourite setTitle:[APIHelper set_count:[[NSUserDefaults standardUserDefaults] valueForKey:@"wish_count"]] forState:UIControlStateNormal];
    [APIHelper start_animation:self];

    [self performSelector:@selector(Categiries_API_CALL) withObject:nil afterDelay:0.01];

}
#pragma collection view delgate methods
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if([[jsonresponse_DIC valueForKey:@"Categories"] isKindOfClass:[NSArray class]])
    {
        count = [[jsonresponse_DIC valueForKey:@"Categories"] count];
    }
    else{
        count = 0;
    }
    return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    categorie_cell *cell = (categorie_cell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    @try
    {
        
    NSString *str_image = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[[[jsonresponse_DIC valueForKey:@"Categories"]objectAtIndex:indexPath.row] valueForKey:@"image"]];
        str_image = [str_image stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [cell.IMG_categories sd_setImageWithURL:[NSURL URLWithString:str_image]
                      placeholderImage:[UIImage imageNamed:@"Image-placeholder-2.png"]];

    NSString *str_name = [NSString stringWithFormat:@"%@",[[[jsonresponse_DIC valueForKey:@"Categories"] objectAtIndex:indexPath.row] valueForKey:@"description"]];
    str_name = [APIHelper convert_NUll:str_name];
    
    [cell.BTN_categories setTitle:str_name forState:UIControlStateNormal];
    cell.BTN_categories.layer.cornerRadius = 2.0f;
    }
    @catch(NSException *exception)
    {
        
    }
    
    return cell;
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_collection_categoriesl.bounds.size.width/2.02 ,200);
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
    if([[jsonresponse_DIC valueForKey:@"Categories"] isKindOfClass:[NSArray class]])
    {
    [[NSUserDefaults standardUserDefaults] setValue:[[[jsonresponse_DIC valueForKey:@"Categories"] objectAtIndex:indexPath.row] valueForKey:@"code"] forKey:@"catgory_id"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
    [self.delegate sub_categories_action:@"subcategories"];
    }
    
    
 
    
}


#pragma favourites_action
-(void)favourites_ACTION
{
    [self.delegate favourites_ACTION];
}
#pragma Textfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _LBL_search_place_holder.alpha = 0.0f;
    [[NSUserDefaults standardUserDefaults] setValue:@"provider_search" forKey:@"tab_param"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.delegate search_VIEW_calling];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:@""])
    {
        _LBL_search_place_holder.alpha = 1.0f;
    }
    else{
        _LBL_search_place_holder.alpha = 0.0f;
    }
}
#pragma Categories API call

-(void)Categiries_API_CALL
{
    
    @try
    {
        NSHTTPURLResponse *response = nil;
        NSError *error;
        NSString *URL_STR = [NSString stringWithFormat:@"%@getCategoryList",SERVER_URL];
        
        NSURL *urlProducts=[NSURL URLWithString:URL_STR];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:urlProducts];
        [request setHTTPMethod:@"GET"];
        [request setHTTPShouldHandleCookies:NO];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        [APIHelper stop_activity_animation:self];
        
        if(aData)
        {
            jsonresponse_DIC =(NSDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
            NSLog(@"%@",jsonresponse_DIC);
            [_collection_categoriesl reloadData];
            
            
        }
        else
        {
            NSDictionary *dictin = [[NSDictionary alloc]initWithObjectsAndKeys:@"Nodata",@"error", nil];
            NSLog(@"%@",dictin);
        }
    }
    @catch(NSException *Exception)
    {
        
    }
    
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
