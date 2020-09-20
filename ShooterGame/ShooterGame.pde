public class Shooter {
  float posX, posY, size, direction;
  int speed, hp;
  boolean isDead, isMove;
  
  Shooter(){
    posX = width/4;
    posY = height/2;
    size = 50;
    direction = 0;
    speed = 1;
    hp = 3;
    isDead = false;
    isMove = false;
  }
  
  public void draw(){
    fill(15,76,129);
    strokeWeight(3);
    triangle(posX, posY - size/2, posX, posY + size/2, posX + 85, posY);
    circle(posX,posY,size);
    rect(posX+50, posY-10, 40, 20);
    
    /*
    int focusX = mouseX;
    int focusY = mouseY;
    float rad = (atan2(posY - focusY, posX - focusX));
    
    float rightrim1X = posX - (cos(rad+radians(90)) * size/2);
    float rightrim1Y = posY - (sin(rad+radians(90)) * size/2);
    float rightrim2X = posX - (cos(rad+radians(13)) * size);
    float rightrim2Y = posY - (sin(rad+radians(13)) * size);
    line(rightrim1X, rightrim1Y, rightrim2X, rightrim2Y);
    */
  }
  
  public float getPosX(){
    return posX;
  }
  
  public float getPosY(){
    return posY;
  }
  
  public float getDirection(){
    return direction;
  }
  
  public void setZombie(int amount){
    zombie = new Zombie[amount];
    for (int i=0; i<amount; i++){
      zombie[i] = new Zombie();
    }
  }
  
  public void setBullet(int amount){
    bullet = new Bullet[amount];
    for (int i=0; i<amount; i++){
      bullet[i] = new Bullet(posX +(40*i), posY);
    }
  }
  
  void move(){
    if (keyPressed == true){
       switch (keyCode){
          case UP:
            // move up
            shooter.posY -= 3;
            break;
            
          case DOWN:
            // move down
            shooter.posY += 3;
            break;
            
          case LEFT:
            // move left
            shooter.posX -= 3;
            break;
            
          case RIGHT:
            // move right
            shooter.posX += 3;
            break;
      }
    }
    if (isMove == false){
      if (posX != width/4 || posY != height/2){
        isMove = true;
        this.setBullet(1);
        this.setZombie(3);
      }
    }
    else if (isMove == true){
      if (bullet[bullet.length/2].posX >= width-30){
        this.setBullet(1);
      }
    }
    
  }
  
  void dead() {
    if (hp < 1) {
      // pass
    }
  }
  
}

public class Bullet {
  float posX, posY;
  
  Bullet(float positionX, float positionY){
    posX = positionX + 90;
    posY = positionY;
  }
  
  public void draw(){
    fill(235,200,21);
    rect(posX,posY,30,10);
  }
  
  public void move(){
    posX += 10;
  }
  
  public float getPosX(){
    return posX;
  }
  
  void damage() {
    // if () {
      // pass
    //}
  }
}

public class Zombie {
  float posX, posY;
  int speed, size, zombie_lives;
  
  Zombie(){
    posX = random(width);
    posY = random(height);
    size = 60;
    speed = 1;
    zombie_lives = 3;
  }
  
  public void draw(){
    fill(48,119,81);
    strokeWeight(3);
    circle(posX,posY,size);
    point(posX,posY);
    
    int focusX = mouseX;
    int focusY = mouseY;
    float rad = (atan2(posY - focusY, posX - focusX));

    float rightrim1X = posX - (cos(rad+radians(90)) * size/2);
    float rightrim1Y = posY - (sin(rad+radians(90)) * size/2);
    float rightrim2X = posX - (cos(rad+radians(13)) * size);
    float rightrim2Y = posY - (sin(rad+radians(13)) * size);
    line(rightrim1X, rightrim1Y, rightrim2X, rightrim2Y);

    float leftrim1X = posX - (cos(rad-radians(90)) * size/2);
    float leftrim1Y = posY - (sin(rad-radians(90)) * size/2);
    float leftrim2X = posX - (cos(rad-radians(13)) * size);
    float leftrim2Y = posY - (sin(rad-radians(13)) * size);
    line(leftrim1X, leftrim1Y, leftrim2X, leftrim2Y);
  }

  public void move(){
    float dist = dist(posX, posY, shooter.getPosX(), shooter.getPosY());
    if(posX <= shooter.getPosX()){
      posX += dist/500;
    }
    else if (posX >= shooter.getPosX()){
      posX -= dist/500;
    }
    if(posY <= shooter.getPosY()){
      posY += dist/500;
    }
    else if (posY >= shooter.getPosY()){
      posY -= dist/500;
    }
  }
  
  void dead() {
    if (zombie_lives < 1) {
      // pass
    }
  }
  
}

Shooter shooter;
Bullet[] bullet;
Zombie[] zombie;

void setup() {
  size(800,800);
  background(255);
  
  shooter = new Shooter();
}

void draw(){
  background(255);
  shooter.draw();
  shooter.move();
  
  if (shooter.isMove == true){
    for (Bullet bullet1 : bullet) {
      bullet1.draw();
      bullet1.move();
    }
    for (Zombie zombie1 : zombie) {
      zombie1.draw();
      zombie1.move();
    }
  }
  
}
