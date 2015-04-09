//
//  Constants.m
//  TodayLight
//
//  Created by Eric Pelz on 4/8/15.
//  Copyright (c) 2015 Theo Spears. All rights reserved.
//

typedef enum {
    COMMAND_ALL_OFF = 0x41,
    COMMAND_GROUP_1_OFF = 0x46,
    COMMAND_GROUP_2_OFF = 0x48,
    COMMAND_GROUP_3_OFF = 0x4A,
    COMMAND_GROUP_4_OFF = 0x4C,

    COMMAND_ALL_ON = 0x42,
    COMMAND_GROUP_1_ON = 0x45,
    COMMAND_GROUP_2_ON = 0x47,
    COMMAND_GROUP_3_ON = 0x49,
    COMMAND_GROUP_4_ON = 0x4B,

    COMMAND_ALL_WHITE = 0xC2,
    COMMAND_GROUP_1_WHITE = 0xC5,
    COMMAND_GROUP_2_WHITE = 0xC7,
    COMMAND_GROUP_3_WHITE = 0xC9,
    COMMAND_GROUP_4_WHITE = 0xCB,

    COMMAND_DISCO = 0x4D,
    COMMAND_DISCO_FASTER = 0x44,
    COMMAND_DISCO_SLOWER = 0x43,

    COMMAND_COLOR = 0x40, // Part of 2-byte command
    COMMAND_MAX_COLOR = 0xFF,

    COMMAND_BRIGHTNESS = 0x4E, // Part of 2-byte command
    COMMAND_MAX_BRIGHTNESS = 0x3B
} COMMANDS;