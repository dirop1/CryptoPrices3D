class Coin {
  String name,PRICE,file_img;
  float center, y;
  PImage imgCOIN;
  
  Coin(String name_, float x_,String img_,String price) {
    name = name_;
    y=200;
    imgCOIN = loadImage("imgs/"+img_);
    
    center = x_+(imgCOIN.width/2);
    PRICE = price;
  }

  void Draw() {
    fill(230);
    text(name, center+(imgCOIN.width/2), y-70, 0);
    pushMatrix();
    translate(center+(imgCOIN.width/2), y, 0);
    
    rotateY(rot);   
    image(imgCOIN, -(imgCOIN.width/2), 0);
    popMatrix();
    text(PRICE, center+(imgCOIN.width/2), y+(imgCOIN.height)+90, 0);
  }
  
  void setPrice(String price){
    PRICE = price;
  }
}
