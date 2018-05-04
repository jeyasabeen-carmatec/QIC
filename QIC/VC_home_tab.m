//
//  VC_home_tab.m
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_home_tab.h"
#import "menu_cell.h"
#import "home_cell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "APIHelper.h"


@interface VC_home_tab ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    NSArray *arr_images;
    CGRect frameset;
    NSIndexPath *INDX_selected;
    NSIndexPath *INDX_offers;
    NSIndexPath *INDX_news;
    NSDictionary *JSON_response_dic;
}



@end

@implementation VC_home_tab

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self SET_UP_VIEW];

    [APIHelper start_animation:self];
    [self performSelector:@selector(Home_page_API_call) withObject:nil afterDelay:0.01];

    _Scroll_contents.delegate = self;
    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_providers_all addTarget:self action:@selector(providers_action) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_news_all addTarget:self action:@selector(news_all_action) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_offers_all addTarget:self action:@selector(offers_all_action) forControlEvents:UIControlEventTouchUpInside];

    @try
    {
    [self.collection_providers registerNib:[UINib nibWithNibName:@"home_cell" bundle:nil]  forCellWithReuseIdentifier:@"home_cell_providers"];
     [self.collection_offers registerNib:[UINib nibWithNibName:@"home_cell" bundle:nil]  forCellWithReuseIdentifier:@"home_cell_offers"];
     [self.collection_news registerNib:[UINib nibWithNibName:@"home_cell" bundle:nil]  forCellWithReuseIdentifier:@"home_cell_news"];
    }
    @catch(NSException *exception)
    {
        
    }
    
    [_BTN_provide_left addTarget:self action:@selector(BTN_left_action) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_provide_right addTarget:self action:@selector(BTN_right_action) forControlEvents:UIControlEventTouchUpInside];
    
    [_BTN_offers_left addTarget:self action:@selector(BTN_offers_left_action) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_offers_right addTarget:self action:@selector(BTN_offers_right_action) forControlEvents:UIControlEventTouchUpInside];
    
    [_BTN_news_left addTarget:self action:@selector(BTN_news_left_action) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_news_right addTarget:self action:@selector(BTN_news_right_action) forControlEvents:UIControlEventTouchUpInside];
    
    _collection_providers.layer.cornerRadius = 5.0f;
    _collection_providers.layer.masksToBounds = YES;
    
    _collection_offers.layer.cornerRadius = 5.0f;
    _collection_offers.layer.masksToBounds = YES;

    [self.BTN_favourite setTitle:[APIHelper set_count:[[NSUserDefaults standardUserDefaults] valueForKey:@"wish_count"]] forState:UIControlStateNormal];


   

}
#pragma set UP View for the list of VIews

