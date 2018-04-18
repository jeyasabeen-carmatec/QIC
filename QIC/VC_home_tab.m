//
//  VC_home_tab.m
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_home_tab.h"
#import "menu_cell.h"
#import "CFCoverFlowView.h"


@interface VC_home_tab ()<UITableViewDelegate,UITableViewDataSource,CFCoverFlowViewDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    NSMutableArray *arr_images;
    CGRect frameset;
    CFCoverFlowView *coverFlowView1;
    CFCoverFlowView *coverFlowView2;
    CFCoverFlowView *coverFlowView3;
    
}



@end

@implementation VC_home_tab

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self SET_UP_VIEW];
    
   
    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_providers_all addTarget:self action:@selector(providers_action) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_providers_all addTarget:self action:@selector(providers_action) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_news_all addTarget:self action:@selector(news_all_action) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_offers_all addTarget:self action:@selector(offers_all_action) forControlEvents:UIControlEventTouchUpInside];

  

   

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
        ht = 340;
    }
    else if(result.height <= 568)
    {
        ht= 340;
    }
    else
    {
       ht = 400;

    }
   
    frameset.size.height = ht;
    _VW_providers.frame = frameset;
    
    /***************** Height and width Declaration ****************/
    float HT,width,indicaotr_ht;
    
    frameset = _VW_indicagtor_for_cover.frame;
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
    _VW_indicagtor_for_cover.frame =  frameset;
    
    
    [self.Scroll_contents addSubview:_VW_providers];
    
    NSArray *arr_image = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil];
    NSArray *arr_names = [NSArray arrayWithObjects:@"AlSHAMI MEDICAL CENTER",@"AlSHAMI MEDICAL CENTER",@"AlSHAMI MEDICAL CENTER",@"AlSHAMI MEDICAL CENTER",@"AlSHAMI MEDICAL CENTER",@"AlSHAMI MEDICAL CENTER", nil];
    NSArray *arr_sub_names = [NSArray arrayWithObjects:@"4 providers",@"3 providers",@"5 providers",@"2 providers",@"7 providers",@"5 providers", nil];
    
    coverFlowView1 = [[CFCoverFlowView alloc] initWithFrame:self.VW_indicagtor_for_cover.frame];
    coverFlowView1.backgroundColor = [UIColor clearColor];
    coverFlowView1.pageItemCoverWidth = 0.0f;
      coverFlowView1.pageItemWidth = _VW_indicagtor_for_cover.frame.size.width/width;

    coverFlowView1.pageItemHeight = _VW_providers.frame.size.height/HT;

    coverFlowView1.pageItemCornerRadius = 5.0;
    coverFlowView1.delegate = self;
    [coverFlowView1 setPageItemsWithImageNames:arr_image :arr_names :arr_sub_names];
    [self.VW_providers addSubview:coverFlowView1];
    

    
    
    
    /***************** setting of Offers view **********************/
    
    frameset = _VW_offers.frame;
    frameset.origin.y = _VW_providers.frame.origin.y + _VW_providers.frame.size.height +4;
    frameset.size.width = _Scroll_contents.frame.size.width;
     frameset.size.height = ht;
    _VW_offers.frame = frameset;
    
    frameset = _VW_offer_indicator_for_cover.frame;
    frameset.origin.y = _LBL_offer_header_label.frame.origin.y + _LBL_offer_header_label.frame.size.height + 10;
    frameset.size.height = indicaotr_ht;
    _VW_offer_indicator_for_cover.frame =  frameset;
    
    [self.Scroll_contents addSubview:_VW_offers];
    
     coverFlowView2 = [[CFCoverFlowView alloc] initWithFrame:self.VW_offer_indicator_for_cover.frame];
    coverFlowView2.backgroundColor = [UIColor clearColor];
    coverFlowView2.pageItemWidth = _VW_offer_indicator_for_cover.frame.size.width/ width;
    coverFlowView2.pageItemCoverWidth = 0.0f;
    coverFlowView2.pageItemHeight = _VW_offers.frame.size.height/HT;
    coverFlowView2.pageItemCornerRadius = 5.0;
    coverFlowView2.delegate = self;
    
    NSArray *arr_sub_names_offers = [NSArray arrayWithObjects:@"30% Discount",@"20% Discount",@"10% Discount",@"40% Discount",@"50% Discount",@"60% Discount", nil];

   
    [coverFlowView2 setPageItemsWithImageNames:arr_image :arr_names :arr_sub_names_offers];
    [self.VW_offers addSubview:coverFlowView2];
    
    
    /***************** setting of News view **********************/
    
    frameset = _VW_news.frame;
    frameset.origin.y = _VW_offers.frame.origin.y + _VW_offers.frame.size.height+4;
    frameset.size.width = _Scroll_contents.frame.size.width;
    frameset.size.height = ht;
    _VW_news.frame = frameset;
    
    frameset = _VW_news_indicator_for_cover.frame;
    frameset.origin.y = _LBL_news_header_label.frame.origin.y + _LBL_news_header_label.frame.size.height +10;
    frameset.size.height = indicaotr_ht;
    _VW_news_indicator_for_cover.frame =  frameset;

    
    [self.Scroll_contents addSubview:_VW_news];
    
     coverFlowView3 = [[CFCoverFlowView alloc] initWithFrame:self.VW_news_indicator_for_cover.frame];
    coverFlowView3.backgroundColor = [UIColor clearColor];
    coverFlowView3.pageItemWidth = _VW_offer_indicator_for_cover.frame.size.width/ width;
    coverFlowView3.pageItemCoverWidth = 0.0f;
    coverFlowView3.pageItemHeight = _VW_news.frame.size.height/HT;
    coverFlowView3.pageItemCornerRadius = 5.0;
    NSArray *arr_sub_names_news = [NSArray arrayWithObjects:@"1 hour ago",@"2 hour ago",@"3 hour ago",@"4 hour ago",@"5 hour ago",@"6 hour ago", nil];
    [coverFlowView3 setPageItemsWithImageNames:arr_image :arr_names :arr_sub_names_news];
    coverFlowView3.delegate = self;
    
    [self.VW_news addSubview:coverFlowView3];
    
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



    
}

