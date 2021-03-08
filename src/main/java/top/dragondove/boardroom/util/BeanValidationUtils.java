package top.dragondove.boardroom.util;

public class BeanValidationUtils {

    public static boolean invalidatePassword(String password) {
        if (password.length() < 6 || password.length() > 16) {
            return true;
        }
        boolean noDigit = true, noLetter = true;
        for (int i = 0; i < password.length(); i++) {
            if (Character.isDigit(password.charAt(i))) {
                noDigit = false;
            }
            if (Character.isLetter(password.charAt(i))) {
                noLetter = false;
            }
        }
        return noDigit || noLetter;
    }

}
