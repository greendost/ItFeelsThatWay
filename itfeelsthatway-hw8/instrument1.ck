// instrument class
// used for sample instruments, like kick and snare

//<<< "Assignment_Final_ItFeelsThatWay" >>>;


public class Instrument1
{
    0.0 => float TEMPO_CHG;

    SndBuf snd => Pan2 pan => NRev rev => Gain master => dac;
    0.1 => rev.mix;
    
    int pattern[];  // current pattern
    float params[];
    false => int isPlayingPattern;
    
    
    fun void play(int counter) 
    {
        true => isPlayingPattern;
        
        counter % pattern.cap() => int beat;  // find beat        
        0 => snd.pos;
        params[1] * pattern[beat] => snd.gain;
        1.0 => snd.rate;
        
        if(beat == pattern.cap()-1) 
            false => isPlayingPattern;
        
        // check for song mode fade out
        //if(songMode == FADE_DOWN) {
            //<<< "fade down" >>>;
         //   if(master.gain() > 0.0) {
           //     master.gain() - (0.1*master.gain()) => master.gain;
           // }
       // }
    }
    
    fun void initInstrument(string soundFile) 
    {
        params[0] => master.gain;

        soundFile => snd.read;
        snd.samples() => snd.pos;
        params[2] => pan.pan;        
    }
    
    fun void processEvents(SongMgr mgr)
    {
        // check for song mode fade out
        if(mgr.song.mode == mgr.song.FADE_OUT) {
            //<<< "fade down" >>>;
            if(master.gain() > 0.0) {
                master.gain() - (0.1*master.gain()) => master.gain;
                if(master.gain() < 0.001) {
                    //<<< "silent instrument" >>>;
                    0.0 => master.gain;
                }
            }
        }
    }
}


