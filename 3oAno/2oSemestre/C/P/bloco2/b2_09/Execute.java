@SuppressWarnings("CheckReturnValue")
public class Execute extends CalcFracBaseVisitor<Integer> {

   @Override public Integer visitMain(CalcFracParser.MainContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitStat(CalcFracParser.StatContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitPrint(CalcFracParser.PrintContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitDefVar(CalcFracParser.DefVarContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitReduce(CalcFracParser.ReduceContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitSumSub(CalcFracParser.SumSubContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitInput(CalcFracParser.InputContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitParent(CalcFracParser.ParentContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitPrdDiv(CalcFracParser.PrdDivContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitVarExpr(CalcFracParser.VarExprContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitFrac(CalcFracParser.FracContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }

   @Override public Integer visitNum(CalcFracParser.NumContext ctx) {
      Integer res = null;
      return visitChildren(ctx);
      //return res;
   }
}
