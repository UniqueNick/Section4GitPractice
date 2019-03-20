public class S3P2Script {
    public static void Run() {
        List<String> first = new List<String> {
            'Alpha','Bravo','Charlie','Delta','Echo','Foxtrot','Golf','Hotel','India','Juliet','Kilo','Lima'
        };
        List<String> second = new List<String>();
        
        for (String str : first) {
            second.add(MyStringProcessor.addPrefix(str)); 
        }
        
        System.debug(second);
        second.clear();
        MyStringProcessor.updateList(first, second);
        System.debug(second);
    }
}