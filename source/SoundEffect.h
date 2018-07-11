#import <AVFoundation/AVFoundation.h>

@interface SoundEffect : NSObject
{
    AVAudioPlayer *audioPlayer;
}

- (id)initWithSoundNamed:(NSString *)filename;
- (void)play;
- (void)stop;
- (BOOL)isPlaying;

@end