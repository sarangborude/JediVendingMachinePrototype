    import processing.serial.*;
    import intel.pcsdk.*;
    import ddf.minim.*;
    
    Serial myPort;  // Create object from Serial class
    
    //declaring audioplayers for Minim.
    Minim minim;
    AudioPlayer yodaOne;
    AudioPlayer yodaTwo;
    AudioPlayer yodaThree;
    AudioPlayer yodaFour;
    

    
    PImage labelMap;
    PXCUPipeline session;
    
    int timeBeforeShooting = 0;
    boolean isFired = false;
    
    boolean waitBeforeShooting()// this function waits for  5 seconds before shooting letting the user to apply force.
    {
      if(timeBeforeShooting < 5)
      {
        timeBeforeShooting++;
        delay(1000);
        return false;
      }
      else if(timeBeforeShooting >= 5)
      {
        timeBeforeShooting = 0;
        return true;
      }
      return false;
    }
    
    
    void setup() {
      size(640, 480);
      
      //Instantiating a minim object
      minim = new Minim(this);
      

      
      // Initializing the audio players with audio files
      yodaOne = minim.loadFile("UsetheForce.mp3");
      yodaTwo = minim.loadFile("feeltheforce.wav");
      yodaThree = minim.loadFile("feeltheforce.wav");
      yodaFour = minim.loadFile("UsetheForce.mp3");
      
      session = new PXCUPipeline(this);
      if (!session.Init(PXCUPipeline.GESTURE)) {
        print("Failed to initialize PXCUPipeline\n");
        exit();
      }
    
      int[] labelMap_Size = new int[2];
      if(session.QueryLabelMapSize(labelMap_Size))
      {
        //print("Depth Size("+labelMap_Size[0]+","+labelMap_Size[1]+")\n");
        labelMap=createImage(labelMap_Size[0], labelMap_Size[1], RGB);
      }
      //For serial communication in arduino and processing
        String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
        myPort = new Serial(this, portName, 9600); 
    }
    
    void draw() { 
      background(0);
    
      if (session.AcquireFrame(true)) {
          if(session.QueryLabelMapAsImage(labelMap))
            image(labelMap, 0, 0, 640, 480);
    
    
          //Hand 1, first hand detected, left or right specific
          PXCMGesture.GeoNode handOne = new PXCMGesture.GeoNode();
    

    
          //Scale tracked points
          scale(2); //make everything twice as large
       
          //Drawing the fingertips on screen
          fill(0,255,0);
          
          if (session.QueryGeoNode(PXCMGesture.GeoNode.LABEL_BODY_HAND_LEFT, handOne)) {
            ellipse(handOne.positionImage.x, handOne.positionImage.y, 5, 5);
            text("   Hand 1", handOne.positionImage.x, handOne.positionImage.y);
            println("Hand1 Openness:" + handOne.openness);
            //println("Hand1 y:" + handOne.positionImage.y);
            
            if(handOne.positionImage.x < 150 && handOne.positionImage.y < 125 )//detecting first quadrant
            {
              
              if(handOne.openness < 40)
              {
                if(isFired == false)
                {
                  
                  yodaOne.pause();
                  yodaTwo.pause();
                  yodaThree.pause();
                  yodaFour.play();
                }
                if(waitBeforeShooting())
                {

                myPort.write('5');
                println("First Quadrant Fired");
                isFired = true;
                yodaOne.rewind();
                yodaTwo.rewind();
                yodaThree.rewind();
                yodaFour.rewind();
                yodaOne.pause();
                yodaTwo.pause();
                yodaThree.pause();
                yodaFour.pause();

                
                }
              }
              else
              {
                myPort.write('1');
                
              }
              
            }
            else if(handOne.positionImage.x > 150 && handOne.positionImage.y < 125 )//detecting second quadrant
            {
              
              if(handOne.openness < 40)
              {
                //if(isFired == false)
                //{
                  yodaOne.pause();
                  yodaTwo.pause();
                  yodaFour.pause();
                  yodaThree.play();
                //}
                
               // if(waitBeforeShooting())
                //{

                  //myPort.write('6');
                  println("Second Quadrant Fired");
                  //isFired = true;
                  yodaOne.rewind();
                  yodaTwo.rewind();
                  //yodaThree.rewind();
                  yodaFour.rewind();
                  yodaOne.pause();
                  yodaTwo.pause();
                  //yodaThree.pause();
                  yodaFour.pause();

   
              //}
              }
              else
              {
                myPort.write('2');
              }
            }
            else if(handOne.positionImage.x > 150 && handOne.positionImage.y > 125 )//detecting third quadrant
            {
              
              if(handOne.openness < 40)
              {
               //if(isFired == false)
               //{
                  yodaOne.pause();
                  yodaThree.pause();
                  yodaFour.pause();
                  yodaTwo.play();
               //}
                  
                //if(waitBeforeShooting())
                //{

                  myPort.write('7');
                  println("Third Quadrant Fired");
                  isFired = true;
                  yodaOne.rewind();
                 // yodaTwo.rewind();
                  yodaThree.rewind();
                  yodaFour.rewind();
                  yodaOne.pause();
                  //yodaTwo.pause();
                  yodaThree.pause();
                  yodaFour.pause();


              //}
              } 
              else
              {
                myPort.write('3');
                
              }
            }
            else if(handOne.positionImage.x < 150 && handOne.positionImage.y > 125 )//detecting fourth quadrant
            {
              
              if(handOne.openness < 40)
              {
               //if(isFired == false)
               //{
                  
                  yodaTwo.pause();
                  yodaThree.pause();
                  yodaFour.pause();
                  yodaOne.play();
              // }
                  
               // if(waitBeforeShooting())
                //{

                  myPort.write('8');
                  println("Fourth Quadrant Fired");
                  //isFired = true;
                  //yodaOne.rewind();
                  yodaTwo.rewind();
                  yodaThree.rewind();
                  yodaFour.rewind();
                 // yodaOne.pause();
                  yodaTwo.pause();
                  yodaThree.pause();
                  yodaFour.pause();
 
               //}
              } 
              else
              {
                myPort.write('4');
               
              }
            }
            else
            {
              yodaOne.rewind();
              yodaTwo.rewind();
              yodaThree.rewind();
              yodaFour.rewind();
              yodaOne.pause();
              yodaTwo.pause();
              yodaThree.pause();
              yodaFour.pause();
              isFired = false;
              timeBeforeShooting = 0;
              myPort.write('0');
            }
            
          }
          else
            {
              yodaOne.rewind();
              yodaTwo.rewind();
              yodaThree.rewind();
              yodaFour.rewind();
              yodaOne.pause();
              yodaTwo.pause();
              yodaThree.pause();
              yodaFour.pause();
              isFired=false;
              timeBeforeShooting = 0;
              myPort.write('0');
            }
          
    
          
          
    
        session.ReleaseFrame();
      }
    }
    
    
    void stop()
    {
      yodaOne.close();
      yodaTwo.close();
      yodaThree.close();
      yodaFour.close();
      minim.stop();
              
      super.stop();
    }
    

