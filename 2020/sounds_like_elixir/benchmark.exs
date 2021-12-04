Benchee.run(%{
  "orig"      => fn -> Dec11.perform end,
  "optimized" => fn -> Dec11Optim.perform end
})
