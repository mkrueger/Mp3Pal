#ifndef VOLUME_H
#define VOLUME_H

#define VOLUME_CHECK_TIMEOUT 500
#define PIN_VOLUME A7

const int minVolume = 1;
// 30 would be the max, but 24 is loud enough with my speakers
const int maxVolume = 24;

uint16_t volumeReadMs = -VOLUME_CHECK_TIMEOUT;

int curVolume;

void updateVolume()
{
  int sensorValue = analogRead(PIN_VOLUME);
  static int smoothValue = sensorValue;
  for (int i = 0; i < 10; i++)
  {
    smoothValue = 0.6 * smoothValue + 0.4 * sensorValue;
  }

  if (nowMs < volumeReadMs + VOLUME_CHECK_TIMEOUT)
  {
    return;
  }

  int vol = map(smoothValue, 0, 1023, minVolume, maxVolume);
  
  volumeReadMs = nowMs;
  if (curVolume != vol) {
    Serial << F("Set volume to ") << vol << endl;
    mp3Player.volume(vol);
    curVolume = vol;
  }
}

#endif
