class Player{
  //player initalization
  float hp, speed, damage;
  PImage character, flakAttack1, norkAttack1;
  int lives;
  float x, y, velocityX, velocityY, direction, right, left, up;
  float flakAttack1X, flakAttack1Y, flakAttack1Direction;
  float norkAttack1X, norkAttack1Y, norkAttack1Direction;
  boolean mounted = false;
  
  //constructor assigns default values
  Player(float hp, float speed, float damage){
    this.hp = hp;
    this.speed = speed;
    this.damage = damage;
    lives = 3;
    x = 100;
    y = 500;
    character = loadImage("flak.png");
    right = 0; left = 0; up = 0;
    direction = 1;
    velocityX = 0; velocityY = 0;
    
    flakAttack1 = loadImage("flakattack1.png");
    norkAttack1 = loadImage("ay.png");
    
    
    
  }
  
  void dodge(){
    
    //dodge;
    
  }
  
  
  void M1(){
    
    //mouse1 attack
    
  }
  
  void M2(){
    
    //mouse2 attack
    
  }
  
  //to take damage from enemies
  void takeDamage(float amount){
   
    //if hit
    if(hardcore){
      
      hp -= amount;
      
    }
    else{
      
      hp -= amount/2;
      
    }
    
    
  }
  
  //display player
  void display(){
    
    //if not mounted
    if(!mounted){
      
      //change direction based on controls
      if(direction == 1){
       character =  loadImage("flak.png");
      }
      else{
        character = loadImage("flakflipped.png"); 
      }
      
      //if on scene3
      //make flak scared
      if(onScene3){
        if(!enemy6.deathSoundPlayed){
          if(direction == 1){
            character = loadImage("flakscared.png");
          }
          else{
            character = loadImage("flakscaredflipped.png");
          }
        }
      }
      //display
      image(character, x, y);
      fill(player.hp, 74 ,94);
      textSize(30);
      text(player.hp, player.x+player.character.width/2, player.y);
      
      
      //if above ground
      if(y < ground){
       //gravity
        velocityY += gravity;
        
      }
      //if on ground
      else{
       // no gravity
        velocityY = 0;
        
      }
      
      //if jump
      if(y >= ground && up!= 0){
       //upward velocity to counter gravity
        if(!mounted){
          velocityY = -1.2*speed;
        }
        else{
          velocityY = -1.4*speed; 
        }
        
      }
      
      //x velocity depends on direction
      velocityX = speed * (left+right);
      
      //add values to position
      x+=velocityX;
      y+=velocityY;
      
      //when flakAttacks
      if(flakAttacked1){
        //display in direction
        image(flakAttack1, flakAttack1X, flakAttack1Y);
        //flakAttack1Y += velocityY;
        
        //and move depending on direction
        if(flakAttack1Direction == 1){
           flakAttack1X += speed;
           if(flakAttack1X > width){
              flakAttacked1 = false; 
           }
        }
        else{
          flakAttack1X -= speed;
          if(flakAttack1X < 0-flakAttack1.width){
              flakAttacked1 = false; 
          }
        }
        
        
        
        
      }
    
    }
    //if mounted
    else{
      //diferent images for direction
      if(direction == 1){
       character =  loadImage("flakandnork.png");
      }
      else{
        character = loadImage("flakandnorkflipped.png"); 
      }
      
      //display
      image(character, x, y);
      fill(player.hp, 74 ,94);
      textSize(30);
      text(player.hp, player.x+player.character.width/2, player.y);
      
      //gravity / ground
      if(y < ground){
       
        velocityY += gravity;
        
      }
      else{
       
        velocityY = 0;
        
      }
      
      if(y >= ground && up!= 0){
       
        velocityY = -1.2*speed;
        
      }
      
      velocityX = speed * (left+right);
      
      x+=velocityX;
      y+=velocityY;
      
      //different flak attack height
      if(flakAttacked1){
        image(flakAttack1, flakAttack1X, flakAttack1Y);
        //flakAttack1Y += velocityY;
        
        if(flakAttack1Direction == 1){
           flakAttack1X += speed;
           if(flakAttack1X > width){
              flakAttacked1 = false; 
           }
        }
        else{
          flakAttack1X -= speed;
          if(flakAttack1X < 0-flakAttack1.width){
              flakAttacked1 = false; 
          }
        }
        
        
      }
      
      //when mounted nork can now attack
      if(norkAttacked1){
        image(norkAttack1, norkAttack1X, norkAttack1Y);
        //flakAttack1Y += velocityY;
        
        if(norkAttack1Direction == 1){
           norkAttack1X += speed*0.75;
           if(norkAttack1X > width){
              norkAttacked1 = false; 
           }
        }
        else{
          norkAttack1X -= speed*0.75;
          if(norkAttack1X < 0-norkAttack1.width){
              norkAttacked1 = false; 
          }
        }
        
        
      }
      
   }
    
  }
  
}
