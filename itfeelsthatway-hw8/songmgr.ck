// SongMgr
// key class that mediates between song and instruments.
// it sort of sounds like mvc.
// 
//<<< "Assignment_Final_ItFeelsThatWay" >>>;


public class SongMgr
{
    // cannot declare static non-primitive objects (yet)
    Song song;  
    
    static int loopMeasureTracker[];
    fun void init()
    {
        [-1,-1,-1, -1, -1, -1] @=> loopMeasureTracker;
        song.init();
    }
    
    fun dur getChuck(int id)
    {
        return song.tempo.quarterNote / song.params[id][3];
    }
    
    fun int getNextLoopType(int id)
    {
        (loopMeasureTracker[id]+1) % song.loops[id].cap()
        => loopMeasureTracker[id];
        
        // negative for random mode (abs value to select hit pattern), otherwise pattern to use
        return song.loops[id][loopMeasureTracker[id]];
    }
    
    fun int[] getHitPattern(int id)
    {
        //(loopMeasureTracker[id]+1) % song.loops[id].cap()
        //=> loopMeasureTracker[id];
        //<<< "getpattern: id=",id," loop measure=",loopMeasureTracker[id] >>>;

        return song.patterns[id][Math.abs(song.loops[id][loopMeasureTracker[id]]) ];        
    }
    
    fun string[] getChordPattern(int id)
    {
        //(loopMeasureTracker[id]+1) % song.loops[id].cap()
        //=> loopMeasureTracker[id];
        //<<< "getpattern: id=",id," loop measure=",loopMeasureTracker[id] >>>;
        
        return song.chordPatterns[id][song.loops[id][loopMeasureTracker[id]] ];        
    }
    
    fun float[] getParams(int id)
    {
        //<<< "getparams" >>>;
        return song.params[id];
    }
    
    fun int[] getScale()
    {
        //<<< "getscale" >>>;
        return song.scale;
    }
    
    fun void processEvents(int bar)
    {
        for(0 => int i; i < song.events.cap(); i++)
        {
            // if there is an event at this time, and it hasn't been processed
            if( (bar == song.events[i][0]) && (0.0 == song.events[i][4]) ) {
                <<< "processing event" >>>;
                if(song.events[i][1] == song.TEMPO_CHG)
                {
                    <<< "tempo change" >>>;
                    song.events[i][3] => song.tempo.tempo;
                    1.0 => song.events[i][4];  // processed
                } else if (song.events[i][1] == song.FADE_OUT) 
                {
                    <<< "fade out" >>>;
                    song.FADE_OUT => song.mode;
                    1.0 => song.events[i][4];  // processed
                }
            
            }
        }
        
    }
    
    // fun way to play chords, intervals, and individual notes
    fun string[] parseChord(string chord)
    {
        string note;
        "mel" => string type;
        int noteLength;
        if (chord.length() > 1) {
            chord.substring(1,1) => string accidental;
            if((accidental == "#") || (accidental == "-"))
                2 => noteLength;
            else 
                1 => noteLength;
        }
        else {        
            1 => noteLength;
            if(chord == "r") "rest" => type;
        }
        chord.substring(0,noteLength) => note;
        
        if(chord.length() > 2)
        {
            chord.substring(noteLength,chord.length()-noteLength) => type;
        }
        return [note,type];
    }
    
    
    fun void setSong(Song s)
    {
        s @=> song;
    } 
}