-(void)SET_UP_VIEW
{
    
    /***************** setting of Providers view **********************/
    
    CGSize result = [[UIScreen mainScreen] bounds].size;

    frameset = _VW_providers.frame;
    frameset.size.width = _Scroll_contents.frame.size.width;
    float ht;
    if(result.height <= 480)
    {
        ht = 320;
    }
    else if(result.height <= 568)
    {
        ht= 320;
    }
    else
    {
       ht = 400;

    }
   
    frameset.size.height = ht;
    _VW_providers.frame = frameset;
    
    /***************** Height and width Declaration ****************/
    float HT,width,indicaotr_ht;
    
    frameset = _collection_providers.frame;
    frameset.origin.y = _LBL_provider_header_label.frame.origin.y + _LBL_provider_header_label.frame.size.height + 10 ;
   
    if(result.height <= 480)
    {
       indicaotr_ht  = 203;
       HT = 1.4;
       width = 1.7;
    }
    else if(result.height <= 568)
    {
        indicaotr_ht = 203;
        HT = 1.5;
        width = 1.7;

        
    }
    else
    {
        indicaotr_ht = 290;
        HT = 1.6;
        width = 1.7;
        
    }
    
    
    frameset.size.height = indicaotr_ht;
    _collection_providers.frame =  frameset;
    
    
    [self.Scroll_contents addSubview:_VW_providers];
    
    
    /***************** setting of Offers view **********************/
    
    frameset = _VW_offers.frame;
    frameset.origin.y = _VW_providers.frame.origin.y + _VW_providers.frame.size.height +4;
    frameset.size.width = _Scroll_contents.frame.size.width;
     frameset.size.height = ht;
    _VW_offers.frame = frameset;
    
    frameset = _collection_offers.frame;
    frameset.origin.y = _LBL_offer_header_label.frame.origin.y + _LBL_offer_header_label.frame.size.height + 10;
    frameset.size.height = indicaotr_ht;
    _collection_offers.frame =  frameset;
    
    [self.Scroll_contents addSubview:_VW_offers];
    
    
    /***************** setting of News view **********************/
    
    frameset = _VW_news.frame;
    frameset.origin.y = _VW_offers.frame.origin.y + _VW_offers.frame.size.height+4;
    frameset.size.width = _Scroll_contents.frame.size.width;
    frameset.size.height = ht;
    _VW_news.frame = frameset;
    
    frameset = _collection_news.frame;
    frameset.origin.y = _LBL_news_header_label.frame.origin.y + _LBL_news_header_label.frame.size.height +10;
    frameset.size.height = indicaotr_ht;
    _collection_news.frame =  frameset;

    
    [self.Scroll_contents addSubview:_VW_news];
    
    
    frameset = _Scroll_contents.frame;
   // frameset.size.height = _VW_news.frame.origin.y + _VW_news.frame.size.height-100;
    _Scroll_contents.frame = frameset;
    
    /******************* Provider image View Gesture adding *************************/
    
    _IMG_providers .userInteractionEnabled = YES;
    
    UITapGestureRecognizer *providers = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(providers_action)];
    
    providers.numberOfTapsRequired = 1;
    
    [providers setDelegate:self];
    
    [_IMG_providers addGestureRecognizer:providers];
    
    
    /******************* offers image View Gesture adding *************************/
    
    _IMG_offers .userInteractionEnabled = YES;
    
    UITapGestureRecognizer *offers = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(offers_action)];
    
    offers.numberOfTapsRequired = 1;
    
    [offers setDelegate:self];
    
    [_IMG_offers addGestureRecognizer:offers];
    
    /******************* news image View Gesture adding *************************/
    
    _IMG_News .userInteractionEnabled = YES;
    
    UITapGestureRecognizer *news = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(news_action)];
    
    news.numberOfTapsRequired = 1;
    
    [news setDelegate:self];
    
    [_IMG_News addGestureRecognizer:news];
    
    [self attributed_TEXT];
    
    [self ARROWS_BTN_FRAME];



    
}

#pragma Setting the frames for button arrows

-(void)ARROWS_BTN_FRAME
{
    CGRect framesets = _BTN_provide_left.frame;
    framesets.origin.y = _collection_providers.frame.origin.y+_collection_providers.frame.size.height / 3;
    _BTN_provide_left.frame = framesets;
    
    framesets = _BTN_provide_right.frame;
    framesets.origin.y = _collection_providers.frame.origin.y+_collection_providers.frame.size.height / 3;
    _BTN_provide_right.frame = framesets;
    
    framesets = _BTN_offers_left.frame;
    framesets.origin.y = _collection_offers.frame.origin.y+_collection_offers.frame.size.height /3;
    _BTN_offers_left.frame = framesets;
    
    framesets = _BTN_offers_right.frame;
    framesets.origin.y = _collection_offers.frame.origin.y+_collection_offers.frame.size.height / 3;
    _BTN_offers_right.frame = framesets;
    
    framesets = _BTN_news_left.frame;
    framesets.origin.y = _collection_news.frame.origin.y+_collection_news.frame.size.height / 3;
    _BTN_news_left.frame = framesets;
    
    framesets = _BTN_news_right.frame;
    framesets.origin.y = _collection_news.frame.origin.y+_collection_news.frame.size.height / 3;
    _BTN_news_right.frame = framesets;
    
}

#pragma setting the attributed Text 

