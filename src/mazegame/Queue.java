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
public class Queue {
        Element head;
    Element tail;

    Queue() {
     head=tail=null;
    }
    public void delete(){
    head=tail=null;
    }
    public void enQueue(int r, int c) {
        Element n =new Element(r,c);
        if(head==null){
        head=tail=n;}
        else{
            tail.next=n;
            tail=n;
        }
    }


    public Element deQueue() {
        Element temp=head;
if(head==tail){
head=null;
}else{
        head=head.next;
}  return temp;
    }

}
