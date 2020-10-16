public class Shooter {
  float posX, posY, size, direction; // direction in radian
  float rightmid2X, rightmid2Y; // position head of shooter
  int speed;
  boolean isEnd; // for check the shooter was killed or not
  
  Shooter(){
    posX = width/4;
    posY = height/2;
    size = 50;
    direction = 0;
    speed = 1;
    isEnd = false;
  }
  
  public void draw(){
    if (!isEnd){
      
      // calculate position for 3 angles of traingle (body shooter)
      float rightrim1X = posX - (cos(direction+radians(90)) * size/2);
      float rightrim1Y = posY - (sin(direction+radians(90)) * size/2);
      
      float leftrim1X = posX - (cos(direction-radians(90)) * size/2);
      float leftrim1Y = posY - (sin(direction-radians(90)) * size/2);
      
      float midrim1X = posX - (cos(direction+radians(180)) * 5*size/3);
      float midrim1Y = posY - (sin(direction+radians(180)) * 5*size/3);
      
      // calculate positon from body to head of shooter
      float leftmid1X = posX - (cos(direction+radians(180)) * 4*size/3);
      float leftmid1Y = posY - (sin(direction+radians(180)) * 4*size/3);
      
      rightmid2X = posX - (cos(direction+radians(180)) * 6*size/3);
      rightmid2Y = posY - (sin(direction+radians(180)) * 6*size/3);
      
      fill(15,76,129); // green color
      strokeWeight(3); 
      
      // draw the shooter
      triangle(rightrim1X, rightrim1Y, leftrim1X, leftrim1Y, midrim1X, midrim1Y); // body of shooter
      circle(posX,posY,size); // footer of shooter
      strokeWeight(10);  // set strokeWeight of line 
      line(leftmid1X, leftmid1Y, rightmid2X, rightmid2Y);  // head of shooter
      strokeWeight(3);
    }
 
  }
  
  public float getX(){
    // get poition X
    return posX;
  }
  
  public float getY(){
    // get position Y
    return posY;
  }
  
  public float getSize(){
    return size;
  }
  
  public float getDirection(){
    return direction;
  }
  
  public float getHeadPosX(){
    return rightmid2X;
  }
  
  public float getHeadPosY(){
    return rightmid2Y;
  }
  
  public boolean set_isEnd(boolean stage){
    // for set value of attribute 'isEnd'
    isEnd = stage;
    return isEnd;
  }
  
  public void move(String keyInput){
    if (!isEnd){
      // when the game is not over
      
      if (keyInput == "up"){
          // move forward
          this.posX += 6 * cos(this.direction);
          this.posY += 6 * sin(this.direction);
      }
      else if (keyInput == "down"){
          // move backward
          this.posX -= 6 * cos(this.direction);
          this.posY -= 6 * sin(this.direction);
      }
      else if (keyInput == "left"){
        // turn left
        this.direction = radians(degrees(this.direction) - 2);
      }
      else if (keyInput == "right"){
        // turn right
        this.direction = radians(degrees(this.direction) + 2);
      }
    }
  }
}

public class Bullet {
  float posX, posY, direction; // direction in radian
  float rightX, rightY; // position head of bullet
  
  Bullet(float positionX, float positionY, float d){
    posX = positionX + 90 * cos(d);
    posY = positionY + 90 * sin(d);
    this.direction = d;
    BULLETS_COUNT += 1;
  }
  
  public void draw(){
    // backside of bullet
    float leftX = posX;
    float leftY = posY;
    
    // head of bullet
    rightX = posX - (cos(direction+radians(180)) * 20);
    rightY = posY - (sin(direction+radians(180)) * 20);
    
    stroke(235,200,21); // color : yellow
    strokeWeight(9); // set strokeWeight of bullet (line)
    
    // draw bullet from backside to head 
    line(leftX, leftY, rightX, rightY); 
    
    strokeWeight(3);
    stroke(0);
  }
  
  public void move(){
    // for move bullets
    posX += 10 * cos(direction);
    posY += 10 * sin(direction);
  }
  
  public float getPosX(){
    return posX;
  }
  
  public float getPosY(){
    return posY;
  }
  
  public float getHeadPosX(){
   return  rightX;
  }
  
  public float getHeadPosY(){
   return rightY; 
  }
  
  public boolean isOverEdge(){
    // check bullet is over the edge or not
    return this.getPosX() < 0 || this.getPosX() > width || this.getPosY() <0 || this.getPosY() > height;
  }
  
}

public class Zombie {
  float posX, posY, direction=0; //direction in radian
  int speed, size;
  float[] posEdge = {0,width}; // for random position y of zombie
  int hp;
  
  Zombie(){
    int index = int(random(posEdge.length));
    posX = random(width)+100;
    posY = posEdge[index];
    size = 60;
    speed = 1;
    ZOMBIES_COUNT += 1;
    hp = 3;
  }
  
