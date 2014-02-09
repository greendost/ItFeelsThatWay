// trimel
//<<< "Assignment_Final_ItFeelsThatWay" >>>;

// melody tri oscillator


<<< "enter tri oscillator" >>>;

5 => int ID;

SongMgr mgr1;
mgr1.setSong(Song s);

float params[];
false => int isPlayingPattern;
string pattern[];
int hitPattern[];
"" => string lastChord;

int scale[];

0 => int TRI_NORMAL;
1 => int TRI_RANDOM;
TRI_NORMAL => int triMode;

TriOsc tri => Pan2 panTri => JCRev rev => Gain master => dac;
0.3 => rev.mix;
0.0 => tri.gain;


// functions 
fun int[] getRawIntervalForType(string type)
{
    int r[0];
    if(type == "mel") return [0];
    else return r;
}

fun int note2midi(string note)
{
    // are there maps in chuck?
    scale[0] => int base;
    if(note == "c") return base;
    else if(note == "c#") return base+1;
    else if(note == "d") return base+2;
    else if(note == "d#") return base+3;
    else if(note == "e") return base+4;
    else if(note == "f") return base+5;
    else if(note == "f#") return base+1;
    else if(note == "g") return base+7;
    else if(note == "g#") return base+8;
    else if(note == "a") return base+9;
    else if(note == "a#") return base+10;
    else if(note == "b") return base+11;
    else return -1;
}

fun void init(float params[])
{
    params[0] => master.gain;
    params[1] => tri.gain;
    params[2] => panTri.pan;
    
    mgr1.getScale() @=> scale;
    
}


fun void play(int counter)
{
    true => isPlayingPattern;

    counter % pattern.cap() => int localCount;

    if(triMode == TRI_RANDOM) {
        counter % hitPattern.cap() => int beat;  // find beat        
        params[1] * hitPattern[beat] => tri.gain;
    
        mgr1.getScale() @=> int scale[];
        Std.mtof(scale[Math.random2(0,scale.cap()-1)]) => tri.freq;
    }
    else {
        0 => int sustain;
        pattern[localCount] => string chord;
        if(chord == lastChord) 1 => sustain;
        chord => lastChord;
        mgr1.parseChord(chord) @=> string dd[];
        
        note2midi(dd[0]) => int rootNote;
        getRawIntervalForType(dd[1]) @=> int rawInterval[];
        
        if(1 == rawInterval.cap()) {
            Std.mtof(rootNote+rawInterval[0]) => tri.freq;
            //if(!sustain) 1.0 => tri.noteOn;
            params[1] => tri.gain;
        } else {
            0.0 => tri.gain;
        }
    
    }
    
    if(localCount == pattern.cap()-1) false => isPlayingPattern;
}

fun void processEvents(SongMgr mgr)
{
    // check for song mode fade out
    if(mgr.song.mode == mgr.song.FADE_OUT) {
        //<<< "fade down" >>>;
        if(master.gain() > 0.0) {
            master.gain() - (0.25*master.gain()) => master.gain;
            //<<< "trimel master gain=",master.gain() >>>;
            if(master.gain() < 0.001) {
                0.0 => master.gain;
            }
        }
    }
    
}



// Main ----

init(mgr1.getParams(ID));

0 => int counter;
while(true)
{
    if(!isPlayingPattern) {
        //<<< "triOsc: new pattern" >>>;
        if(mgr1.getNextLoopType(ID) >= 0) {
            TRI_NORMAL => triMode;
            mgr1.getChordPattern(ID) @=> pattern;
        } else {
            TRI_RANDOM => triMode;
            mgr1.getHitPattern(ID) @=> hitPattern;
        }    
        mgr1.getParams(ID) @=> params;
    }
    
    processEvents(mgr1);
    play(counter);
    
    mgr1.getChuck(ID) => now;
    counter++;  
    
}
