//
//  ViewController.m
//  keyboad-my
//
//  Created by Primax on 2018/2/22.
//  Copyright © 2018年 Primax. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
        CGFloat currentObjectBootmYPostion;
}

@property (weak, nonatomic) IBOutlet UITextField *txtInput1;
@property (weak, nonatomic) IBOutlet UITextField *txtInput2;
@property (weak, nonatomic) IBOutlet UITextField *txtInput3;

@end

@implementation ViewController

#pragma make Define my function

-(void)CloseKeyboad
{
    for(UIView *view in self.view.subviews)
    {
        if ([view isKindOfClass:[UITextField class]])
        {
            [view resignFirstResponder];
        }
        
    }
}

-(void)keyboardWillShow:(NSNotification*)sender
{
    NSLog(@"keyboard show");
    NSDictionary *userInfo = sender.userInfo;
    if (userInfo)
    {
        //Form Notice center height
        CGFloat keyboardHeight = [userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
        if (keyboardHeight > 0 )
        {
            CGFloat visibableHeight = self.view.frame.size.height - keyboardHeight;
            NSLog(@"鍵盤彈出後的可視高度:%f",self.view.frame.size.height -    keyboardHeight);
            CGFloat diffHeight = currentObjectBootmYPostion - visibableHeight;
            if (diffHeight > 0){
            [UIView animateWithDuration:0.25 animations:^{
                self.view.frame = CGRectMake(0, - (diffHeight+20), self.view.frame.size.width, self.view.frame.size.height);
            }];
            }
        }
    }
}

-(IBAction)FiledTouched :(UITextField*)sender
{
    currentObjectBootmYPostion = sender.frame.origin.y + sender.frame.size.height;
    NSLog(@"Y bottom postion:%f",currentObjectBootmYPostion);
}


-(void)keyboardWillHide:(NSNotification*)sender
{
  
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"TEST Alert" message:@"No" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Sure" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
 
    NSLog(@"keybaord out");
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0,  0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    
}




    


- (void)viewDidLoad {
    [super viewDidLoad];

    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CloseKeyboad)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    currentObjectBootmYPostion = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
