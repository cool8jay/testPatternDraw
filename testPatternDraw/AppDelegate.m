#import "AppDelegate.h"
#import "MyView.h"

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;

@property (strong) IBOutlet MyView *myView;
@property (strong) IBOutlet NSSlider *slider;
@property (strong) IBOutlet NSTextField *textField;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _textField.stringValue = [NSString stringWithFormat:@"%d", _slider.intValue];
    _myView.size = _slider.intValue;
}

- (IBAction)sliderAction:(id)sender{
    _textField.stringValue = [NSString stringWithFormat:@"%d", _slider.intValue];
    _myView.size = _slider.intValue;
}

@end
