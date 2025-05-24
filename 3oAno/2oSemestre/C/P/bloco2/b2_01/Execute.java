import java.util.Iterator;

@SuppressWarnings("CheckReturnValue")
public class Execute extends HelloBaseVisitor<String> {

   @Override public String visitMain(HelloParser.MainContext ctx) {
      String res = null;
      return visitChildren(ctx);
      //return res;

   }

   @Override public String visitGreetings(HelloParser.GreetingsContext ctx) {
      // String res = null;
      // return visitChildren(ctx);
      //return res;
      String name = visit(ctx.name());
      System.out.println("Olá " + name);
      return name;
   }

   @Override public String visitBye(HelloParser.ByeContext ctx) {
      // String res = null;
      // return visitChildren(ctx);
      //return res;
      String name = visit(ctx.name());
      System.out.println("Adeus " + name);
      return name;
   }

   @Override public String visitName(HelloParser.NameContext ctx) {
      // String res = null;
      // return visitChildren(ctx);
      //return res;
      String res = "";
      Iterator<HelloParser.WordContext> iterator = ctx.word().iterator();
      while(iterator.hasNext()) {
         res += (res.isEmpty() ? "" : " ") + visit(iterator.next());
      }
      return res;
   }

   @Override public String visitWord(HelloParser.WordContext ctx) {
      String res = null;
      // return visitChildren(ctx);
      //return res;
      return ctx.ID().getText();
   }
}
