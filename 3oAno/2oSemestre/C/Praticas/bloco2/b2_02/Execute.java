@SuppressWarnings("CheckReturnValue")
public class Execute extends SuffixCalculatorBaseVisitor<Float> {

   @Override public Float visitStat(SuffixCalculatorParser.StatContext ctx) {
      Float res = visit(ctx.expr());
      if (res != null) {
         System.out.println("Resultado: " + res);
      }
      return res;
   }

   @Override public Float visitExprSuffix(SuffixCalculatorParser.ExprSuffixContext ctx) {
      Float res = null;
      Float e1 = visit(ctx.expr(0));
      Float e2 = visit(ctx.expr(1));
      String op = ctx.op.getText();

      if (e1 != null && e2 != null) {
         switch(op) {
            case "*":
               res = e1 * e2;
               break;
            case "/":
               res = e1 / e2;
               break;
            case "+":
               res = e1 + e2;
               break;
            case "-":
               res = e1 - e2;
               break;
            default: 
               return null;
         }
      }

      return res;
   }

   @Override public Float visitExprNumber(SuffixCalculatorParser.ExprNumberContext ctx) {
      return Float.parseFloat(ctx.Number().getText());
   }
}
