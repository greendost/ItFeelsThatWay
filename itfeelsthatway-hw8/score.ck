// score.ck
// ================================================================= //
// File: score.ck
// Date: 12/9/2013 start
// Desc: Assignment 8 - Final - all concepts from weeks 1 - 7.
//
// This composition features drums (kick,snare,hihat), rhodey for chords, 
// trimel triosc for melody, and sqr2 for random 5th chords in that 3 bar 
// uptempo section. Plus an event controller to initiate tempo change and fade out.
//
// Used given class BPM (it keeps timing in variable quarter, which I could have 
// renamed to "beat" but chose not to.
//
// Scale C Ionian, but there may be outside notes.
//
// The song definition (patterns, loops, etc.) can be found in the song class, 
// and the songManager coordinates between the song class and the instruments.
// Drum instruments make use of an instrument class, but other instruments
// define similar functions within their ck file.
//
// I used static variables to keep track of state, and handle my own
// "pseudo-events" like tempo change and fade out.
//
// Enjoy!
// ================================================================= // 


<<< "Assignment_Final_ItFeelsThatWay" >>>;

SongMgr mgr1;
mgr1.init();

// export to wav
dac => WvOut2 w => blackhole;
me.path() + ".wav" => w.wavFilename;
1 => w.record;

// Add your composition files when you want them to come in
Machine.add(me.dir() + "/drums.ck") => int drumsID;
Machine.add(me.dir() + "/rhodey.ck") => int rhodeyID;
Machine.add(me.dir() + "/sqr2.ck") => int sqr2ID;
Machine.add(me.dir() + "/trimel.ck") => int tmID;

Machine.add(me.dir() + "/eventController.ck") => int ecID;


60::second => now;

Machine.remove(drumsID);
Machine.remove(rhodeyID);
Machine.remove(sqr2ID);
Machine.remove(tmID);
Machine.remove(ecID);

0 => w.record;

<<< "Thanks for listening" >>>;