-(void)attributed_TEXT
{
    
    @try
    {
    CGSize result = [[UIScreen mainScreen] bounds].size;
    float ht_header,ht_sub_header;
    if(result.height <= 480)
    {
        ht_header = 14.0;
        ht_sub_header = 12.0;
    }
    else if(result.height <= 568)
    {
        ht_header = 14.0;
        ht_sub_header = 12.0;

    }
    else
    {
        ht_header = 17.0;
        ht_sub_header = 14.0;
        
    }

    
    NSString *str_header_name =@"TOP 5 PROVIDERS";
    NSString *str_sub_header_name = @"This is showing the Top Providers";
    
    NSString *str_providers = [NSString  stringWithFormat:@"%@\n%@",str_header_name,str_sub_header_name];
    
    if ([_LBL_provider_header_label respondsToSelector:@selector(setAttributedText:)])
    {
        
        
        
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName:_LBL_news_header_label.textColor,
                                  NSFontAttributeName: _LBL_news_header_label.font,
                                  };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str_providers attributes:attribs];
     

        
        
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Book" size:ht_sub_header],NSForegroundColorAttributeName:[UIColor blackColor],}range:[str_providers rangeOfString:str_sub_header_name] ];
        
        
        _LBL_provider_header_label.attributedText = attributedText;
    }
    else{
        _LBL_provider_header_label.text = str_providers;
    }
    
    NSString *str_offer_header =@"BEST COVERAGE";
    NSString *str_offer_sub_header_name = @"This is showing the Offers";
    
    NSString *str_offers = [NSString  stringWithFormat:@"%@\n%@",str_offer_header,str_offer_sub_header_name];
    
    if ([_LBL_offer_header_label respondsToSelector:@selector(setAttributedText:)])
    {
        
        
        
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName:_LBL_news_header_label.textColor,
                                  NSFontAttributeName: _LBL_news_header_label.font,
                                  };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str_offers attributes:attribs];
        
        
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Book" size:ht_sub_header],NSForegroundColorAttributeName:[UIColor blackColor],}range:[str_offers rangeOfString:str_offer_sub_header_name] ];
        
        
        _LBL_offer_header_label.attributedText = attributedText;
    }
    else{
        _LBL_offer_header_label.text = str_offers;
    }
    NSString *str_news_header =@"LATEST NEWS";
    NSString *str_news_sub_header_name = @"This is showing the News";
    
    NSString *str_news = [NSString  stringWithFormat:@"%@\n%@",str_news_header,str_news_sub_header_name];
    
    if ([_LBL_news_header_label respondsToSelector:@selector(setAttributedText:)])
    {
        
        
        
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName:_LBL_news_header_label.textColor,
                                  NSFontAttributeName: _LBL_news_header_label.font,
                                  };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str_news attributes:attribs];
        
       
        
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Book" size:ht_sub_header],NSForegroundColorAttributeName:[UIColor blackColor],}range:[str_news rangeOfString:str_news_sub_header_name] ];
        
        
        _LBL_news_header_label.attributedText = attributedText;
    }
    else{
        _LBL_news_header_label.text = str_news;
    }
    }
    @catch(NSException *exception)
    {
        
    }
}
#pragma View did lay out sub views

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_Scroll_contents layoutIfNeeded];
    
    _Scroll_contents.contentSize= CGSizeMake(_Scroll_contents.frame.size.width, _VW_news.frame.origin.y +  _VW_news.frame.size.height);
 
}


