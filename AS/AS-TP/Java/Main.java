import javax.swing.*;
import java.io.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main {

    public static void main(String[] args) {
        String url = JOptionPane.showInputDialog(null, "Taper l'adresse vers le fichier !");

        Main.regexHTTPUrl(url);

    }


    public static void regexHTTPUrl(String url) {
        String all = null;
        BufferedReader bufferedReader = null;
        try {
            bufferedReader = new BufferedReader(new FileReader(url));

            StringBuilder stringBuilder = new StringBuilder();
            String line = bufferedReader.readLine();

            while (line != null) {
                if(Main.isInPattern(line)) {
                    stringBuilder.append(line);
                    stringBuilder.append(Main.info(line));
                    stringBuilder.append(System.lineSeparator());
                }
                line = bufferedReader.readLine();
            }

            all = stringBuilder.toString();

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                bufferedReader.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        System.out.println(all);
    }

    public static boolean isInPattern(String line){
        Pattern p = Pattern.compile("^(http)://[a-zA-Z]+:[a-zA-Z]+@[a-zA-Z.]+:[0-9]{1,5}(/.*)+?$");
        Matcher matcher = p.matcher(line);
        return matcher.find();
    }

    public static String info(String line){
        String newLine = "";

        String sub = line.substring(7, line.length());

        Pattern pattern = Pattern.compile(":|@|/");

        String tab[] = pattern.split(sub);

        if(tab.length > 4) {
            for(int i = 5; i < tab.length; i++) {
                tab[4] += "/" + tab[i];
            }
        }

        newLine = "\n users: " + tab[0] +
                "\n password: " + tab[1] +
                "\n machine: " + tab[2] +
                "\n port: " + tab[3] +
                "\n path: "+ tab[4];

        return newLine;
    }
}
