#ifndef KEYPAD_H
#define KEYPAD_H

#define outPinA0 A1
#define outPinA1 A2

#define outPinS0 A3
#define outPinS1 A4

#define inPinY A0


#define KEY_CHECK_TIMEOUT 50

#define NO_KEY -1

#define KEYCODE_NEXT 12
#define KEYCODE_PREV 13
#define KEYCODE_PAUSE 14

#define KEYCODE_PLAYLIST_1 1
#define KEYCODE_PLAYLIST_2 2
#define KEYCODE_PLAYLIST_3 0
#define KEYCODE_PLAYLIST_4 9
#define KEYCODE_PLAYLIST_5 10
#define KEYCODE_PLAYLIST_6 8
#define KEYCODE_PLAYLIST_7 5
#define KEYCODE_PLAYLIST_8 6
#define KEYCODE_PLAYLIST_9 4

#define KEY_PREV 9
#define KEY_PAUSE 10
#define KEY_NEXT 11

int8_t keyPressed = NO_KEY;
uint16_t keyReadMs;
int oldKeyCode = -1;

void handleKeypress()
{
  if (nowMs < keyReadMs + KEY_CHECK_TIMEOUT)
    return;
  keyReadMs = nowMs;
  int out = -1;

  for (int i = 0; i < 16; i++)
  {
    digitalWrite(outPinA1, bitRead(i, 0) ? HIGH : LOW);
    digitalWrite(outPinA0, bitRead(i, 1) ? HIGH : LOW);
    digitalWrite(outPinS1, bitRead(i, 2) ? HIGH : LOW);
    digitalWrite(outPinS0, bitRead(i, 3) ? HIGH : LOW);

    int yValue = digitalRead(inPinY);
    if (yValue == HIGH)
    {
      out = i;
      break;
    }
  }
  if (oldKeyCode == out) {
    return;
  }
  oldKeyCode = out;

  if (out == -1)
  {
    if (keyPressed == NO_KEY)
      return;
    if (0 <= keyPressed && keyPressed < 9)
    {
      int folder = 1 + keyPressed;
      handlePlaylist(folder);
    }
    else if (keyPressed == KEY_PREV)
    {
      if (!isPause)
        prevTrack();
    }
    else if (keyPressed == KEY_PAUSE)
    {
      pauseOrContinue();
    }
    else if (keyPressed == KEY_NEXT)
    {
      if (!isPause)
         skipTrack();
    }
    delay(10);
    //Serial << F("key up ") << keyPressed << endl;
    keyPressed = NO_KEY;
    updateLedState();
    return; // no key was pressed
  }
  if (keyPressed != NO_KEY)
    return;
  switch (out)
  {
  case KEYCODE_NEXT:
    if (!isPause) {
      digitalWrite(LED_NEXT_PIN, HIGH);
      digitalWrite(LED_PREV_PIN, LOW);
      digitalWrite(LED_PAUSE_PIN, LOW);
    }
    keyPressed = KEY_NEXT;
    break;

  case KEYCODE_PREV:
    if (!isPause) {
      digitalWrite(LED_NEXT_PIN, LOW);
      digitalWrite(LED_PREV_PIN, HIGH);
      digitalWrite(LED_PAUSE_PIN, LOW);
    }
    keyPressed = KEY_PREV;
    break;

  case KEYCODE_PAUSE:
    digitalWrite(LED_NEXT_PIN, LOW);
    digitalWrite(LED_PREV_PIN, LOW);
    digitalWrite(LED_PAUSE_PIN, HIGH);
    keyPressed = KEY_PAUSE;
    break;

  case KEYCODE_PLAYLIST_1:
    keyPressed = 0;
    break;
  case KEYCODE_PLAYLIST_2:
    keyPressed = 1;
    break;
  case KEYCODE_PLAYLIST_3:
    keyPressed = 2;
    break;
  case KEYCODE_PLAYLIST_4:
    keyPressed = 3;
    break;
  case KEYCODE_PLAYLIST_5:
    keyPressed = 4;
    break;
  case KEYCODE_PLAYLIST_6:
    keyPressed = 5;
    break;
  case KEYCODE_PLAYLIST_7:
    keyPressed = 6;
    break;
  case KEYCODE_PLAYLIST_8:
    keyPressed = 7;
    break;
  case KEYCODE_PLAYLIST_9:
    keyPressed = 8;
    break;

  default:
    keyPressed = NO_KEY;
    break;
  }
  if (isPause && keyPressed != KEY_PAUSE)
  {
    keyPressed = NO_KEY;
  }
  Serial << F("key pressed with code: ") << out << F(" key ") << keyPressed << endl;
}
#endif
