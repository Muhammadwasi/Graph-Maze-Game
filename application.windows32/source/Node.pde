public class Node {

        float x, y, gap; //center coordinate and width,height of node
        boolean[] dir; // dir=up,right,down,left or connections
        boolean visited; // to check wether the node is visited or not during DFS
        String name; //name of node to find the longest path
        String pathFromStart;//path of every node from starting node A

        public Node(float xx, float yy, float gapp, int namee) {
            x = xx;
            y = yy;
            pathFromStart = "";
            name = ((char) namee) + ""; //we got ascii no. of char
            gap = gapp;
            visited = false;
            dir = new boolean[4];
            dir[0] = dir[1] = dir[2] = dir[3] = false; //0=right,down=1,left=2,up=3
        }

        public void drawNode() {
            noStroke();
            fill(155); //make the node inn black color
            ellipse(x, y, gap, gap); //draw node
        }
    }
