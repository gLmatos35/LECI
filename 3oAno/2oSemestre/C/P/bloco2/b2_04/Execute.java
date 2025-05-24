@SuppressWarnings("CheckReturnValue")
public class Execute extends CalculatorBaseVisitor<Integer> {

   @Override public Integer visitStat(CalculatorParser.StatContext ctx) {
      Integer res = visit(ctx.expr());

      if (res != null) {
         System.out.println("Resultado: " + res);
      }
      return res;
   }

   @Override public Integer visitExprAddSub(CalculatorParser.ExprAddSubContext ctx) {
      Integer res = null;
      Integer e1 = visit(ctx.expr(0));
      Integer e2 = visit(ctx.expr(1));
      String op = ctx.op.getText();

      if (e1 != null && e2 != null) {
         switch(op) {
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

   @Override public Integer visitExprMultDivMod(CalculatorParser.ExprMultDivModContext ctx) {
      Integer res = null;
      Integer e1 = visit(ctx.expr(0));
      Integer e2 = visit(ctx.expr(1));
      String op = ctx.op.getText();

      if (e1 != null && e2 != null) {
         switch(op) {
            case "*":
               res = e1 * e2;
               break;
            case "/":
               res = e1 / e2;
               break;
            case "%":
               res = e1 % e2;
            default: 
               return null;
         }
      }

      return res;
   }

   @Override public Integer visitExprUnary(CalculatorParser.ExprUnaryContext ctx) {
      String signal = ctx.op.getText();
      Integer num = visit(ctx.expr());
      Integer res = null;
      if (signal.equals("-")) {
         res = -num;
      } else {
         res = num;
      }
      return res;
   }

   @Override public Integer visitExprInteger(CalculatorParser.ExprIntegerContext ctx) {
      return Integer.parseInt(ctx.Integer().getText());
   }

   @Override public Integer visitExprPar(CalculatorParser.ExprParContext ctx) {
      return visit(ctx.expr());
   }
}
