class SqueakyClean {
    static String clean(String identifier) {
        // Step 1: replace all spaces with underscores
        String s = identifier.replace(' ', '_');

        // Step 2: convert kebab-case to camelCase
        StringBuilder sb = new StringBuilder();
        boolean capitalizeNext = false;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '-') {
                capitalizeNext = true;
            } else {
                if (capitalizeNext) {
                    c = Character.toUpperCase(c);
                    capitalizeNext = false;
                }
                sb.append(c);
            }
        }

        // Step 3: replace leetspeak digits with normal letters
        String s2 = sb.toString();
        sb = new StringBuilder();
        for (int i = 0; i < s2.length(); i++) {
            char c = s2.charAt(i);
            switch (c) {
                case '4': c = 'a'; break;
                case '3': c = 'e'; break;
                case '0': c = 'o'; break;
                case '1': c = 'l'; break;
                case '7': c = 't'; break;
            }
            sb.append(c);
        }

        // Step 4: keep only letters and underscores
        String s3 = sb.toString();
        sb = new StringBuilder();
        for (int i = 0; i < s3.length(); i++) {
            char c = s3.charAt(i);
            if (Character.isLetter(c) || c == '_') {
                sb.append(c);
            }
        }

        return sb.toString();
    }
}