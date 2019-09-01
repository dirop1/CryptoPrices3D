
//import peasy.*;
import http.requests.*;
JSONArray json;
PFont font; 
int mWIDTH = 800;
float rot;
//PeasyCam cam;

ArrayList<Coin> coins = new ArrayList<Coin>();

void setup() {
  
  size(650, 200, P3D);
  lights();
  //cam = new PeasyCam(this, 0, 0, 0, mWIDTH);
  font = createFont("Arial", 30, true); // STEP 2 Create Font  
  textMode(SHAPE);
  //
  textFont(font, 50);
  textAlign(CENTER);
  smooth();
  loadCoins();
  noStroke();
}
int loops = -1;
void draw() {
  //frameRate(60);
  scale(0.3);
  rot += .02;
  background(33);  
  point(0, 0);
  for (Coin c : coins) {
    c.Draw();
  }
  if(loops % 800 == 0){
    thread("loadPrices"); loops=1;
  }else{loops++;}
}

void loadCoins() {
  xoff = 0;
  coins.add(new Coin("BTCUSDT", getXOffset(), "btc.png", "0"));
  coins.add(new Coin("ETHUSDT", getXOffset(), "eth.png", "0"));
  coins.add(new Coin("LTCUSDT", getXOffset(), "ltc.png", "0"));
  coins.add(new Coin("XRPUSDT", getXOffset(), "xrp.png", "0"));
}
int xoff = 0;
int getXOffset(){
   return 170 + (400*xoff++);
}
void loadPrices() {
  for (Coin c : coins) {
    c.setPrice("Loading");
  }
  GetRequest get = new GetRequest("https://api.binance.com/api/v1/ticker/bookTicker");
  get.send();
  json = parseJSONArray(get.getContent());
  //println("Reponse Content: " + get.getContent());
  println("Reponse Content-Length Header: " + get.getHeader("Content-Length"));
  font = createFont("Arial", 20, true); // STEP 2 Create Font
  for (int i = 0; i < json.size(); i++) {
    JSONObject tick = parseJSONObject(json.get(i).toString());
    String  coin = tick.getString("symbol");
    //println(coin);
    for (Coin c : coins ) {
      if (coin.contains( c.name)) {
        Float price = ((tick.getFloat("askPrice")) + tick.getFloat("bidPrice"))/2;
        c.setPrice(Float.toString(price));
        break;
      }
    }
  }
}
