#include "Arduino.h"
#include "SoftwareSerial.h"
#include <DFMiniMp3.h>

#include <math.h>
#include <SPI.h>
#include <MFRC522.h>
#include "Parameters.h"

MFRC522 mfrc522(SS_PIN, RST_PIN); // Create MFRC522 instance.

SoftwareSerial mySoftwareSerial(2, 3);

int16_t currentTrack = -1;
int16_t currentFolder = -1;
int16_t trackCount;

bool isPause = false;
unsigned long nowMs;

class Mp3Notify;

static DFMiniMp3<SoftwareSerial, Mp3Notify> mp3Player(mySoftwareSerial);

#include "Functions.h"
#include "Volume.h"
#include "Keypad.h"

void setup()
{
  pinMode(LED_PAUSE_PIN, OUTPUT);
  digitalWrite(LED_PAUSE_PIN, HIGH);
  pinMode(LED_NEXT_PIN, OUTPUT);
  pinMode(LED_PREV_PIN, OUTPUT);

  pinMode(outPinA0, OUTPUT);
  pinMode(outPinA1, OUTPUT);
  pinMode(outPinS0, OUTPUT);
  pinMode(outPinS1, OUTPUT);
  pinMode(inPinY, INPUT);

  pinMode(PIN_VOLUME, INPUT);
  pinMode(PIN_BUSY, INPUT);

  mySoftwareSerial.begin(9600);
  Serial.begin(115200);
  SPI.begin();
  mfrc522.PCD_Init();
  mp3Player.begin();
/*  if (!mp3Player.begin(mySoftwareSerial))
  {
    Serial << F("Fatal error starting the mp3 player module.") << endl
           << F("Please restart.") << endl;
    errorMode();
  }
*/
  keyReadMs = volumeReadMs = millis();
  mp3Player.setVolume(7);
  volumeReadMs = -VOLUME_CHECK_TIMEOUT;

  Serial << F("MP3Pal online.") << endl;
  playStartAnimation();
}

void loop()
{
  nowMs = millis();
/*  if (mp3Player.available())
  {
    printDetail(mp3Player.readType(), mp3Player.read());
  }*/
  updateVolume();
  handleKeypress();
  scanRfid();
  delay(20);
}

/*
void printDetail(uint8_t type, int value)
{
  switch (type)
  {
  case TimeOut:
    Serial << F("Time Out!") << endl;
    mp3Player.reset();
    break;
  case WrongStack:
    Serial << F("Stack Wrong!") << endl;
    break;
  case DFPlayerCardInserted:
    Serial << F("Card Inserted!") << endl;
    break;
  case DFPlayerCardRemoved:
    Serial << F("Card Removed!") << endl;
    break;
  case DFPlayerCardOnline:
    Serial << F("Card Online!") << endl;
    break;
  case DFPlayerPlayFinished:
    Serial << F("Number:") << currentTrack << F(" Play Finished!");
    skipTrack();
    break;
  case DFPlayerError:
    Serial << F("DFPlayerError:");
    switch (value)
    {
    case Busy:
      Serial << F("Card not found");
      errorMode();
      break;
    case Sleeping:
      Serial << F("Sleeping");
      break;
    case SerialWrongStack:
      Serial << F("Get Wrong Stack");
      break;
    case CheckSumNotMatch:
      Serial << F("Check Sum Not Match");
      break;
    case FileIndexOut:
      Serial << F("File Index Out of Bound");
      break;
    case FileMismatch:
      Serial << F("Cannot Find File");
      break;
    case Advertise:
      Serial << F("In Advertise");
      break;
    default:
      Serial << F("Unknown");
      break;
    }
    Serial << endl;
    break;
  default:
    break;
  }
}
*/