#pragma favourites_action
-(void)favourites_ACTION
{
    [self.delegate favourites_ACTION];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Textfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    _LBL_search_place_holder.alpha = 0.0f;
    [self.delegate  search_VIEW_calling];
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

#pragma Images  carousel Action

-(void)providers_action
{
    
    [self.delegate calling_category_view_all];
    
}
-(void)offers_action
{
    
    [self.delegate calling_offers_view];
    
}
-(void)news_action
{
    
    [self.delegate calling_news_view:@""];
    
}


#pragma View all Buttonns actions

-(void)offers_all_action
{
[self.delegate calling_offers_view];
}
-(void)news_all_action
{
    [self.delegate calling_news_view:@""];
}
#pragma collection view delegates

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    @try
    {
    if(collectionView == _collection_providers)
    {
        NSInteger count = 0;
        if([[JSON_response_dic valueForKey:@"provider_list"] isKindOfClass:[NSArray class]])
        {
            count = [[JSON_response_dic valueForKey:@"provider_list"] count];
        }
        else{
            count = 0;
        }
        return count;
    }
   else if(collectionView == _collection_offers)
    {
        NSInteger count = 0;
        if([[JSON_response_dic valueForKey:@"offers_list"] isKindOfClass:[NSArray class]])
        {
            count = [[JSON_response_dic valueForKey:@"offers_list"] count];
        }
        else{
            count = 0;
        }
        return count;
    }
   else{
       NSInteger count = 0;
       if([[JSON_response_dic valueForKey:@"news_list"] isKindOfClass:[NSArray class]])
       {
           count = [[JSON_response_dic valueForKey:@"news_list"] count];
       }
       else{
           count = 0;
       }
       return count;

   }
    }
    @catch(NSException *exception)
    {
        
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    
 /********************** collectionv view Providers *************************/
if (collectionView == _collection_providers)
{
     home_cell *img_cell = (home_cell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"home_cell_providers" forIndexPath:indexPath];
    
    @try
    {
    NSString *str_IMG_URL = [NSString stringWithFormat:@"%@",[[[JSON_response_dic valueForKey:@"provider_list"] objectAtIndex:indexPath.row] valueForKey:@"logo_url"]];
        str_IMG_URL = [str_IMG_URL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [img_cell.IMG_name sd_setImageWithURL:[NSURL URLWithString:str_IMG_URL]
                 placeholderImage:[UIImage imageNamed:@"Image-placeholder-2.png"]];
    
    NSString *str_name = [NSString stringWithFormat:@"%@",[[[JSON_response_dic valueForKey:@"provider_list"] objectAtIndex:indexPath.row] valueForKey:@"provider_name"]];
    
    str_name = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:str_name]];
    img_cell.LBL_name.text =  str_name;
        img_cell.IMG_name.layer.cornerRadius = 20.0;
        img_cell.IMG_name.layer.masksToBounds = YES;
        img_cell.LBL_name.layer.cornerRadius = 10.0;
        img_cell.LBL_name.layer.masksToBounds = YES;
       
    }
    @catch(NSException *exception)
    {
        NSLog(@"Exception from Providers:%@",exception);
    }

    return img_cell;
}
    /********************** collectionv view Offers *************************/

else if(collectionView == _collection_offers)
{
    
    @try
    {
    home_cell *img_cell = (home_cell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"home_cell_offers" forIndexPath:indexPath];
    img_cell.IMG_name.layer.cornerRadius = 20.0;
    img_cell.IMG_name.layer.masksToBounds = YES;
        img_cell.LBL_name.layer.cornerRadius = 10.0;
        img_cell.LBL_name.layer.masksToBounds = YES;

        NSString *str_IMG_URL = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[[[JSON_response_dic valueForKey:@"offers_list"] objectAtIndex:indexPath.row] valueForKey:@"image"]];
        str_IMG_URL = [str_IMG_URL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];


        [img_cell.IMG_name sd_setImageWithURL:[NSURL URLWithString:str_IMG_URL]
                         placeholderImage:[UIImage imageNamed:@"Image-placeholder-2.png"]];
        
        NSString *str_offer_name = [NSString stringWithFormat:@"%@",[[[JSON_response_dic valueForKey:@"offers_list"] objectAtIndex:indexPath.row] valueForKey:@"name"]];
    
        NSString *str_dicount_type = [NSString stringWithFormat:@"%@",[[[JSON_response_dic valueForKey:@"offers_list"] objectAtIndex:indexPath.row] valueForKey:@"discount_type"]];
        NSString *str_dicount = [NSString stringWithFormat:@"%@",[[[JSON_response_dic valueForKey:@"offers_list"] objectAtIndex:indexPath.row] valueForKey:@"discount"]];
        
        if([str_dicount_type isEqualToString:@"Percentage"])
        {
            NSString *str = @"%";
            str_dicount = [NSString stringWithFormat:@"%@\nupto %@%@ coverage",str_offer_name,str_dicount,str];
            
            
        }
        else{
            str_dicount = [NSString stringWithFormat:@"%@\nupto %@ coverage",str_offer_name,str_dicount];
;
            
        }
        img_cell.LBL_name.text = str_dicount;

    
      
    return img_cell;
    }
    @catch(NSException *exception)
    {
        NSLog(@"Exceptio from Collection offers:%@",exception);
    }
}
    
    /********************** collectionv view News *************************/

