#ifndef PARAMETERS_H
#define PARAMETERS_H


#define PIN_BUSY 4

#define LED_NEXT_PIN 6
#define LED_PREV_PIN 8
#define LED_PAUSE_PIN 7

#define SS_PIN 10
#define RST_PIN 9

#define endl F("\n")
template <class T>
inline Stream &operator<<(Stream &stream, T arg)
{
    stream.print(arg);
    return stream;
}

// hack: mp3Player.readFileCountsInFolder always returns - 1 so I hard coded the track counts
const int16_t TRACK_COUNT[] = {4, 4, 4, 5, 5, 5, 5, 5, 9, 3, 4, 5};

// Hard coded UID Tokens
String uidTags[] = {
  "79 E8 87 98",
  "BA 5F 3B 86"
};

const uint8_t uidPlaylists[] = { 10, 11};

#endif
