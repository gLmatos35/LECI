import java.util.Iterator;

@SuppressWarnings("CheckReturnValue")
public class Execute extends HelloBaseVisitor<String> {

   @Override public String visitMain(HelloParser.MainContext ctx) {
      return visitChildren(ctx);
   }

   @Override public String visitGreetings(HelloParser.GreetingsContext ctx) {
      String name = visit(ctx.name());
      System.out.println("Olá " + name);
      return name;
   }

   @Override public String visitFarewells(HelloParser.FarewellsContext ctx) {
      String name = visit(ctx.name());
      System.out.println("Adeus " + name);
      return name;
   }

   @Override public String visitName(HelloParser.NameContext ctx) {
      String name = "";
      Iterator<HelloParser.WordContext> iterator = ctx.word().iterator();
      while(iterator.hasNext()) {
         name += (name.isEmpty()? "" : " ") + visit(iterator.next());
      }
      return name;
   }

   @Override public String visitWord(HelloParser.WordContext ctx) {
      return ctx.ID().getText();
   }
}