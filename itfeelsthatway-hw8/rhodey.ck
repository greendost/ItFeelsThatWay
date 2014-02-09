// rhodey.ck
//<<< "Assignment_Final_ItFeelsThatWay" >>>;


<<< "enter rhodey" >>>;

3 => int rhodeyID;

4 => int NUM_RHODEY;  // 4 voices to play chords
Rhodey r[NUM_RHODEY];
LPF lpf[NUM_RHODEY];
Pan2 pan[NUM_RHODEY];
Gain master => dac;


SongMgr mgr1;
mgr1.setSong(Song s);


false => int isPlayingPattern;
string pattern[];
"" => string lastChord;
float params[];



// functions
// let instrument determine voicings
fun int[] getRawIntervalForType(string type)
{
    int r[0];
    if(type == "mel") return [0];
    else if(type == "int5") return [0,7];
    else if(type == "min") return [0,3,7];
    else if(type == "maj") return [0,4,7];
    else if(type == "min7") return [0,3,7,10];
    else if(type == "maj7") return [0,4,7,11];
    else if(type == "dom7") return [0,4,5,10]; // may need to tweak this one
    else return r;
}

// let instrument determine root note.  future enhancement
// would be to add midi root note number to chord 
fun int note2midi(string note)
{
    // are there maps in chuck?
    if(note == "c") return 60;
    else if(note == "c#") return 61;
    else if(note == "d") return 62;
    else if(note == "d#") return 63;
    else if(note == "e") return 64;
    else if(note == "f") return 65;
    else if(note == "f#") return 66;
    else if(note == "g") return 67;
    else if(note == "g#") return 68;
    else if(note == "a") return 69;
    else if(note == "a#") return 70;
    else if(note == "b") return 71;
    else return -1;
}


// general instrument functions
fun void init(float params[])
{
    for(0 => int i; i < NUM_RHODEY; i++)
    {
        r[i] => lpf[i] => pan[i] => master;       
    }
    
    5.0 => r[1].lfoSpeed;
    0.4 => r[1].lfoDepth;
    0.1 => r[0].afterTouch;
    
    1000 => lpf[0].freq;  
    1200 => lpf[1].freq;
    1000 => lpf[2].freq;
    1200 => lpf[3].freq;
    
    // ignore song pan parameter
    -0.5 => pan[0].pan;
    -0.2 => pan[1].pan;
    0.2 => pan[2].pan;
    0.5 => pan[3].pan;
    
    params[0] => master.gain;    
}

fun void play(int counter)
{
    true => isPlayingPattern;
    0 => int sustain;
    counter % pattern.cap() => int localCount;
    
    pattern[localCount] => string chord;
    if(chord == lastChord) 1 => sustain;
    chord => lastChord;
    mgr1.parseChord(chord) @=> string dd[];
    note2midi(dd[0]) => int rootNote;
    getRawIntervalForType(dd[1]) @=> int rawInterval[];
    
    for(0 => int i; i < NUM_RHODEY; i++)
    {
        if(i < rawInterval.cap()) {
            Std.mtof(rootNote+rawInterval[i]) => r[i].freq;
            if(!sustain) 1.0 => r[i].noteOn;
        } else {
            1.0 => r[i].noteOff;
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
            //<<< "rhodey master gain=",master.gain() >>>;
            if(master.gain() < 0.001) {
                //<<< "silent rhodey" >>>;
                0.0 => master.gain;
            }
        }
    }

}


// Main
init(mgr1.getParams(rhodeyID));

0 => int counter;
while(true)
{
    if(!isPlayingPattern) {
        if(mgr1.getNextLoopType(rhodeyID) != -1)
            mgr1.getChordPattern(rhodeyID) @=> pattern;
        mgr1.getParams(rhodeyID) @=> params;
    }
 
    processEvents(mgr1);
    play(counter);
    
    mgr1.getChuck(rhodeyID) => now;
    counter++;
}