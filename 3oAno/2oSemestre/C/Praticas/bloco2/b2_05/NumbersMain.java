import java.lang.System.*;
import java.io.*;
import java.util.*;

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class NumbersMain {
   final static Scanner sc = new Scanner(System.in);

   public static void main(String[] args) {
      InputStream in_stream = null;
      NumberMappings mappings = new NumberMappings();
      try {
         in_stream = new FileInputStream(new File("numbers.txt"));
      } 
      catch(FileNotFoundException e) {
         System.err.println("ERROR: reading number file!");
         System.exit(1);
      }

      try{   
         // create a CharStream that reads from standard input:
         CharStream input = CharStreams.fromStream(in_stream);
         // create a lexer that feeds off of input CharStream:
         NumbersLexer lexer = new NumbersLexer(input);
         // create a buffer of tokens pulled from the lexer:
         CommonTokenStream tokens = new CommonTokenStream(lexer);
         // create a parser that feeds off the tokens buffer:
         NumbersParser parser = new NumbersParser(tokens);
         // replace error listener:
         //parser.removeErrorListeners(); // remove ConsoleErrorListener
         //parser.addErrorListener(new ErrorHandlingListener());
         // begin parsing at file rule:
         ParseTree tree = parser.file();
         if (parser.getNumberOfSyntaxErrors() == 0) {
            // print LISP-style tree:
            // System.out.println(tree.toStringTree(parser));
            ParseTreeWalker walker = new ParseTreeWalker();
            // NumbersBaseListener listener0 = new NumbersBaseListener();
            
            // walker.walk(listener0, tree);
            walker.walk(mappings, tree);
         }
      }
      catch(IOException e) {
         e.printStackTrace();
         System.exit(1);
      }
      catch(RecognitionException e) {
         e.printStackTrace();
         System.exit(1);
      }

      while(sc.hasNextLine()) {
         String line = sc.nextLine();
         String processedLine = line.replace('-',' ');
         Scanner scline = new Scanner(processedLine);
         while(scline.hasNext()) {
            String output = scline.next();
            String text = output.toLowerCase();

            if (mappings.exists(text)) {
               output  = mappings.value(text).toString();
            }
            System.out.print(output + " ");

         }
         System.out.println();
      }

   }
}
