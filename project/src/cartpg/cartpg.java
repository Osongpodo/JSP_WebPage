package cartpg;

import java.io.Serializable;

public class cartpg implements Serializable {

    private static final long serialVersionUID = 1L;
    private String name;    
    private String price;   

    public cartpg() {}

    public cartpg(String name, String price) {
        super();
        this.name = name;
        this.price = price;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getPrice() {
        return price;
    }
    public void setPrice(String price) {
        this.price = price;
    }
    public static long getSerialversionuid() {  
        return serialVersionUID;
    }
}
