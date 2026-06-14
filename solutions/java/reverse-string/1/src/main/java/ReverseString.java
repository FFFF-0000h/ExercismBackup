class ReverseString {

    String reverse(String inputString) {
        StringBuilder reversed = new StringBuilder();
        
        for (int i = inputString.length() - 1; i >= 0; i--) {
            reversed.append(inputString.charAt(i));
        }
        
        return reversed.toString();
    }
  
}