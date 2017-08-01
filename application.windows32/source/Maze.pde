class Maze {

        int row, col;//maze dimensions
        float gap;
        int startR, startC, endR, endC, oppR, oppC; //(startx,starty)=starting node coordinates, and the same for (endx,endy)
        float startx, starty, endx, endy, oppx, oppy;
        Node[][] nodes;//nodes array
        String path; //
        int reqMoves;

        public Maze(int rows, int cols) {
            reqMoves = 0;
            row = rows;
            col = cols;
            gap = 25;
            nodes = new Node[row][col];
            startR = startC = endR = endC = oppR = oppC = 0;
            startx = starty = endx = endy = oppx = oppy = 0;
            size((int) (1.25 * ((2 * col) * gap)), (int) ((2 * row) * gap));

            path = "";
        }

        public void Buttons(int score, int coins, int levels) {
            stroke(200);
            strokeWeight((int) (width * 0.01));
            fill(155);
            rectMode(CORNER);
            rect((int) (0.8 * width), (int) (0.1 * height), (int) (0.18 * width), (int) (0.2 * height));
            rect((int) (0.8 * width), (int) (0.4 * height), (int) (0.18 * width), (int) (0.2 * height));
            rect((int) (0.8 * width), (int) (0.7 * height), (int) (0.18 * width), (int) (0.2 * height));
            fill(0);
            textSize((int) (width * 0.05));
            textAlign(CENTER, CENTER);
            text("Score\n" + score, (int) (0.80 * width), (int) (0.1 * height), (int) (0.18 * width), (int) (0.2 * height));
            text("Coins\n" + coins, (int) (0.80 * width), (int) (0.4 * height), (int) (0.18 * width), (int) (0.2 * height));
            text("Level\n" + levels, (int) (0.80 * width), (int) (0.7 * height), (int) (0.18 * width), (int) (0.2 * height));

        }

        public void boardInitializer() {
            backGround();
            Buttons(0, 0, 0);
            int count = 65; // a=65 in ascii
            for (int i = 0; i < row; i++) {
                for (int j = 0; j < col; j++) { //initializing and drawing nodes 
                    nodes[i][j] = new Node(gap * (2 * j + 1), gap * (2 * i + 1), gap, count++);
                    System.out.println("row=" + i + ",col=" + j + " (" + nodes[i][j].x + "," + nodes[i][j].y + ")");
                    nodes[i][j].drawNode();
                }
            }

            startR = startC = endR = endC = oppR = oppC = 0;
            startx = starty = endx = endy = oppx = oppy = 0;
        }

        public void mazeGenerate() { //mazegeneration algorithm
            nodes[0][0].visited = true; //our first node will remain same, and we are at our first node,make it visited
            DFS(0, 0);//call the DFS method for first node
        }

        public void DFS(int rr, int cc) {
            int[] dirs = generateRandomDirections();//getting random directions
            System.out.println("r0w=" + rr + "col=" + cc);
            path = path + nodes[rr][cc].name;//getting the name of the node and add it into path
            nodes[rr][cc].pathFromStart = path; //assign this path to node's path from A
            stroke(155);
            strokeWeight(2);
            for (int k = 0; k < dirs.length; k++) {
                if (dirs[k] == 3) {//right
                    System.out.println("3");
                    if (cc + 1 >= col) { //there is no more column rightward, then move on
                        continue;
                    }
                    if (nodes[rr][cc + 1].visited == false) {//if the next node is not visited then visit the node
                        line(nodes[rr][cc].x, nodes[rr][cc].y, nodes[rr][cc + 1].x, nodes[rr][cc + 1].y); //draw the line in between the two nodes
                        nodes[rr][cc].dir[0] = true; //make it's right direction true
                        nodes[rr][cc + 1].dir[2] = true; //make the left direction of the next node true
                        nodes[rr][cc + 1].visited = true;//make the next node visited
                        DFS(rr, cc + 1); //call the DFS for this node
                    }

                } else if (dirs[k] == 6) {//down
                    System.out.println("6");
                    if (rr + 1 >= row) {
                        continue;
                    }
                    if (nodes[rr + 1][cc].visited == false) {
                        line(nodes[rr][cc].x, nodes[rr][cc].y, nodes[rr + 1][cc].x, nodes[rr + 1][cc].y);
                        nodes[rr][cc].dir[1] = true;
                        nodes[rr + 1][cc].dir[3] = true;
                        nodes[rr + 1][cc].visited = true;
                        DFS(rr + 1, cc);
                    }

                } else if (dirs[k] == 9) {//left
                    System.out.println("9");
                    if (cc <= 0) {
                        continue;
                    }
                    if (nodes[rr][cc - 1].visited == false) {
                        line(nodes[rr][cc].x, nodes[rr][cc].y, nodes[rr][cc - 1].x, nodes[rr][cc - 1].y);
                        nodes[rr][cc].dir[2] = true;
                        nodes[rr][cc - 1].dir[0] = true;
                        nodes[rr][cc - 1].visited = true;
                        DFS(rr, cc - 1);
                    }

                } else if (dirs[k] == 12) {//up
                    System.out.println("12");
                    if (rr <= 0) {
                        continue;
                    }
                    if (nodes[rr - 1][cc].visited == false) {
                        line(nodes[rr][cc].x, nodes[rr][cc].y, nodes[rr - 1][cc].x, nodes[rr - 1][cc].y);
                        nodes[rr][cc].dir[3] = true;
                        nodes[rr - 1][cc].dir[1] = true;
                        nodes[rr - 1][cc].visited = true;
                        DFS(rr - 1, cc);
                    }
                }
            }
            path = path.substring(0, path.length() - 1); //removing this node name from path variable after we have checked all the conditionss to move
        }

        public String LongestPathFromStart() {
            startx = nodes[startR][startC].x;
            starty = nodes[startR][startC].y;
            String longestPath = nodes[0][0].name; //assigning node a's path 

            for (int i = 0; i < row; i++) {
                for (int j = 0; j < col; j++) {
                    if (longestPath.length() < nodes[i][j].pathFromStart.length()) {
                        longestPath = nodes[i][j].pathFromStart;
                        endR = i;
                        endC = j;
                    }
                    System.out.println(nodes[i][j].name + "'s path: " + nodes[i][j].pathFromStart);
                }
            }
            endx = nodes[endR][endC].x;
            endy = nodes[endR][endC].y;
            System.out.println("Longest path = " + longestPath);
            reqMoves = longestPath.length() - 1;
            return longestPath;
        }

        public int[] generateRandomDirections() {
            int[] randoms = {3, 6, 9, 12};
            return shuffleArray(randoms);
        }

        public int[] shuffleArray(int[] array) {
            int index, temp;
        
            for (int i = array.length - 1; i > 0; i--) {
                index = (int )random(i + 1);
                temp = array[index];
                array[index] = array[i];
                array[i] = temp;
            }
            return array;
        }

        public void startEnd() {
            noStroke();
            fill(0, 255, 0); //start ellipse
            ellipse(startx, starty, gap, gap);
//            fill(0, 0, 255);//end ellipse
//            ellipse(endx, endy, gap, gap);
            image(flag, endx - gap / 3, endy - 1 * gap, 2 * gap, 2 * gap);
            fill(84, 121, 188);//moveable ellipse
            strokeWeight(0);
            ellipse(startx, starty, gap / 2, gap / 2);
        }

        public void coin() {
            for (int i = 0; i < 10; i++) {
                image(coins, nodes[(int) random(row - 1)][(int) random(col - 1)].x - gap / 2, nodes[(int) random(row - 1)][(int) random(col - 1)].y - gap / 3, gap - 3, gap - 3);
            }
        }

        public void backGround() {
            int size = 35;
            background(0);
            fill(25);
            noStroke();
            float preX = 0, preY = 0, curX, curY;
            for (int i = 0; i < 25; i++) {
                curX = random(width);
                curY = random(height);
                ellipse(curX, curY, size, size);
                strokeWeight(1);
                stroke(25);
                if (i != 0) {
                    line(preX, preY, curX, curY);
                }
                preX = curX;
                preY = curY;
            }
        }

        public void Menu() {
            fill(255);
            f = createFont("olivier_demo.ttf", 24);
            textFont(f);
            textSize(75);
            textAlign(CENTER, CENTER);
            text("Maze on Graph", width / 2, height / 5);
            textSize(50);
            text("Play", width / 2, (3 * height) / 6);
            text("Generate Maze", width / 2, (4 * height) / 6);
            text("Quit", width / 2, (5 * height) / 6);
        }

    }
