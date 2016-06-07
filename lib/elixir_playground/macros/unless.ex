defmodule Unless do
  def fun_unless(clause, expression) do
    if(!clause, do: expression.("bla bla!"))
  end

  defmacro ifnot(clause, expression) do
    quote do
      if(!unquote(clause), do: unquote(expression))
    end
  end
end

defmodule Tester do
  import Unless

  def do_test do
    satisfied = false

    ifnot satisfied do
      IO.inspect("not satisfied >:(")
    end

    fun_unless satisfied, &IO.inspect/1
  end
end

Tester.do_test
