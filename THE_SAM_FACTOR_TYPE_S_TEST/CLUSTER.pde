class Cluster {

  PVector org, loc;
  float tSize = random(2,12);
  float size = random(2,18); // size of squares
  float sSize = random(1.0,2.0);
  int sSpace = 3; // the higher the number the less lines
  float radius, offSet, a, sW;
  int s, dir, countC;
  int d =  75;
  
  String iWords[] = {"Crypto", "Regulations", "Power", "Arbitrage", "Effective Altruism", "Goldendoodle", "Salt", "Future", "Expected Value", "Chess"};
  String words[] = {"Pandemic Prevention", "Crypto", "Public Servant", "Direction", "Money", "Candidate", "Bipartisan", "Politics", "Policy", "DC", "Nassau", "New York", "Standford", "Loophole", "Mega-Donor", "Hard-Working", "Ambition", "Quantum Mechanics", "Utilitarianism", "Consequentialism", "Blockchain", "Regulation", "Build", "Stock Market", "Cryptocurrency", "Codify", "Ecosystem", "Arbitrage", "Altruism", "Impact", "Bitcoin", "FTT", "Billionaire", "Decision", "Reasoning", "Expected Value", "Effective Altruism", "Charities", "Community", "Education"};
  int rWords = (int(random(words.length)));
  int rIWords = (int(random(iWords.length)));
  
  boolean[] connection = new boolean[num];

  Cluster(PVector _org, PVector _loc, float _radius, int _dir, float _offSet) {
    org = _org;
    loc = _loc;
    radius = _radius;
    dir = _dir;
    offSet = _offSet;
  }

  void run() {
    display();
    move();
    lineBetween();
  }

  void move() {
  
    loc.x = org.x + sin((t*TWO_PI)*dir+offSet)*radius;
    loc.y = org.y + cos((t*TWO_PI)*dir+offSet)*radius;
    
  }

  void lineBetween() {
    
    countC = 1;
    for (int i=0; i<clusterCollection.size(); i+=sSpace) {
    
      Cluster other = (Cluster) clusterCollection.get(i);
      float distance = loc.dist(other.loc);
      
      dx = 100.0*periodicFunction(offset(i,i),1000,i,i);
      dy = 100.0*periodicFunction(offset(i,i),5000,i,i);
          
      if (distance > 0 && distance < d ) {
        
        a = map(countC,0,10,150,255);
        sW = map(countC,0,10,1,5);
        strokeCap(ROUND);
        strokeWeight(sSize);
        stroke(strokeCol,a);
        noFill();
        bezier(loc.x,loc.y,loc.x+dx,loc.y+dy,other.loc.x,other.loc.y,other.loc.x+dx,other.loc.y+dy);
        connection[i] = true;
      } 
      else {
        connection[i] = false;
      }
    }

    for (int i = 0; i<clusterCollection.size(); i++) {
      if (connection[i]) {
        countC++;
      }
    }
  
  }

  void display() {
  
   push();
   stroke(strokeCol);
   noFill();
   rectMode(CENTER);
   ellipse(loc.x,loc.y,size,size);
   pop();

   push();
   fill(strokeCol);
   textAlign(LEFT);
   
   textFont(tFont,tSize); 
   
   for (int i = 0; i < iWords.length; i++) {
     
     if( words[rWords].contains(iWords[i])) {
     textFont(tFont,24); 
     } 
    }
      text(words[rWords],loc.x,loc.y);
      pop();
  }
}
