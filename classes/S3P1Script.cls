public class S3P1Script {
    public static void Run() {
        for (Integer i = 1; i < 10; i++) {
            Rectangle rect = new Rectangle();
            rect.setSides(2,2);
            System.debug('Rectangle perimeter ' + rect.perimeter());
            System.debug('Rectangle square ' + rect.square());
        }
    }
    
    public static void RunAdvanced() {
        for (Integer i = 1; i < 10; i++) {
            Rectangle rect = new Rectangle();
            rect.setSides(i,i);
            System.debug('Rectangle perimeter ' + rect.perimeter());
            System.debug('Rectangle square ' + rect.square());
            if (rect.isSquare())
                System.debug('This rectangle is square actually');
        }
    }
}