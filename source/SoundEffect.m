#import "SoundEffect.h"

#define SOUND_EFFECT_SMALL_VALUE (0.000001)

@implementation SoundEffect

- (id)initWithSoundNamed:(NSString *)filename
{
    if ((self = [super init]))
    {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], filename]];
        NSError *error;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        audioPlayer.numberOfLoops = 0;
    }
    return self;
}

- (void)dealloc
{
}

- (void)play
{
	if (audioPlayer == nil)
        return;
    
    //reset
    [audioPlayer stop];
    audioPlayer.currentTime = 0;
    
    [audioPlayer play];
}

- (void)stop
{
	if (audioPlayer == nil)
        return;
    
    //reset
    [audioPlayer stop];
    audioPlayer.currentTime = 0;
}

- (BOOL)isPlaying
{
	if (audioPlayer == nil)
        return NO;
    
    double currentTime = audioPlayer.currentTime;
    if(currentTime > SOUND_EFFECT_SMALL_VALUE)
        return YES;
    else
        return NO;
}

@end
