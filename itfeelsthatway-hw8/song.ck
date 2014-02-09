// song.ck
// this class defines the song.

//<<< "Assignment_Final_ItFeelsThatWay" >>>;


public class Song
{
    // --- "constants" -------------
    0.0 => float TEMPO_CHG;
    
    // song modes
    1.0 => float FADE_OUT;
    2.0 => float NORMAL;
    
    
    // --- vars -------------------
    // tempo
    BPM tempo;
    120.0 => float startTempo;
    
    // scale
    [ 48, 50, 52, 53, 55, 57, 59, 60] @=> int scale[];
    
    static float mode;  // either normal or fade out
    static int currentBar; 
    
    // --- patterns make the song ------------    
    [0,0,0,1,0,1] @=> int patternType[];  // 0 for hit, 1 for chord
    
    // hit patterns    
    [
    // kick
    [[0, 0, 0, 0, 0, 0, 0, 0],
     [1, 0, 0, 0, 0, 0, 0, 0],
     [1, 1, 0, 0, 0, 0, 0, 0],
     [1, 0, 0, 0, 1, 1, 0, 0],    
     [1, 0, 1, 0, 1, 0, 1, 0]],
    // snare
    [[0, 0, 0, 0, 0, 0, 0, 0],
     [0, 0, 0, 0, 1, 0, 0, 0],  
     [0, 0, 0, 0, 1, 0, 0, 1],    
     [0, 1, 0, 1, 0, 1, 0, 1],
     [0, 0, 0, 0, 1, 1, 1, 1]],
    // hihat 
    [[0, 0, 0, 0, 0, 0, 0, 0],  
     [1, 0, 0, 1, 1, 0, 0, 1],    
     [1, 1, 1, 1, 1, 1, 1, 1],
     [1, 0, 0, 1, 1, 1, 1, 1]],
    
    [[0],[0]],
    [[0],[0]],
    // trimel
    [[0, 0, 0, 0, 0, 0, 0, 0],
     [1, 0, 0, 0, 0, 0, 0, 0],
     [1, 1, 1, 1, 0, 0, 1, 1],
     [1, 0, 1, 0, 1, 1, 1, 1]]
    
    ]  @=> int patterns[][][];  // yes, this makes sense :)
    
    
    // how to play patterns - hit or melody/chord patterns
    // cycles back also, but here we have specified the whole song
    // negative in trimel interpreted as setting random mode (solo mode), playing note on hit pattern instead
    [
    [1,1,2,2, 1,1,2,2,   4,4,4,3,  2,2,2,2, 2,2,2,2,  2,2,2,2,     2,2,2,2,    2,2,2,2, 2,2,2,2],   // kick
    [1,1,1,2, 1,1,1,4,   3,3,3,3,  2,2,2,2, 2,2,2,2,  2,2,2,2,     2,2,2,2,    2,2,2,2, 2,2,2,2],   // snare
    [0,0,0,1, 1,1,1,3,   2,2,2,2,  0,0,0,0, 1,0,1,0,  1,0,1,0,     1,0,1,2,    1,0,1,2, 1,0,1,2],   // hihat

    //[0,0,1,1, 0,0,1,1,  3,3,3,2, 1,1,1,1],   // kick
    //[0,0,0,1, 0,0,0,1,  2,2,2,2, 1,1,1,1],   // snare    
    [0,0,0,0, 0,0,1,0,   0,0,0,0,  1,0,1,2, 1,0,1,2,  3,3,3,4,     3,3,3,4,    1,1,1,2, 1,1,1,2], // rhodey
    [0,0,0,0,  0,0,0,0,  1,1,1,1],    // sqr2  - not used
    [0,-1,0,0, 0,-1,0,0,  1,1,1,1,  2,2,1,0, 3,3,4,0, -2,-2,-2,-3, -1,-2,-2,-3, 2,2,2,1, 3,3,4,0]     // trimel
    ] @=> int loops[][]; 
    
    // all instruments
    // 0 - master gain, 1 instrument gain, 
    // 2 - pan, 3 - noteType
    [
    // drums
    [0.3, 1.0, 0.0, 2.0],
    [0.3, 1.0, 0.1, 2.0],
    [0.1, 1.0, -0.1, 2.0],

    [0.12, 0.3, 0.0, 1.0], // rhodey
    [0.08, 0.25, 0.0, 2.0], // sqr2

    [0.3, 1.0, -0.1, 2.0]  // trimel
    ] @=> static float params[][];
    
    
    // still needs to be in sync with patterns array
    // so first two empty arrays would map to kick, snare
    [
    [[""]],[[""]],[[""]],
    // rhodey
    [["r","r","r","r"],
     ["cmaj7","cmaj7","gmaj", "dmin7"],
     ["cmaj7","c#maj7","emin7","emin7"],
     ["dmin7","dmin7","gmaj7","gmaj7"],
     ["f#maj7","fmaj7","r","r"]],
     [[""]],
     // trimel
    [["r", "r", "r", "r", "r", "r", "r", "r"],
     ["c", "r", "r", "r", "g", "r", "r", "r"],
     ["c", "c", "g", "g", "e", "c", "r", "r"],
     ["c", "r", "f", "f#", "g", "d#", "d", "c"],
     ["r", "g", "g#", "a", "b", "c", "r", "r"]]  // text: melody
    ] @=> string chordPatterns[][][];
   
    
    // events
    // 1 - bar #, 2 event_type, 3 global or instrument, 4 new value, 5 processed
    [
    [8.0,TEMPO_CHG,-1.0,180, 0.0],
    [11.0,TEMPO_CHG,-1.0,140, 0.0],
    [31.0,FADE_OUT,-1.0,0.1, 0.0]
    ] @=> float events[][];
    
    fun void init()
    {
        startTempo => tempo.tempo;
        0 => currentBar;
        NORMAL => mode;
    }
}