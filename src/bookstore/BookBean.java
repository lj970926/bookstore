package bookstore;

import java.io.Serializable;

public class BookBean implements Serializable {
    private static final long serialVersionUID = 1L;
    private int bid;
    private String name;
    private double price;
    private int number;
    public int getBid(){
        return this.bid;
    }
    public String getName(){
        return this.name;
    }
    public double getPrice(){
        return this.price;
    }
    public int getNumber(){
        return this.number;
    }
    public void setBid(int id){
        this.bid = id;
    }
    public void setName(String name){
        this.name = name;
    }
    public void setPrice(double p){
        this.price = p;
    }
    public void setNumber(int n){
        this.number = n;
    }
}
