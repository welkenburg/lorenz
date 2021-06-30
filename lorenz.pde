class Point{
  float x;
  float y;
  float z;
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  int maxSize = 255;
  
  Point(float x, float y, float z){
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void update(float sigma, float rho, float beta){
    x += (sigma * (y - x))      * dt;
    y += (x * (rho - z) - y)    * dt;
    z += (x * y - beta * z)     * dt;
    points.add(new PVector(x,y,z));
    
    if(points.size() > maxSize) points.remove(0);
  }
  
  void draw(float hue){
    noFill();
    beginShape();
    float brightness = 255;
    for(int i = points.size() - 1 ; i > -1; i--){
      stroke(hue, 255, brightness);
      vertex(points.get(i).x, points.get(i).y, points.get(i).z);
      brightness -= 255 / maxSize;
    }
    endShape();
  }
}

float sigma = 20;
float rho = 27;
float beta = 8.0/4.0;

float dt = 0.01;

ArrayList<Point> attractors = new ArrayList<Point>();

float rotx = PI/4;
float roty = PI/4;
float zoom = 6;

//PeasyCam cam;

void setup(){
  size(600,600, P3D);
  colorMode(HSB);
  strokeWeight(0.5);
  
  for(int i = 0; i < 255; i++) attractors.add(new Point(3.00 + i/10,4,5));
  
}

void draw(){
  rotateX(rotx);
  rotateY(roty);
  background(0);
  translate(width/2,height/2);
  scale(zoom);
  
  float hue = 0;
  for(Point p : attractors){
    p.update(sigma, rho, beta);
    p.draw(hue);
    hue = (hue + 255/attractors.size()) % 255;
    
  }
}

void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}

void keyPressed(){
  float rate = 0.01;
  if(key == 'a') zoom -= rate * zoom;
  if(key == 'z') zoom += rate * zoom;
}
