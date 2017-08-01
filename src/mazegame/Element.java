/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mazegame;

/**
 *
 * @author Mypca
 */
public class Element {

    int r;
    int c;
    Element next;

    public Element(int r, int c) {
        this.r = r;
        this.c = c;
    }
}
