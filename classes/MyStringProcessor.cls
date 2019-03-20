public class MyStringProcessor implements IStringProcessor {
    public static String addPrefix(String str) {
        return 'Team ' + str; 
    }
    
    public static String addPostfix(String str) {
        return str + ' Go!Go!Go!'; 
    }
    
    public static String removeWhitespaces(String str) {
        return str.remove(' '); 
    }
    
    public static void updateList (List<String> sour, List<String> dest) {
        for (String str : sour) {
            dest.add(addPostfix(str)); 
        }
    }
}