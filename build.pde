import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*; 
import ddf.minim.*;
import ddf.minim.analysis.*;


AudioPlayer song;
BeatDetect beat;
float eRadius;

float a;                 // Angle of rotation
float offset = PI/24.0;  // Angle offset between boxes
int num = 12;            // Number of boxes

FFT fft;
Minim minim;

AudioInput in;
AudioOutput out;

WaveformRenderer waveform;
PShape square;
float waveMax = 0;
float waveCount = 0;
float division = 0;
PShape s;
boolean playThrough = true;
void setup(){
  size(500, 500, OPENGL); 
  frameRate(30);
  background(0);
  noStroke();
  smooth();


  minim = new Minim( this );
  in = minim.getLineIn( Minim.STEREO, 512);

  waveform = new WaveformRenderer();
  in.addListener(waveform);
  if(playThrough){
    out = minim.getLineOut(Minim.STEREO, 512);
    out.addSignal(waveform);
  }
  fft = new FFT( in.bufferSize(), in.sampleRate() );
  waveMax = fft.specSize();
  division = width/waveMax;
  for (int i=0;i<waveMax;i++) {
    rect(division*i, height/2, division, 10);
 
  minim = new Minim(this);
  beat = new BeatDetect();
  
  ellipseMode(CENTER);
  eRadius = 20; // initial size of radius
 
 }
  //


}
void stop() {
  // always close Minim audio classes when you are finished with them
  in.close();
  out.close();
  minim.stop();

  super.stop();
  // always close Minim audio classes when you are finished with them
  song.close();


}
void draw(){
  fill(0);
  background(#511B11);
  fft.forward( in.mix );
  fill(255); 

  // Circle

  beat.detect( in.mix );
  float a = map(eRadius, 20, 80, 60, 255);
  fill(#BFB8A3, a); //colour of ellipse
  if ( beat.isOnset() ) eRadius = 500; // set the sensitivity
  ellipse(width/2, height/2, eRadius, eRadius);
  eRadius *= 0.95;
  if ( eRadius < 20 ) eRadius = 20;

  // Bars
  // for (int i=0;i<waveMax;i++) {
  //   rect(division*i,height/2,division,fft.getBand(i)*100);
  // }

}










