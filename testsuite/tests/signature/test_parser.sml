structure TestSignatureParser =
struct
  open Sum

  val message = "signature_parser_test has failed"
  val () = OS.FileSys.chDir "testsuite/tests/signature/"
  val input = TextIO.inputAll (TextIO.openIn "signature_parser_test.jonprl")

  val parsed = CharParser.parseString SignatureParser.parseSigExp input

  open AstSignatureDecl


  val paramsToString =
    ListSpine.pretty
      (fn (u, tau) => u ^ " : " ^ Sort.Show.toString tau)
      ","

  val argsToString =
    ListSpine.pretty
      (fn (m, vl) => Metavariable.Show.toString m ^ " : " ^ Valence.Show.toString vl)
      ";"

  fun printDecl (lbl, DEF {parameters, arguments, definiens, sort}) =
    print
      ("Def "
         ^ lbl
         ^ "[" ^ paramsToString parameters ^ "]"
         ^ "(" ^ argsToString arguments ^ ")"
         ^ " : " ^ Sort.Show.toString sort
         ^ " = ["
         ^ Ast.Show.toString definiens
         ^ "].\n")

  local
    open AstSignature.Telescope
  in
    fun printSign sign =
      case ConsView.out sign of
          ConsView.Cons (l, d, sign') =>
            (printDecl (l, d); printSign sign')
        | ConsView.Empty => ()
  end


  val () =
    case parsed of
        INL s => raise Fail (message ^ ": " ^ s)
      | INR t => printSign t
end