  void draw(){
    fill(48,119,81); // color : green
    strokeWeight(3);
    
    // draw zombie
    circle(posX,posY,size*bigger);
    point(posX,posY);
    
    // right leg of zombie
    float rightrim1X = posX - (cos(direction+radians(90)) * size/2);
    float rightrim1Y = posY - (sin(direction+radians(90)) * size/2);
    float rightrim2X = posX - (cos(direction+radians(13)) * size);
    float rightrim2Y = posY - (sin(direction+radians(13)) * size);
    line(rightrim1X, rightrim1Y, rightrim2X, rightrim2Y);

    // left leg of zombie
    float leftrim1X = posX - (cos(direction-radians(90)) * size/2);
    float leftrim1Y = posY - (sin(direction-radians(90)) * size/2);
    float leftrim2X = posX - (cos(direction-radians(13)) * size);
    float leftrim2Y = posY - (sin(direction-radians(13)) * size);
    line(leftrim1X, leftrim1Y, leftrim2X, leftrim2Y);
  }

  public void move(float shooterX, float shooterY){
    // for move zombie
    
    // direction of zombie
    direction = (atan2(posY - shooterY, posX - shooterX));
    
    // distance between zombie and shooter
    float dist = dist(posX, posY, shooterX, shooterY);
    
    if(posX <= shooterX){
      // when shooter on the right side of zombie
      posX += dist/500;
    }
    else if (posX >= shooterX){
      // when zombie on the right side of shooter
      posX -= dist/500;
    }
    if(posY <= shooterY){
      // when zombie at the top of shooter
      posY += dist/500;
    }
    else if (posY >= shooterY){
      // when zombie at the bottom of shooter
      posY -= dist/500;
    }
  }
  
  public float getPosX(){
    return posX;
  }
  
  public float getPosY(){
    return posY;
  }
  public int getSize(){
    return size;
  }
  public int health() {
    return hp;
  }
  
  public boolean kill(){
    // for check Is zombie in a position to kill the shooter?
    
    // distance between zombie and shooter
    float dist = dist(this.posX, this.posY, shooter.getX(), shooter.getY());
    
    if (dist < this.size/2 + shooter.getSize()/2){
      return true;
    }
    return false;
  }
}

Shooter shooter;
ArrayList<Bullet> bullets;
int BULLETS_COUNT;
ArrayList<Zombie> zombies;
int ZOMBIES_COUNT;

float bigger;

void setup() {
  size(800,800);
  background(255); // set background color : white
  
  BULLETS_COUNT = 0;
  ZOMBIES_COUNT = 0;
  
  shooter = new Shooter(); // create object of the Shooter
  bullets = new ArrayList<Bullet>(20); // create object of Bullet
  zombies = new ArrayList<Zombie>(100); // create object of Zombie
  
  thread("generateZombieThread"); // for generate zombie every 2 seconds
}

void draw(){
  background(255);
  shooter.draw();
  
    // move and draw zombies
    for(int i=0; i< zombies.size(); i++){
      zombies.get(i).move(shooter.getX(), shooter.getY());
      zombies.get(i).draw();
      
      if(zombies.get(i).kill()){
        // when zombie in a position to kill the shooter
        shooter.set_isEnd(true);
        println("Game Over");
        noLoop();
      }
    }
   
   // move and draw bullets
   for( int i =0;i<bullets.size();i++){
     Bullet b = bullets.get(i);
     b.move();
     b.draw();
     
     if(b.isOverEdge()){
       // when bullet over the edge
       bullets.remove(i);
     }
   }
   
   boolean removeBulletFlag = false;
   
   // for remove the zombie that collide with bullet
   for(int bulletIndex=0; bulletIndex<bullets.size() ; bulletIndex++){
    for(int zombieIndex=0; zombieIndex<zombies.size() ; zombieIndex++){
       Zombie z = zombies.get(zombieIndex);
       Bullet b = bullets.get(bulletIndex);
       
       // distance between positon head of bullet and position of zombie
       float distance = dist(b.getHeadPosX(), b.getHeadPosY(), z.getPosX(), z.getPosY());
       
       if(distance < z.getSize()/2){
         // when zombie collide with bullet
         for (bigger = 1; bigger < 0; bigger += 0.2) {
           bigger = bigger + 0.2;
         }
         //zombies.remove(zombieIndex);
         removeBulletFlag = true;
       }
    }
    if (removeBulletFlag){
      // remove bullet when zombie that collide with bullet is remove
      bullets.remove(bulletIndex);
      removeBulletFlag = false;
    }
   }
  
  if(keyPressed){
    
     switch (keyCode){
       // when press arrow button 
       
      case UP:
        // move forward
        shooter.move("up");
        break;
        
      case DOWN:
        // move backward
        shooter.move("down");
        break;
        
      case LEFT:
        // turn left
        shooter.move("left");
        break;
        
      case RIGHT:
        // turn right
        shooter.move("right");
        break;
    }
    
    switch (key){
      // when press 'w, a, s, d' button
      
      case 'w':
        // move forward
        shooter.move("up");
        break;
      
      case 'a':
        // turn left
        shooter.move("left");
        break;
        
      case 's':
        // move backward
        shooter.move("down");
        break;
        
      case 'd':
        // turn right
        shooter.move("right");
        break;
    }
  }
}

void keyPressed(){
  if(key == ' '){
    // when press spacebar button (for shoot the bullet)
    Bullet b = new Bullet(shooter.getX(), shooter.getY(), shooter.getDirection());
    bullets.add(b);   
  }
}

void generateZombieThread(){
  // for generate zombie every 2 seconds
  while(true){
     Zombie z = new Zombie();
     zombies.add(z);
     delay(2000);
  }
}