else{
    
    home_cell *img_cell = (home_cell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"home_cell_news" forIndexPath:indexPath];
    
    
    @try
    {

    NSString *str_IMG_URL = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[[[JSON_response_dic valueForKey:@"news_list"] objectAtIndex:indexPath.row] valueForKey:@"image"]];
    str_IMG_URL = [str_IMG_URL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    [img_cell.IMG_name sd_setImageWithURL:[NSURL URLWithString:str_IMG_URL]
                         placeholderImage:[UIImage imageNamed:@"Image-placeholder-2.png"]];
    NSString *str_time = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[[JSON_response_dic valueForKey:@"news_list"] objectAtIndex:indexPath.row] valueForKey:@"title"]]];
    img_cell.LBL_name.text =  [NSString stringWithFormat:@"%@",str_time];
    
    img_cell.IMG_name.layer.cornerRadius = 20.0;
    img_cell.IMG_name.layer.masksToBounds = YES;
    img_cell.LBL_name.layer.cornerRadius = 10.0;
    img_cell.LBL_name.layer.masksToBounds = YES;
    
    }
    @catch(NSException *exception)
    {
        NSLog(@"Exceptio from Collection News:%@",exception);
    }

    return img_cell;
}
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collection_providers) {
        return CGSizeMake(_collection_providers.frame.size.width ,_collection_providers.frame.size.height);
        
    }
    if (collectionView == _collection_offers) {
        return CGSizeMake(_collection_offers.frame.size.width ,_collection_offers.frame.size.height);
        
    }
    else{
       
            return CGSizeMake(_collection_news.frame.size.width ,_collection_news.frame.size.height);
            
        

    }

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    @try
    {
    if(collectionView == _collection_providers)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[[[JSON_response_dic valueForKey:@"provider_list"] objectAtIndex:indexPath.row] valueForKey:@"id"] forKey:@"category_ID"];
        [[NSUserDefaults standardUserDefaults] setObject:[[[JSON_response_dic valueForKey:@"provider_list"] objectAtIndex:indexPath.row] valueForKey:@"provider_id"] forKey:@"provider_ID"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [self.delegate calling_providers_view];
    }
    else if(collectionView == _collection_offers){
        
        [[NSUserDefaults standardUserDefaults] setObject:[[[JSON_response_dic valueForKey:@"offers_list"] objectAtIndex:indexPath.row] valueForKey:@"id"] forKey:@"service_ID"];
        
        [self.delegate consultation_offers:@""];
    }
    else{
        NSString *str_URL = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[[[JSON_response_dic valueForKey:@"news_list"] objectAtIndex:indexPath.row] valueForKey:@"url_key"]];
        [[NSUserDefaults standardUserDefaults]  setValue:str_URL forKey:@"Static_URL"];
        
        [[NSUserDefaults standardUserDefaults]  setValue:@"TOP NEWS" forKey:@"header_val"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [self.delegate calling_news_view:@"news_detail"];
    }
    }
    @catch(NSException *exception)
    {
        
    }

}
#pragma Scrollview handling

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    @try
    {
        NSString *cellIdentifier;
        for (UICollectionViewCell *cell in [scrollView subviews])
        {
            cellIdentifier = [cell reuseIdentifier];
            break;
        }
        if ([cellIdentifier isEqualToString:@"home_cell_providers"])
        {
            float pageWidth = _collection_providers.frame.size.width; // width + space
            
            float currentOffset = _collection_providers.contentOffset.x;
            float targetOffset = targetContentOffset->x;
            float newTargetOffset = 1;
            
            if (targetOffset > currentOffset)
                newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
            else
                newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
            
            if (newTargetOffset < 0)
                newTargetOffset = 0;
            else if (newTargetOffset > _collection_providers.contentSize.width)
                newTargetOffset = _collection_providers.contentSize.width;
            
            targetContentOffset->x = currentOffset;
            [_collection_providers setContentOffset:CGPointMake(newTargetOffset  , _collection_providers.contentOffset.y) animated:YES];
            
            
        }
       else if ([cellIdentifier isEqualToString:@"home_cell_offers"])
        {
            float pageWidth = _collection_offers.frame.size.width; // width + space
            
            float currentOffset = _collection_offers.contentOffset.x;
            float targetOffset = targetContentOffset->x;
            float newTargetOffset = 1;
            
            if (targetOffset > currentOffset)
                newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
            else
                newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
            
            if (newTargetOffset < 0)
                newTargetOffset = 0;
            else if (newTargetOffset > _collection_offers.contentSize.width)
                newTargetOffset = _collection_offers.contentSize.width;
            
            targetContentOffset->x = currentOffset;
            [_collection_offers setContentOffset:CGPointMake(newTargetOffset  , _collection_offers.contentOffset.y) animated:YES];
            
            
        }
        else if ([cellIdentifier isEqualToString:@"home_cell_news"])
        {
            float pageWidth = _collection_news.frame.size.width; // width + space
            
            float currentOffset = _collection_news.contentOffset.x;
            float targetOffset = targetContentOffset->x;
            float newTargetOffset = 1;
            
            if (targetOffset > currentOffset)
                newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
            else
                newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
            
            if (newTargetOffset < 0)
                newTargetOffset = 0;
            else if (newTargetOffset > _collection_news.contentSize.width)
                newTargetOffset = _collection_news.contentSize.width;
            
            targetContentOffset->x = currentOffset;
            [_collection_news setContentOffset:CGPointMake(newTargetOffset  , _collection_news.contentOffset.y) animated:YES];
         
            
            
        }


    }
    @catch(NSException *exception)
    {
        
    }
    
}

