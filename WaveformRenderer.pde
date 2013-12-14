class WaveformRenderer implements AudioListener, AudioSignal
{

  private float[] left;
  private float[] right;

  WaveformRenderer()
  {
    //    left = null; 
    //    right = null;
  }

  synchronized void samples(float[] samp)
  {
    left = samp;
  }

  synchronized void samples(float[] sampL, float[] sampR)
  {
    left = sampL;
    right = sampR;
  }


  void generate(float[] samp)
  {
    System.arraycopy(right, 0, samp, 0, samp.length);

  }

  // this is a stricly mono signal
  void generate(float[] sampL, float[] sampR)
  {
    if (left!=null && right!=null){
      System.arraycopy(left, 0, sampL, 0, sampL.length);
      System.arraycopy(right, 0, sampR, 0, sampR.length);
    }
  }


}