#pragma setting the attributed Text 

-(void)attributed_TEXT
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
    NSString *str_sub_header_name = @"This is showing the top Providers";
    
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
    
    NSString *str_offer_header =@"OFFERS";
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
    NSString *str_news_header =@"NEWS";
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
#pragma View did lay out sub views

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_Scroll_contents layoutIfNeeded];
    
    _Scroll_contents.contentSize= CGSizeMake(_Scroll_contents.frame.size.width, _VW_news.frame.origin.y +  _VW_news.frame.size.height);
 
}

#pragma Table view delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_images.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    menu_cell *cell = (menu_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"menu_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    UIImage *img = [UIImage imageNamed:[arr_images objectAtIndex:indexPath.row]];
    cell.IMG_image.image = img;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
    _LBL_search_place_holder.alpha = 0.0f;
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

    [self.delegate calling_providers_view];
}
-(void)offers_action
{
    [self.delegate calling_offers_view];
}
-(void)news_action
{
    [self.delegate calling_news_view];
}

- (void)coverFlowView:(CFCoverFlowView *)coverFlowView didSelectPageItemAtIndex:(NSInteger)index
{
    if(coverFlowView == coverFlowView1)
    {
         [self.delegate calling_providers_view];
    }
    else if(coverFlowView == coverFlowView2){
        [self.delegate calling_offers_view];
    }
    else{
        [self.delegate calling_news_view];
    }
}

#pragma View all Buttonns actions

-(void)offers_all_action
{
[self.delegate calling_offers_view];
}
-(void)news_all_action
{
   [self.delegate calling_news_view]; 
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
