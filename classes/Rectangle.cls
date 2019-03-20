public class Rectangle {
    private Double widgth;
    private Double heigth;

    public Boolean setSides(Double widgth, Double heigth) {
        if ((widgth <= 0) || (heigth <= 0)) 
            return false;
        
        this.widgth = widgth;
        this.heigth = heigth;
        
        return true;
    }
    
    private String checkDataValidity() {
        if (widgth == null) return 'No widght specified';
        if (heigth == null) return 'No height specified';
        
        return '';
    }
    
    public String square() {
        String check = checkDataValidity();
        if (check.length() == 0)
            return String.valueOf(heigth * widgth);
        
        return check;
    }
    
    public String perimeter() {
        String check = checkDataValidity();
        if (check.length() == 0)
            return String.valueOf((heigth + widgth) * 2);
        
        return check;
    }
    
    public Boolean isSquare() {
        return heigth == widgth;
    }
}