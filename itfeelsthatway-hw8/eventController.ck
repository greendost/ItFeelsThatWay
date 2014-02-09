// eventController
// marks each measure, updates song currentBar, and 
// checks for events
//<<< "Assignment_Final_ItFeelsThatWay" >>>;

<<< "enter eventController" >>>;

SongMgr mgr1;
mgr1.setSong(Song s);


0 => int counter;
-1 => int bar;
while(true)
{
    if( (counter % 4) == 0) {
        bar++;
        bar => mgr1.song.currentBar;
        <<< "bar=",bar >>>;
    }
    
    mgr1.processEvents(bar);
    
    // quarter note pulse always
    mgr1.song.tempo.quarterNote => now;
    
    counter++; 
}
