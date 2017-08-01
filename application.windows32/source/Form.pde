PImage flag, coins;
    PFont f;
    Maze m;
    int curR = 0, curC = 0;
    float curX, curY;
    boolean gameMode = false, splashScreen = true, reset = false;
    int time, timeLimit = 10000, moves;
    //ChildApplet child;
    int score = 1, coin = 0, levels = 0;
    Queue queue = new Queue();

    public void setup() {
        int a = 11, b = 13;
        m = new Maze(a, b);
        m.backGround();
        m.Menu();
        queue.enQueue(0, 0);
        coins = loadImage("coin.png");
        flag = loadImage("flag.png");
    }

    public void splashScreen() {
        splashScreen = true;
        m.backGround();
        m.Menu();
        levels=0;
    }

    public void draw() {

        if (reset) {
            reset();
        }
        if (gameMode) {
            if (millis() - time >= timeLimit) {
                noStroke();

                if (m.oppx != 0 && m.oppy != 0) {
                    fill(191, 66, 255);
                    ellipse(m.oppx, m.oppy, m.gap, m.gap);
                }
                if (queue.head != null) {
                    fill(255, 0, 0);
                    Element e = queue.deQueue();
                    m.oppx = m.nodes[e.r][e.c].x;
                    m.oppy = m.nodes[e.r][e.c].y;
                    ellipse(m.oppx, m.oppy, m.nodes[e.r][e.c].gap, m.nodes[e.r][e.c].gap);
                    time = millis();
                    timeLimit = 700 - levels * 50;
                }
            }
            if (m.oppx == curX && m.oppy == curY) {
                System.out.println("Game ended");
                textSize(100);
                splashScreen = true;
                text("You lost", (4 * width) / 10, height / 2);
                gameMode = false;
                delay(1000);
                splashScreen();
            }
        }
    }

    public void mouseReleased() {
        //checking the reset button coordinates
        if (splashScreen) {
            //playbutton
            if (mouseX > width / 2 - 30 && mouseX < width / 2 + 30 && mouseY > (3 * height) / 6 - 20 && mouseY < (3 * height) / 6 + 20) {
                splashScreen = false;
                reset();
            } //quit button 
            else if (mouseX > width / 2 - 30 && mouseX < width / 2 + 30 && mouseY > (5 * height) / 6 - 20 && mouseY < (5 * height) / 6 + 20) {
                System.exit(0);
            }
        }
    }

    public void reset() {
        queue.enQueue(0, 0);
        levels++;
        gameMode = true;
        timeLimit = 10000 - 100 * levels;
        queue.delete();
        moves = 0;
        m.boardInitializer();
        m.mazeGenerate();
        m.LongestPathFromStart();
        m.startEnd();
        curR = curC = 0;
        curX = m.nodes[0][0].x;
        curY = m.nodes[0][0].y;
        //m.coin();
        time = millis();
        reset = false;

    }

    public void keyReleased() {
        if (gameMode) {

            float preX = m.nodes[curR][curC].x, preY = m.nodes[curR][curC].y, gap = m.nodes[curR][curC].gap;
            if (keyCode == RIGHT) {
                if (m.nodes[curR][curC].dir[0] == true) {
                    curC++;
                    queue.enQueue(curR, curC);
                    coin++;
                    score += 2;
                    moves++;
                    System.out.println("moved right");
                }
            } else if (keyCode == DOWN) {
                if (m.nodes[curR][curC].dir[1] == true) {
                    curR++;
                  queue.enQueue(curR, curC);
                    coin++;
                    score += 3;
                    moves++;
                    System.out.println("moved down");
                }
            } else if (keyCode == LEFT) {
                if (m.nodes[curR][curC].dir[2] == true) {
                    curC--;
                    queue.enQueue(curR, curC);
                    coin++;
                    moves++;
                    score += 7;
                    System.out.println("moved left");
                }
            } else if (keyCode == UP) {
                if (m.nodes[curR][curC].dir[3] == true) {
                    curR--;
                    //fill(0, 255, 0);
                    queue.enQueue(curR, curC);
                    coin++;
                    moves++;
                    score += 6;
                    System.out.println("moved up");
                }
            }
            curX = m.nodes[curR][curC].x;
            curY = m.nodes[curR][curC].y;
            noStroke();
            if (m.endx == curX && m.endy == curY) { //game ends
                reset = true;
                System.out.println("You have moved more " + (moves - m.reqMoves));
            }
            fill(191, 66, 244);
            ellipse(preX, preY, gap, gap); //draw previous ellipse
            fill(0, 255, 0);
            ellipse(m.nodes[0][0].x, m.nodes[0][0].x, gap, gap);
            fill(84, 121, 188);//draw moveable ellipse
            ellipse(curX, curY, gap, gap);
            m.Buttons(score, coin, levels);
        }
    }

