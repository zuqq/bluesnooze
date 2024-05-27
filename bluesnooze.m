#import <Cocoa/Cocoa.h>
#import <IOBluetooth/IOBluetooth.h>

void IOBluetoothPreferenceSetControllerPowerState(int);

void setBluetooth(BOOL enabled) {
    NSLog(@"Setting bluetooth: %d", enabled);
    IOBluetoothPreferenceSetControllerPowerState(enabled ? 1 : 0);
}

int main() {
    @autoreleasepool {
        NSNotificationCenter *notificationCenter = [[NSWorkspace sharedWorkspace] notificationCenter];
        [notificationCenter addObserverForName:NSWorkspaceWillSleepNotification
                                        object:nil
                                         queue:nil
                                    usingBlock:^(NSNotification *note) {
                                        setBluetooth(NO);
                                    }];
        [notificationCenter addObserverForName:NSWorkspaceWillPowerOffNotification
                                        object:nil
                                         queue:nil
                                    usingBlock:^(NSNotification *note) {
                                        setBluetooth(YES);
                                    }];
        [notificationCenter addObserverForName:NSWorkspaceDidWakeNotification
                                        object:nil
                                         queue:nil
                                    usingBlock:^(NSNotification *note) {
                                        setBluetooth(YES);
                                    }];
        setBluetooth(YES);
        [[NSRunLoop currentRunLoop] run];
    }
    return 0;
}
