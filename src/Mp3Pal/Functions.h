#ifndef FUNCTIONS_H
#define FUNCTIONS_H

void playStartAnimation()
{
  const int ledDelay = 150;
  digitalWrite(LED_PAUSE_PIN, LOW);
  delay(ledDelay);
  digitalWrite(LED_PREV_PIN, HIGH);
  delay(ledDelay);
  digitalWrite(LED_PAUSE_PIN, HIGH);
  delay(ledDelay);
  digitalWrite(LED_NEXT_PIN, HIGH);
}

void errorMode()
{
  while (1)
  {
    digitalWrite(LED_PAUSE_PIN, HIGH);
    delay(500);
    digitalWrite(LED_PAUSE_PIN, LOW);
    delay(500);
  }
}

bool isPlaying()
{
  return !digitalRead(PIN4);
}

void pauseOrContinue()
{
  if (isPlaying())
  {
    Serial << F("pause.") << endl;
    mp3Player.pause();
    isPause = true;
  }
  else
  {
    Serial << F("continue.") << endl;
    mp3Player.start();
    isPause = false;
  }
}

void prevTrack()
{
  currentTrack = (currentTrack + trackCount - 1) % trackCount;
  mp3Player.playFolderTrack(currentFolder, currentTrack + 1);
  Serial << F("play prev track ") << (1 + currentTrack) << endl;
}

void skipTrack()
{
  currentTrack = (currentTrack + 1) % trackCount;
  mp3Player.playFolderTrack(currentFolder, currentTrack + 1);
  Serial << F("play next track ") << (1 + currentTrack) << endl;
}

void handlePlaylist(int list)
{
  if (isPause)
    return;
  if (list != currentFolder)
  {
    currentTrack = 0;
    currentFolder = list;
    mp3Player.playFolderTrack(currentFolder, 1);
    trackCount = TRACK_COUNT[currentFolder - 1]; //mp3Player.readFileCountsInFolder(list);
    Serial << F("Switched to folder ") << list << F(" containing: ") << trackCount << endl;
  }
  else
  {
    skipTrack();
    return;
  }
}

void scanRfid()
{
  if (!mfrc522.PICC_IsNewCardPresent() || !mfrc522.PICC_ReadCardSerial())
  {
    return;
  }
  String content = "";
  byte letter;
  for (byte i = 0; i < mfrc522.uid.size; i++)
  {
    content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
    content.concat(String(mfrc522.uid.uidByte[i], HEX));
  }
  content.toUpperCase();

  Serial << F("Read UID tag :") << content << endl;
  int tagSize = sizeof(uidTags) / sizeof(uidTags[0]);
  for (int i = 0; i < tagSize; i++) {
    if (content.substring(1) == uidTags[i])
    {
      if (currentFolder != uidPlaylists[i])
      {
        handlePlaylist(uidPlaylists[i]);
      }
    }
  }
}

void updateLedState()
{
  if (!isPause)
  {
    digitalWrite(LED_NEXT_PIN, HIGH);
    digitalWrite(LED_PREV_PIN, HIGH);
    digitalWrite(LED_PAUSE_PIN, HIGH);
  }
  else
  {
    digitalWrite(LED_NEXT_PIN, LOW);
    digitalWrite(LED_PREV_PIN, LOW);
    digitalWrite(LED_PAUSE_PIN, HIGH);
  }
}



class Mp3Notify
{
public:
      static void OnError(uint16_t errorCode) {
      // see DfMp3_Error for code meaning
      Serial.println();
      Serial.print("Com Error ");
      Serial.println(errorCode);
    }
    static void PrintlnSourceAction(DfMp3_PlaySources source, const char* action) {
      if (source & DfMp3_PlaySources_Sd) Serial.print("SD Karte ");
      if (source & DfMp3_PlaySources_Usb) Serial.print("USB ");
      if (source & DfMp3_PlaySources_Flash) Serial.print("Flash ");
      Serial.println(action);
    }
    static void OnPlayFinished(DfMp3_PlaySources source, uint16_t track) {
      //      Serial.print("Track beendet");
      //      Serial.println(track);
      //      delay(100);
      skipTrack();
    }
    static void OnPlaySourceOnline(DfMp3_PlaySources source) {
      PrintlnSourceAction(source, "online");
    }
    static void OnPlaySourceInserted(DfMp3_PlaySources source) {
      PrintlnSourceAction(source, "bereit");
    }
    static void OnPlaySourceRemoved(DfMp3_PlaySources source) {
      PrintlnSourceAction(source, "entfernt");
    }
};
 

#endif