#pragma Providers left and Right scroll button action

-(void)BTN_right_action
{
    @try
    {
        NSIndexPath *newIndexPath;
        if (!INDX_selected)
        {
            newIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            INDX_selected = newIndexPath;
        }
        
        else if ([[JSON_response_dic valueForKey:@"provider_list"] count]  > INDX_selected.row)
        {
            if ([[JSON_response_dic valueForKey:@"provider_list"] count] == INDX_selected.row + 1) {
                newIndexPath = [NSIndexPath indexPathForRow:[[JSON_response_dic valueForKey:@"provider_list"] count] - 1 inSection:0];
                INDX_selected = newIndexPath;
            }
            else
            {
                newIndexPath = [NSIndexPath indexPathForRow:INDX_selected.row + 1 inSection:0];
                INDX_selected = newIndexPath;
            }
        }
        
        
        if (!newIndexPath) {
            newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            INDX_selected = newIndexPath;
        }
        
        
        [_collection_providers scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:INDX_selected.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    @catch(NSException *exception)
    {
        
    }
}




-(void)BTN_left_action
{
    @try
    {
        NSIndexPath *newIndexPath;
        if (INDX_selected)
        {
            newIndexPath = [NSIndexPath indexPathForRow:INDX_selected.row -1 inSection:0];
            INDX_selected = newIndexPath;
        }
        
        else if ([[JSON_response_dic valueForKey:@"provider_list"] count]  < INDX_selected.row)
        {
            if ([[JSON_response_dic valueForKey:@"provider_list"] count] == INDX_selected.row - 1)
            {
                newIndexPath = [NSIndexPath indexPathForRow:[[JSON_response_dic valueForKey:@"provider_list"] count] + 1 inSection:0];
                INDX_selected = newIndexPath;
            }
            else
            {
                newIndexPath = [NSIndexPath indexPathForRow:INDX_selected.row - 1 inSection:0];
                INDX_selected = newIndexPath;
            }
        }
        if (newIndexPath.row == 1)
        {
            newIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            INDX_selected = newIndexPath;
        }
        if(newIndexPath.row < 1)
        {
            newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            INDX_selected = newIndexPath;
        }
        [_collection_providers scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:INDX_selected.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    
    
    @catch (NSException *exception)
    {
        NSLog(@"exception:%@",exception);
    }
    
}


#pragma Offers left  and Rightscroll button action


-(void)BTN_offers_left_action
{
    @try
    {
        NSIndexPath *newIndexPath;
        if (INDX_offers)
        {
            newIndexPath = [NSIndexPath indexPathForRow:INDX_offers.row -1 inSection:0];
            INDX_offers = newIndexPath;
        }
        
        else if ([[JSON_response_dic valueForKey:@"offers_list"] count]  < INDX_offers.row)
        {
            if ([[JSON_response_dic valueForKey:@"offers_list"] count] == INDX_offers.row - 1)
            {
                newIndexPath = [NSIndexPath indexPathForRow:[[JSON_response_dic valueForKey:@"offers_list"] count] + 1 inSection:0];
                INDX_offers = newIndexPath;
            }
            else
            {
                newIndexPath = [NSIndexPath indexPathForRow:INDX_offers.row - 1 inSection:0];
                INDX_offers = newIndexPath;
            }
        }
        if (newIndexPath.row == 1)
        {
            newIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            INDX_offers = newIndexPath;
        }
        if(newIndexPath.row < 1)
        {
            newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            INDX_offers = newIndexPath;
        }
        [_collection_offers scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:INDX_offers.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    
    
    @catch (NSException *exception)
    {
        NSLog(@"exception:%@",exception);
    }
    
}


-(void)BTN_offers_right_action
{
    @try
    {
        NSIndexPath *newIndexPath;
        if (!INDX_offers)
        {
            newIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            INDX_offers = newIndexPath;
        }
        
        else if ([[JSON_response_dic valueForKey:@"offers_list"] count]  > INDX_offers.row)
        {
            if ([[JSON_response_dic valueForKey:@"offers_list"] count] == INDX_offers.row + 1) {
                newIndexPath = [NSIndexPath indexPathForRow:[[JSON_response_dic valueForKey:@"offers_list"] count] - 1 inSection:0];
                INDX_offers = newIndexPath;
            }
            else
            {
                newIndexPath = [NSIndexPath indexPathForRow:INDX_offers.row + 1 inSection:0];
                INDX_offers = newIndexPath;
            }
        }
        
        
        if (!newIndexPath) {
            newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            INDX_offers = newIndexPath;
        }
        
        
        [_collection_offers scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:INDX_offers.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    @catch(NSException *exception)
    {
        
    }
}

#pragma Offers left  and Rightscroll button action


-(void)BTN_news_left_action
{
    @try
    {
        NSIndexPath *newIndexPath;
        if (INDX_news)
        {
            newIndexPath = [NSIndexPath indexPathForRow:INDX_news.row -1 inSection:0];
            INDX_news = newIndexPath;
        }
        
        else if ([[JSON_response_dic valueForKey:@"news_list"] count]  < INDX_news.row)
        {
            if ([[JSON_response_dic valueForKey:@"news_list"] count] == INDX_news.row - 1)
            {
                newIndexPath = [NSIndexPath indexPathForRow:[[JSON_response_dic valueForKey:@"news_list"] count] + 1 inSection:0];
                INDX_news = newIndexPath;
            }
            else
            {
                newIndexPath = [NSIndexPath indexPathForRow:INDX_news.row - 1 inSection:0];
                INDX_news = newIndexPath;
            }
        }
        if (newIndexPath.row == 1)
        {
            newIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            INDX_news = newIndexPath;
        }
        if(newIndexPath.row < 1)
        {
            newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            INDX_news = newIndexPath;
        }
        [_collection_news scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:INDX_news.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    
    
    @catch (NSException *exception)
    {
        NSLog(@"exception:%@",exception);
    }
    
}


-(void)BTN_news_right_action
{
    @try
    {
        NSIndexPath *newIndexPath;
        if (!INDX_news)
        {
            newIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
            INDX_news = newIndexPath;
        }
        
        else if ([[JSON_response_dic valueForKey:@"news_list"] count]  > INDX_news.row)
        {
            if ([[JSON_response_dic valueForKey:@"news_list"] count] == INDX_news.row + 1) {
                newIndexPath = [NSIndexPath indexPathForRow:[[JSON_response_dic valueForKey:@"news_list"] count] - 1 inSection:0];
                INDX_news = newIndexPath;
            }
            else
            {
                newIndexPath = [NSIndexPath indexPathForRow:INDX_news.row + 1 inSection:0];
                INDX_news = newIndexPath;
            }
        }
        
        
        if (!newIndexPath) {
            newIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            INDX_news = newIndexPath;
        }
        
        
        [_collection_news scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:INDX_news.row inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    @catch(NSException *exception)
    {
        
    }
}

#pragma Home page API calling
-(void)Home_page_API_call
{
    
    @try
    {
    NSHTTPURLResponse *response = nil;
    NSError *error;
    NSString *URL_STR = [NSString stringWithFormat:@"%@home",SERVER_URL];

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
        JSON_response_dic=(NSDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        NSLog(@"%@",JSON_response_dic);
        
        [_collection_offers reloadData];
        [_collection_providers reloadData];
        [_collection_news reloadData];

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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
