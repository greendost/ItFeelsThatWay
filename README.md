ItFeelsThatWay
==============

Chuck final song

For Coursera course "Intro to Programming for Musicians and Digital
Artists".  Audio samples + code.

To run the song, please install the Chuck miniAudicle application,
then open initialize.ck, start the virtual machine, and hit play.

The song is about a minute, and has a few random elements, so the 
melody can vary a slight bit with each play.

As for the code, this may be a good framework for quickly laying 
down loops in your own compositions.

Structure
  Initialize.ck - loads classes and calls score.  Start here.
  
  Score.ck - load instruments into their own "shred", and after 
  60 seconds (chucking 60 seconds to now), unload them.  
  Also added a few lines to create a wav file.
  
  Song.ck - defines the song - various song parameters and loops 
  represented by arrays of arrays of...
  
  SongMgr.ck - used by instruments to get access to song parameters and 
  loops in the song class.  A controller of sorts.
  
  BPM.ck - provided by Dr. Kapur, tweaked a little, used for setting 
  tempo
  
  Instruments
  Drums.ck
  Rhodey.ck
  sqr2.ck - square wave "power chords"
  Trimel.ck - triangular oscillator for melody
  
  
