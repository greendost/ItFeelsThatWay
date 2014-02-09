// sqr2.ck
// square wave "power" chords
//<<< "Assignment_Final_ItFeelsThatWay" >>>;

4 => int sqr2ID;

SongMgr mgr1;
mgr1.setSong(Song s);

SqrOsc sqr1 => Pan2 panSqr1 => Echo e1=> JCRev rev1 => Gain master => dac;
SqrOsc sqr2 => Pan2 panSqr2 => Chorus c1 => JCRev rev2 => master => dac;

float params[];


fun void init(float params[])
{
    0.0 => sqr1.gain; 
    0.0 => sqr2.gain; 

    0.1::second => e1.delay;
    0.5 => e1.mix;

    0.1 => c1.modFreq;
    0.2 => c1.modDepth;
    0.4 => c1.mix;
    
    0.1 => rev1.mix;
    0.1 => rev2.mix;
    params[0] => master.gain;    
}


// Main
init(mgr1.getParams(sqr2ID));

while(true)
{
    if( (mgr1.song.currentBar >= 8) && (mgr1.song.currentBar < 11)) { 
        mgr1.song.scale[Math.random2(0,mgr1.song.scale.cap()-1)]-12 => int note;
        //<<< "note=",note >>>;
        Std.mtof(note) => sqr1.freq;
        Std.mtof(note+7) => sqr2.freq;
    
        mgr1.getParams(sqr2ID) @=> params;
        //<<< "params[1]=",params[1] >>>;
        params[1] => sqr1.gain;
        params[1] => sqr2.gain;
    }
    else {
        0.0 => sqr1.gain => sqr2.gain;
    }
    mgr1.getChuck(sqr2ID) => now;
} 